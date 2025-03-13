
const express = require("express");
const jwt = require("jsonwebtoken");
const secretKey = process.env.JWT_SECRET;
const router = express.Router();

// Import controllers
const authenticationControllerAPI = require("../apiControllers/authenticationController");
const dashboardControllerAPI = require("../apiControllers/dashboardController");
const taskControllerAPI = require("../apiControllers/taskController");
const subItemControllerAPI = require("../apiControllers/subItemController");
const settingsControllerAPI = require("../apiControllers/settingsController");

// Middleware to validate JWT
const authenticateJWT = (req, res, next) => {
    const token = req.headers["authorization"]?.split(" ")[1]; // Extract token
    // console.log("Verifying token: ", token);
    if (!token) {
        console.log("No token found");
        return res.status(401).json({ error: "Unauthorized" });
    }

    jwt.verify(token, secretKey, (err, decoded) => {
        // console.log("Decoded token: ", decoded);
        if (err) {
            console.log("Invalid token");
            return res.status(403).json({ error: "Invalid token" });
        }
        // console.log("Token verified");
        next();
    });
};

// -- User Authentication Routes --
// Post route to log in a user
router.post("/login", authenticationControllerAPI.logInUser);
// Post route to register a user
router.post("/register", authenticationControllerAPI.registerUser);


// -- Data Dashboard Routes --
// Get route to get the user's basic dashboard
router.get("/basic-dashboard/:userID", authenticateJWT, dashboardControllerAPI.getBasicDashboard);
// Get routes to get the user's more complex dashboard items
router.get("/completed-by-type/:userID", authenticateJWT, dashboardControllerAPI.getCompletedByType);
router.get("/avg-completion-time/:userID", authenticateJWT, dashboardControllerAPI.getAverageCompletionTime);
router.get("/categories-by-type/:userID", authenticateJWT, dashboardControllerAPI.getCategoriesByType);

// -- Task Routes --
// Get route to get the user's tasks
router.get("/tasks/:userID", authenticateJWT, taskControllerAPI.getTasks);
// Post route to add a new task
router.post("/add-task", authenticateJWT, taskControllerAPI.addTask);
// Patch route to update a task
router.patch("/edit-task/:id", authenticateJWT, taskControllerAPI.updateTask);
// Patch route to update the status of a task
router.patch("/task-status/:id", authenticateJWT, taskControllerAPI.updateTaskCompletion);
// Delete route to delete a task
router.delete("/delete-task/:id", authenticateJWT, taskControllerAPI.deleteTask);

// -- Settings Routes --
// Patch route to update the user's password
router.patch("/update-password/:userID", authenticateJWT, settingsControllerAPI.updatePassword);
// Get route to get the user's settings
router.get("/settings/:userID", authenticateJWT, settingsControllerAPI.getSettings);
// Patch route to update the user's details
router.patch("/update-user-details/:userID", authenticateJWT, settingsControllerAPI.updateDetails);
// Post route to add a new category
router.post("/add-category/:userID", authenticateJWT, settingsControllerAPI.addCategory);
// Delete route to delete a category
router.delete("/delete-category/:userID", authenticateJWT, settingsControllerAPI.deleteCategory);
// Delete route to delete a user
router.delete("/delete-account/:userID", authenticateJWT, settingsControllerAPI.deleteAccount);

// -- Sub-Item Routes --
// Patch route to update a subtask or shopping list item
router.patch("/edit-sub-item/:userId/:taskId/:subItemId", authenticateJWT, subItemControllerAPI.updateSubItem);
// Patch route to update the status of a subtask or shopping list item
router.patch("/:type/:id", authenticateJWT, subItemControllerAPI.updateSubItemStatus);
// Post route to add a new subtask or shopping list item
router.post("/new-table-item", authenticateJWT, subItemControllerAPI.addSubItem);
// Delete route to delete a subtask or shopping list item
router.delete("/delete-table-item", authenticateJWT, subItemControllerAPI.deleteSubItem);

// Export the router
module.exports = router;
