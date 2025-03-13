const conn = require("../utils/dbconn");

// Handles the GET /tasks/ API route
exports.getTasks = async (req, res) => {
  
  const userID = req.params.userID;

  try {
    // Fetch tasks
    const sql = `
      SELECT task.*, category.category_name 
      FROM task 
      LEFT JOIN category ON task.task_category_id = category.category_id 
      WHERE task.task_user_id = ? 
      ORDER BY task_created_timestamp DESC
    `;
    const [results] = await conn.query(sql, [userID]); // Fetch all tasks

    // console.log("Fetched tasks: ", results);

    // Fetch subtasks for each task in parallel
    await Promise.all(
      results.map(async (task) => {
        const taskID = task.task_id;
        const taskType = task.task_type_id;
        if (taskType === 1) {
          const subtaskSQL = `SELECT * FROM subtask WHERE subtask_task_id = ${taskID}`;
          const [subtasks] = await conn.query(subtaskSQL); // Fetch subtasks
          subtasks.forEach((subtask) => {
            if (subtask.subtask_due_date !== null) {
              const date = new Date(subtask.subtask_due_date);
              subtask.subtask_due_date_formatted = date.toLocaleDateString("en-GB"); // Format to DD/MM/YYYY
            } else {
              subtask.subtask_due_date_formatted = null;
            }
            const priorityText = ["None", "Low", "Medium", "High"];
            subtask.subtask_priority_text = priorityText[subtask.subtask_priority_id];
          });
          task.subtasks = subtasks; // Attach subtasks to task
        } else if (taskType === 2) {
          const listSQL = `SELECT * FROM list_item WHERE list_item_task_id = ${taskID}`;
          const [listItems] = await conn.query(listSQL); // Fetch list items
          task.listItems = listItems; // Attach list items to task
        }
      })
    );

    // Fetch user-defined categories (for rendering the filter dropdown)
    const settingsSQL = "SELECT * FROM category WHERE category_user_id = ?";
    const [settings] = await conn.query(settingsSQL, [userID]);
    // Not all users will have categories set up so don't throw an error if none are found
    // Instead, just send an empty array to the client
    const categories = settings.length > 0 ? settings : [];

    // Format due dates on the tasks
    results.forEach((task) => {
      if (task.task_due_date !== null) {
        const date = new Date(task.task_due_date);
        task.task_due_date_formatted = date.toLocaleDateString("en-GB"); // Format to DD/MM/YYYY
      } else {
        task.task_due_date_formatted = null;
      }
    });

    // Format completed timestamps on the tasks
    results.forEach((task) => {
      if (task.task_completed_timestamp !== null) {
        console.log(task.task_completed_timestamp);
        const date = new Date(task.task_completed_timestamp);
        task.task_completed_timestamp_formatted = date.toLocaleDateString("en-GB"); // Format to DD/MM/YYYY
        console.log(task.task_completed_timestamp_formatted);
      } else {
        task.task_completed_timestamp_formatted = null;
      }
    });

    // console.log(results, categories);

    // Return the tasks and categories to the client
    res.status(200).json({ tasks: results, categories });

  } catch (err) {
    console.error("Error fetching tasks or subtasks:", err);
    res.status(500).send("An error occurred");
  }
};

