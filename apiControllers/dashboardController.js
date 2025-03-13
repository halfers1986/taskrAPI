const conn = require("../utils/dbconn");

// Helper function to get the SQL part for the time period
function getSQLPart(timePeriod) {
  let sqlPart = "";
  switch (timePeriod) {
    case "allTime": sqlPart = ""; break;
    case "week": sqlPart = ` AND task.task_created_timestamp >= DATE_SUB(NOW(), INTERVAL 1 WEEK)`; break;
    case "month": sqlPart = ` AND task.task_created_timestamp >= DATE_SUB(NOW(), INTERVAL 1 MONTH)`; break;
    case "sixMonth": sqlPart = ` AND task.task_created_timestamp >= DATE_SUB(NOW(), INTERVAL 6 MONTH)`; break;
    case "year": sqlPart = ` AND task.task_created_timestamp >= DATE_SUB(NOW(), INTERVAL 1 YEAR)`; break;
    default: sqlPart = "";
  }
  return sqlPart;
}

// Handler for GET /basic-dashboard endpoint
exports.getBasicDashboard = async (req, res) => {
  const userID = req.params.userID;
  const timePeriod = req.query.timePeriod;

  let sqlPart = getSQLPart(timePeriod);

  try {
    const sql = `SELECT task.task_id, task.task_type_id, task.task_complete, type.type_name, task.task_category_id, category.category_name,
    task.task_priority_id, priority.priority_name
    FROM task
    LEFT JOIN type ON task.task_type_id = type.type_id
    LEFT JOIN category ON task.task_category_id = category.category_id
    LEFT JOIN priority ON task.task_priority_id = priority.priority_id
    WHERE task.task_user_id = ${userID}${sqlPart}`;
    const [results] = await conn.query(sql);

    // If there are no results, return an empty array
    if (results.length === 0) {
      return res.json({ results: [] });
    }

     // Fetch subtasks for each task in parallel
     await Promise.all(
      results.map(async (task) => {
        const taskID = task.task_id;
        const taskType = task.task_type_id;
        if (taskType === 1) {
          const [subtasks] = await conn.query(`SELECT COUNT (subtask_id) AS subtask_count, SUM (subtask_complete) AS subtasks_completed FROM subtask WHERE subtask_task_id = ${taskID}`);
          task.subtasks = subtasks[0];
        } else if (taskType === 2) {
          const [listItems] = await conn.query(`SELECT COUNT (list_item_id) AS list_item_count, SUM (list_item_complete) AS list_items_completed FROM list_item WHERE list_item_task_id = ${taskID}`);
          task.listItems = listItems[0];
        }
      })
    );

    // console.log(results);

    // Else return the results
    return res.json({ results });

  } catch (err) {
    console.error("Error getting basic dashboard:", err);
    res.status(500).json({ message: "Failed to get basic dashboard" });
  }
};

// Handler for GET /completed-by-type endpoint
exports.getCompletedByType = async (req, res) => {
  const userID = req.params.userID;
  const timePeriod = req.query.timePeriod;

  let sqlPart = getSQLPart(timePeriod);

  try {
    const sql = `SELECT 
    IFNULL(type.type_name, 'Total') AS type_name,
    COUNT(task.task_id) AS task_count, 
    SUM(task.task_complete) AS completed_tasks
    FROM task
    JOIN type ON task.task_type_id = type.type_id
    WHERE task.task_user_id = ${userID}${sqlPart}
    GROUP BY type.type_name WITH ROLLUP`;
    const [results] = await conn.query(sql);

    // If there are no results, return an empty array
    if (results.length === 0) {
      return res.json({ results: [] });
    }

    // console.log(results);

    // Else return the results
    return res.json({ results });

  } catch (err) {
    console.error("Error getting completed percentage:", err);
    res.status(500).json({ message: "Failed to get completed percentage" });
  }
}

// Handler for GET /avg-completion-time endpoint
exports.getAverageCompletionTime = async (req, res) => {
  const userID = req.params.userID;
  const timePeriod = req.query.timePeriod;

  let sqlPart = getSQLPart(timePeriod);

  try {
    const sql = `SELECT 
    IFNULL(type.type_name, 'Total') AS type_name,
    SUM(TIMESTAMPDIFF(SECOND, task_created_timestamp, task_completed_timestamp)) / COUNT(task_id) / 3600 AS avg_completion_time_hours
    FROM task
    JOIN type ON task.task_type_id = type.type_id
    WHERE task.task_complete = 1 AND task.task_user_id = ${userID}${sqlPart}
    GROUP BY type.type_name WITH ROLLUP`;
    const [results] = await conn.query(sql);

    // If there are no results, return an empty array
    if (results.length === 0) {
      return res.json({ results: [] });
    }

    // console.log(results);

    // Else return the results
    return res.json({ results });

  } catch (err) {
    console.error("Error getting completed percentage:", err);
    res.status(500).json({ message: "Failed to get completed percentage" });
  }
}

// Handler for GET /categories-by-type endpoint
exports.getCategoriesByType = async (req, res) => {
  const userID = req.params.userID;
  const timePeriod = req.query.timePeriod;

  let sqlPart = getSQLPart(timePeriod);

  try {
    const sql = `SELECT 
    IFNULL(category.category_name, 'No Category') AS category_name,
    COUNT(task.task_category_id) AS category_count,
    type.type_name
    FROM task
    JOIN category ON task.task_category_id = category.category_id
    JOIN type ON task.task_type_id = type.type_id
    WHERE task.task_user_id = ${userID}${sqlPart}
    GROUP BY type.type_name, category.category_name
    ORDER BY type.type_name, category.category_name`;
    const [results] = await conn.query(sql);

    // If there are no results, return an empty array
    if (results.length === 0) {
      return res.json({ results: [] });
    }

    // console.log(results);

    // Else return the results
    return res.json({ results });

  } catch (err) {
    console.error("Error getting categories by type:", err);
    res.status(500).json({ message: "Failed to get categories by type" });
  }
}