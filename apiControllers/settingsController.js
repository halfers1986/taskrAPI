const conn = require("../utils/dbconn");
const bcrypt = require("bcryptjs");

exports.getSettings = async (req, res) => {
    const userId = req.params.userID;

    try {
        // Fetch the user's settings
        const sql = `SELECT
        user_username,
        user_first_name,
        user_last_name,
        user_email
        FROM user
        WHERE user.user_id = ?`;
        let [settings] = await conn.query(sql, [userId]);

        if (settings.length === 0) {
            return res.status(404).json({ message: "User settings not found" });
        }

        console.log(settings);

        const categorySql = `SELECT
        category_name,
        category_id
        FROM category
        WHERE category_user_id = ?`;
        const [results] = await conn.query(categorySql, [userId]);

        // Not all users will have categories set up so don't throw an error if none are found
        // Instead, just send an empty array to the client
        const categories = results.length > 0 ? results : [];
        settings = settings[0];

        // Return the user's settings
        return res.status(200).json({ settings, categories });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

exports.updateDetails = async (req, res) => {
    const userId = req.params.userID;
    const { username, firstName, lastName, email } = req.body;

    console.log(username, firstName, lastName, email);

    if (!username && !firstName && !lastName && !email) {
        return res.status(400).json({ message: "Please provide at least one field to update" });
    }

    if (username) {
        // Check if the username is already taken
        const checkUsername = `SELECT user_id FROM user WHERE user_username = ?`;
        const [existingUsername] = await conn.query(checkUsername, [username]);
        if (existingUsername.length > 0) {
            return res.status(400).json({ message: "Username is already taken" });
        }
    }

    const updates = [];
    const values = [];

    if (username) {
        updates.push("user_username = ?");
        values.push(username);
    }
    if (firstName) {
        updates.push("user_first_name = ?");
        values.push(firstName);
    }
    if (lastName) {
        updates.push("user_last_name = ?");
        values.push(lastName);
    }
    if (email) {
        updates.push("user_email = ?");
        values.push(email);
    }

    values.push(userId);

    try {
        // Update the user's details
        const sql = `UPDATE user
        SET ${updates.join(", ")}
        WHERE user_id = ?`;
        const results = await conn.query(sql, values);

        if (results[0].affectedRows === 0) {
            return res.status(404).json({ message: "User not found" });
        }

        // Return a success message
        return res.status(200).json({ message: "User details updated successfully" });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
}

exports.updatePassword = async (req, res) => {
    const userId = req.params.userID;
    const { currentPassword, newPassword } = req.body;

    if (!currentPassword || !newPassword) {
        return res.status(400).json({ message: "Please provide all required fields" });
    }

    try {
        // Check if the current password is correct
        // Check the database for the user & get the hashed password
        const checkUserSql = "SELECT user_password FROM user WHERE user_id = ?";
        const [results] = await conn.query(checkUserSql, [userId]);

        // Return an error if the user doesn't exist or the password is incorrect
        if (results.length === 0 || !bcrypt.compareSync(currentPassword, results[0].user_password)) {
            return res.status(401).json({ message: "Invalid user or password" });
        }

        // Update the user's password
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(newPassword, salt);
        const sql = `UPDATE user
        SET user_password = ?
        WHERE user_id = ?`;
        results = await conn.query(sql, [hash, userId]);

        if (results[0].affectedRows === 0) {
            return res.status(404).json({ message: "User not found" });
        }

        // Return a success message
        return res.status(200).json({ message: "Password updated successfully" });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

exports.addCategory = async (req, res) => {
    const userId = req.params.userID;
    const { newCategory } = req.body;

    if (!newCategory) {
        return res.status(400).json({ message: "Please provide all required fields" });
    }

    try {
        // Add the new category
        const sql = `INSERT INTO category (category_name, category_user_id)
        VALUES (?, ?)`;
        const [results] = await conn.query(sql, [newCategory, userId]);

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: "User not found" });
        }

        const categoryID = results.insertId;

        // Return a success message
        return res.status(201).json({ message: "Category added successfully", categoryID });

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

exports.deleteCategory = async (req, res) => {
    const categoryId = req.body.categoryID;
    const userId = req.params.userID;

    try {
        // Delete the category
        const sql = `DELETE FROM category WHERE category_id = ? AND category_user_id = ?`;
        const results = await conn.query(sql, [categoryId, userId]);

        if (results[0].affectedRows === 0) {
            return res.status(404).json({ message: "Category not found for this user" });
        }

        // Return a success message
        return res.status(200).json({ message: "Category deleted successfully" });

    } catch (error) {
        if (error.code === "ER_ROW_IS_REFERENCED_2") {
            return res.status(409).json({ message: "Cannot delete category that is in use." });
        }
        return res.status(500).json({ message: error.message });
    }
};

exports.deleteAccount = async (req, res) => {
    const userId = req.params.userID;
    const { password } = req.body;

    if (!password) {
        return res.status(400).json({ message: "Please provide all required fields" });
    }

    let connection;
    try {

        // Check if the password is correct
        // Check the database for the user & get the hashed password
        const checkUserSql = "SELECT user_password FROM user WHERE user_id = ?";
        const [results] = await conn.query(checkUserSql, [userId]);

        // Return an error if the user doesn't exist or the password is incorrect
        if (results.length === 0 || !bcrypt.compareSync(password, results[0].user_password)) {
            return res.status(401).json({ message: "Invalid user or password" });
        }

        // Else, continue with the deletion
        // Get a connection from the pool
        connection = await conn.getConnection();

        // Start a transaction to ensure that all queries succeed or fail together
        await connection.beginTransaction();

        // Check what needs to be deleted
        let tasksCount;
        let subtasksCount;
        let shoppingListCount;
        let customCategoriesCount;

        const tasksSql = "SELECT COUNT(*) AS tasksCount FROM task WHERE task_user_id = ?";
        let [tasksCountResults] = await connection.query(tasksSql, [userId]);
        tasksCount = tasksCountResults[0].tasksCount;

        const subtasksSql = "SELECT COUNT(*) AS subtasksCount FROM subtask WHERE subtask_user_id = ?";
        let [subtasksCountResults] = await connection.query(subtasksSql, [userId]);
        subtasksCount = subtasksCountResults[0].subtasksCount;

        const shoppingListSql = "SELECT COUNT(*) AS shoppingListCount FROM list_item WHERE list_item_user_id = ?";
        let [shoppingListCountResults] = await connection.query(shoppingListSql, [userId]);
        shoppingListCount = shoppingListCountResults[0].shoppingListCount;

        const customCategoriesSql = "SELECT COUNT(*) AS customCategoriesCount FROM category WHERE category_user_id = ?";
        let [customCategoriesCountResults] = await connection.query(customCategoriesSql, [userId]);
        customCategoriesCount = customCategoriesCountResults[0].customCategoriesCount;

        // Delete the user's subtasks
        const deleteSubtasksSql = "DELETE FROM subtask WHERE subtask_user_id = ?";
        const [subtasksDeleted] = await connection.query(deleteSubtasksSql, [userId]);
        if (subtasksDeleted.affectedRows !== subtasksCount) {
            throw new Error("Error deleting subtasks");
        }

        // Delete the user's shopping list items
        const deleteShoppingListSql = "DELETE FROM list_item WHERE list_item_user_id = ?";
        const [shoppingListDeleted] = await connection.query(deleteShoppingListSql, [userId]);
        if (shoppingListDeleted.affectedRows !== shoppingListCount) {
            throw new Error("Error deleting shopping list items");
        }

        // Delete the user's tasks
        const deleteTasksSql = `DELETE FROM task WHERE task_user_id = ?`;
        const [tasksDeleted] = await connection.query(deleteTasksSql, [userId]);
        if (tasksDeleted.affectedRows !== tasksCount) {
            throw new Error("Error deleting tasks");
        }

        // Delete the user's custom categories
        const deleteCategoriesSql = `DELETE FROM category WHERE category_user_id = ?`;
        const [categoriesDeleted] = await connection.query(deleteCategoriesSql, [userId]);
        if (categoriesDeleted.affectedRows !== customCategoriesCount) {
            throw new Error("Error deleting categories");
        }

        // Delete the user
        const deleteUserSql = "DELETE FROM user WHERE user_id = ?";
        const [userDeleted] = await connection.query(deleteUserSql, [userId]);
        if (userDeleted.affectedRows !== 1) {
            throw new Error("Error deleting user");
        }

        // No errors, so commit the transaction
        await connection.commit();

        // Return a success message
        res.status(200).json({ message: "User deleted successfully" });

    } catch (error) {
        // Rollback the transaction if an error occurs
        await connection.rollback();
        console.log(error);
        return res.status(500).json({ message: error.message });
    }
};