// Handles the POST /add-task API route
exports.addTask = async (req, res) => {
  const { type, title, description, category, priority, dueDate, subtasks, shoppingListItems, userID } = req.body;

  // Validate the input
  if (!type || !title) {
    return res.status(400).json({ message: "Invalid input" });
  }

  // Start a transaction to ensure that all queries succeed or fail together
  let connection; // Connection object for transaction
  try {
    // Get a connection from the pool
    connection = await conn.getConnection();

    // Start a transaction
    await connection.beginTransaction();

    // Insert new task into database
    const taskSQL = "INSERT INTO task (task_type_id, task_title, task_description, task_category_id, task_priority_id, task_due_date, task_user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
    const [taskResults] = await connection.query(taskSQL, [type, title, description, category, priority, dueDate, userID]);

    if (taskResults.affectedRows === 0) {
      await connection.rollback();
      return res.status(404).json({ message: "Could not add task." });
    }

    let taskID = taskResults.insertId;

    // -- Insert new subtasks into database --
    if (subtasks) {
      const subtaskSQL = "INSERT INTO subtask (subtask_task_id, subtask_description, subtask_due_date, subtask_priority_id, subtask_user_id) VALUES ?";
      const subtaskData = subtasks.map((subtask) => [taskID, subtask.name, subtask.dueDate, subtask.priority, userID]);
      const [subtaskResults] = await connection.query(subtaskSQL, [subtaskData]);
      if (subtaskResults.affectedRows === 0) {
        await connection.rollback();
        return res.status(404).json({ message: "Could not add subtask." });
      }
    }
    if (shoppingListItems) {
      const shoppingListSQL = "INSERT INTO list_item (list_item_task_id, list_item_name, list_item_quantity, list_item_store, list_item_user_id) VALUES ?";
      const shoppingListData = shoppingListItems.map((item) => [taskID, item.name, item.count, item.store, userID]);
      const [shoppingListResults] = await connection.query(shoppingListSQL, [shoppingListData]);
      if (shoppingListResults.affectedRows === 0) {
        await connection.rollback();
        return res.status(404).json({ message: "Could not add shopping list item." });
      }
    }

    // Commit the transaction
    await connection.commit();

    // Fetch the newly added task
    const sql = `
      SELECT task.*, category.category_name 
      FROM task 
      LEFT JOIN category ON task.task_category_id = category.category_id 
      WHERE task.task_id = ${taskID}`;
    const [results] = await connection.query(sql);
    console.log("New task: ", results);
    const task = results[0];

    // Fetch any subtasks or list items for the new task
    const taskType = task.task_type_id;
    if (taskType === 1) {
      const subtaskSQL = `SELECT * FROM subtask WHERE subtask_task_id = ${taskID}`;
      const [subtasks] = await conn.query(subtaskSQL); // Fetch subtasks
      subtasks.forEach((subtask) => {
        // Format due dates for the subtasks
        if (subtask.subtask_due_date !== null) {
          const date = new Date(subtask.subtask_due_date);
          subtask.subtask_due_date_formatted = date.toLocaleDateString("en-GB"); // Format to DD/MM/YYYY
        } else {
          subtask.subtask_due_date_formatted = null;
        }
        const priorityText = ["None", "Low", "Medium", "High"];
        subtask.subtask_priority_text = priorityText[subtask.subtask_priority_id];
      });
      task.subtasks = subtasks; // Attach subtasks to task
    } else if (taskType === 2) {
      const listSQL = `SELECT * FROM list_item WHERE list_item_task_id = ${taskID}`;
      const [listItems] = await conn.query(listSQL); // Fetch list items
      task.listItems = listItems; // Attach list items to task
    }

    // Format due dates on the task
    if (task.task_due_date !== null) {
      const date = new Date(task.task_due_date);
      task.task_due_date_formatted = date.toLocaleDateString("en-GB"); // Format to DD/MM/YYYY
    } else {
      task.task_due_date_formatted = null;
    }

    console.log("New task with subtasks (if applicable): ", task);

    // Return success message and the newly created task
    res.status(201).json({ task });

  } catch (err) {
    if (connection) {
      // Rollback the transaction if an error occurred
      await connection.rollback();
    }
    console.error("Error adding task:", err);
    res.status(500).json({ message: "Failed to add task" });
  } finally {
    // Release the connection back to the pool
    if (connection) {
      connection.release();
    }
  }
};

// Handles the PATCH /edit-task/:id API route
exports.updateTask = async (req, res) => {
  const { id } = req.params;
  // console.log(req.body);
  const { title, description, dueDate, priority, category, userID } = req.body;
 
  let connection; // Connection object for transaction

  try {
    // Create & store query parameters & values
    const updates = [];
    const values = [];

    if (title) {
      updates.push("task_title = ?");
      values.push(title);
    }
    if (description) {
      updates.push("task_description = ?");
      values.push(description);
    }
    if (dueDate) {
      updates.push("task_due_date = ?");
      values.push(dueDate);
    }
    if (priority) {
      updates.push("task_priority_id = ?");
      values.push(priority);
    }
    if (category) {
      updates.push("task_category_id = ?");
      values.push(category);
    }

    console.log("Updates: ", updates);
    console.log("Values: ", values);

    // Check if there's anything to update
    if (updates.length === 0) {
      return res.status(400).json({ message: "No valid fields provided to update" });
    }

    // Get a connection from the pool
    connection = await conn.getConnection();

    // Begin transaction
    await connection.beginTransaction();

    // Construct query dynamically
    const sql = `UPDATE task SET ${updates.join(", ")} WHERE task_id = ? AND task_user_id = ?`;

    const [results] = await connection.query(sql, values.concat([id, userID]));

    if (results.affectedRows === 0) {
      await connection.rollback();
      return res.status(404).json({ message: "Task not found." });
    }

    // Commit the transaction
    await connection.commit();

    // Return success message
    res.json({ message: "Task updated successfully" });

  } catch (err) {
    console.error("Error updating task:", err);
    res.status(500).json({ message: "Failed to update task" });
  } finally {
    // Release the connection back to the pool
    if (connection) {
      connection.release();
    }
  }
};

