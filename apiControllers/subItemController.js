const conn = require("../utils/dbconn");

exports.updateSubItem = async (req, res) => {
  
  const { userId, taskId, subItemId } = req.params;
  const { taskType, column1Value, column2Value, column3Value } = req.body;

  if (!userId || !taskId || !subItemId || !taskType ||
    (column1Value === undefined && column2Value === undefined && column3Value === undefined)) {
    return res.status(400).json({ message: "Invalid input: at least one column value is required" });
  }

  let sql;
  let values = [];
  let updates = [];
  if (taskType === "1") {

    sql = "UPDATE subtask SET ";

    // Construct the SQL statement based on the input
    if (column1Value !== undefined && column1Value !== "") {
      updates.push("subtask_description = ?");
      values.push(column1Value);
    }
    if (column2Value !== undefined && column2Value !== "") {
      updates.push("subtask_due_date = ?");
      values.push(column2Value);
    }
    if (column3Value !== undefined && column3Value !== "0") {
      updates.push("subtask_priority_id = ?");
      values.push(column3Value);
    }

    // Construct the final SQL statement
    sql += updates.join(", ") + " WHERE subtask_id = ? AND subtask_user_id = ? AND subtask_task_id = ?";
    values.push(subItemId, userId, taskId);

  } else if (taskType === "2") {

    sql = "UPDATE list_item SET ";

    // Construct the SQL statement based on the input
    if (column1Value !== undefined) {
      updates.push("list_item_name = ?");
      values.push(column1Value);
    }
    if (column2Value !== undefined) {
      updates.push("list_item_store = ?");
      values.push(column2Value);
    }
    if (column3Value !== undefined) {
      updates.push("list_item_quantity = ?");
      values.push(column3Value);
    }

    // Construct the final SQL statement
    sql += updates.join(", ") + " WHERE list_item_id = ? AND list_item_user_id = ? AND list_item_task_id = ?";
    values.push(subItemId, userId, taskId);

  } else {
    return res.status(422).json({ message: "Invalid route: unknown task type" });
  }

  try {
    // Update the subitem in the database
    const [results] = await conn.query(sql, values);

    // If no rows were affected, return an error
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Item not found." });
    }

    // Else return success message
    res.json({ message: "Item updated successfully" });

  } catch (err) {
    console.error("Error updating item:", err);
    res.status(500).json({ message: "Failed to update item" });
  }
};

// Handles POST /:type/:id API route
exports.updateSubItemStatus = async (req, res) => {
  const { type, id } = req.params;
  const { newStatus, userID } = req.body;
  let table;
  let column;
  let idColumn;
  let userColumn;

  try {
    // Validate the input and set the correct table and column names
    switch (type) {
      case "toggle-subtask":
        {
          table = "subtask";
          column = "subtask_complete";
          idColumn = "subtask_id";
          userColumn = "subtask_user_id";
        }
        break;
      case "toggle-shopping-list":
        {
          table = "list_item";
          column = "list_item_complete";
          idColumn = "list_item_id";
          userColumn = "list_item_user_id";
        }
        break;
      default:
        return res.status(404).json({ message: "Invalid route" });
    }

    // Update the item in the database
    const sql = "UPDATE ?? SET ?? = ? WHERE ?? = ? AND ?? = ?";
    const [results] = await conn.query(sql, [table, column, newStatus, idColumn, id, userColumn, userID]);

    // If no rows were affected, return an error
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Item not found." });
    }

    // Else return success message
    res.json({ message: "Item updated successfully" });

  } catch (err) {
    console.error("Error updating item:", err);
    res.status(500).json({ message: "Failed to update item" });
  }
};

// Handles POST /new-table-item API route
exports.addSubItem = async (req, res) => {
  const { taskID, taskType, item1, item2, item3, userID } = req.body;

  console.log("taskID:", taskID, "taskType:", taskType, "item1:", item1, "item2:", item2, "item3:", item3, "userID:", userID);

  // If taskType is 1, item2 is the due date and item3 is the priority and require validation
  let date;
  let priority;
  if (taskType === "1") {
    date = item2 === "" ? null : item2;
    priority = item3 === "0" ? null : item3;
  }

  try {
    // Validate the input
    if (!taskID || !item1) {
      if (!taskID) {
        return res.status(400).json({ message: "Invalid input (taskID not found)" });
      } else {
        return res.status(400).json({ message: "Invalid input (description not found)" });
      }
    }

    // Insert new subitem into database
    let sql;
    let results;
    if (taskType === "1") {
      sql = "INSERT INTO subtask (subtask_task_id, subtask_description, subtask_due_date, subtask_priority_id, subtask_user_id ) VALUES (?, ?, ?, ?, ?)";
      [results] = await conn.query(sql, [taskID, item1, date, priority, userID]);
    } else {
      sql = "INSERT INTO list_item (list_item_task_id, list_item_name, list_item_store, list_item_quantity, list_item_user_id) VALUES (?, ?, ?, ?, ?)";
      [results] = await conn.query(sql, [taskID, item1, item2, item3, userID]);
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Could not add item: containing task not found." });
    }

    // Return success message and ID of new subtask
    res.status(200).json({ message: "Item added successfully", insertId: results.insertId });
  } catch (err) {
    console.error("Error adding item:", err);
    res.status(500).json({ message: "Failed to add item" });
  }
};

// Handles DELETE /delete-table-item API route
exports.deleteSubItem = async (req, res) => {
  const { lineItemID, parentTaskTypeID, userID } = req.body;

  let sql;
  let results;
  if (parentTaskTypeID === "1") {
    sql = "DELETE FROM subtask WHERE subtask_id = ? AND subtask_user_id = ?";
  } else {
    sql = "DELETE FROM list_item WHERE list_item_id = ? AND list_item_user_id = ?";
  }

  try {
    [results] = await conn.query(sql, [lineItemID, userID]);

    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Item not found." });
    }

    res.json({ message: "Item deleted successfully" });
  } catch (err) {
    console.error("Error deleting item:", err);
    res.status(500).json({ message: "Failed to delete item" });
  }
};