// Handles the PATCH /task-status/:id API route
exports.updateTaskCompletion = async (req, res) => {
  const taskID = req.params.id;
  const { completed, userID } = req.body;

  try {
    // Validate the input
    if (completed === undefined) {
      return res.status(400).json({ message: "Invalid input" });
    }

    // Update database
    let sql;
    let results;

    if (completed === true) {
      // Mark task as complete
      sql = "UPDATE task SET task_complete = ?, task_completed_timestamp = NOW() WHERE task_id = ? AND task_user_id = ?";
      [results] = await conn.query(sql, [completed, taskID, userID]);
    } else {
      // Mark task as incomplete
      sql = "UPDATE task SET task_complete = ?, task_completed_timestamp = NULL WHERE task_id = ? AND task_user_id = ?";
      [results] = await conn.query(sql, [completed, taskID, userID]);
    }
    // console.log(sql, results);

    // If no rows were updated, task not found, return 404
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Task not found." });
    }

    // If task set to complete, get the timestamp
    if (completed === true) {
      sql = "SELECT task_completed_timestamp FROM task WHERE task_id = ?";
      [results] = await conn.query(sql, [taskID]);
    }

    // Return success message
    if (completed === true) {
      return res.status(200).json({ message: "Task updated to complete", taskCompletedTimestamp: results[0].task_completed_timestamp });
    } else {
      return res.status(200).json({ message: "Task updated to incomplete" });
    }
  } catch (err) {
    console.error("Error updating task:", err);
    res.status(500).json({ message: "Failed to update task" });
  }
};

// Handles the DELETE /delete-task/:id API route
exports.deleteTask = async (req, res) => {
  const { taskType, userID } = req.body;
  const taskID = req.params.id;

  // Validate the input
  if (!taskID) {
    return res.status(400).json({ message: "Invalid input - no task ID" });
  }
  if (!taskType) {
    return res.status(400).json({ message: "Invalid input - no task type" });
  }

  let connection; // Connection object for transaction
  try {
    // Get a connection from the pool
    connection = await conn.getConnection();

    // Start a transaction to ensure that both queries succeed or fail together
    await connection.beginTransaction();

    // Check if there are subtasks to delete
    let sqlCheckSubItems;
    let subItemCheckResults;

    if (taskType === "1") {
      sqlCheckSubItems = "SELECT COUNT(*) AS count FROM subtask WHERE subtask_task_id = ? AND subtask_user_id = ?";
      [subItemCheckResults] = await connection.query(sqlCheckSubItems, [taskID, userID]);
    } else if (taskType === "2") {
      sqlCheckSubItems = "SELECT COUNT(*) AS count FROM list_item WHERE list_item_task_id = ? AND list_item_user_id = ?";
      [subItemCheckResults] = await connection.query(sqlCheckSubItems, [taskID, userID]);
    }

    // Delete subtasks from database if they exist
    let sqlSubItems;
    let subItemResults;

    if (subItemCheckResults && subItemCheckResults[0].count > 0) {
      if (taskType === "1") {
        sqlSubItems = "DELETE FROM subtask WHERE subtask_task_id = ? AND subtask_user_id = ?";
        [subItemResults] = await connection.query(sqlSubItems, [taskID, userID]);
      } else if (taskType === "2") {
        sqlSubItems = "DELETE FROM list_item WHERE list_item_task_id = ? AND list_item_user_id = ?";
        [subItemResults] = await connection.query(sqlSubItems, [taskID, userID]);
      } // Task type 3 has no subitems
    }

    // Check if no subitem rows were deleted
    // Only return a 404 if there are subitems to delete, which have not been deleted
    if (taskType === "1" || taskType === "2") {
      if (subItemCheckResults[0].count > 0 && subItemResults.affectedRows === 0) {
        await connection.rollback();
        return res.status(404).json({ message: "Subitems not correctly deleted." });
      }
    }

    // Delete task from database if it's not complete
    const sqlTask = "DELETE FROM task WHERE task_id = ? AND task_user_id = ? AND (task_complete = 0 OR task_complete = FALSE)";
    const [taskResults] = await connection.query(sqlTask, [taskID, userID]);

    // Check if no task rows were deleted
    if (taskResults.affectedRows === 0) {
      await connection.rollback();
      return res.status(404).json({ message: "Task not found." });
    }

    // Commit the transaction
    await connection.commit();

    // Return success message
    return res.status(200).json({ message: `Task ${taskID} deleted successfully` });

  } catch (err) {
    if (connection) {
      // Rollback the transaction if an error occurred
      await connection.rollback();
    }
    console.error("Error deleting task:", err);
    return res.status(500).json({ message: "Failed to delete task" });
  } finally {
    // Release the connection back to the pool
    if (connection) {
      connection.release();
    }
  }
};