const conn = require("../utils/dbconn");
var bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const secret = process.env.JWT_SECRET;

// Handler for POST /login endpoint
exports.logInUser = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: "Invalid input" });
  }

  try {
    // Check the database for the user & get the hashed password
    const sql = "SELECT user_password, user_id FROM user WHERE user_username = ?";
    const [results] = await conn.query(sql, [username]);

    // Return an error if the user doesn't exist or the password is incorrect
    if (results.length === 0 || !bcrypt.compareSync(password, results[0].user_password)) {
      return res.status(401).json({ message: "Invalid username or password" });
    }

    // GET USER ID AND RETURN
    const userID = results[0].user_id;

    const token = jwt.sign({ userID, username }, secret, { expiresIn: "1h" });
    res.status(200).json({ message: "Logged in successfully", userID, token });

  } catch (err) {
    console.error("Server error logging in:", err);
    res.status(500).json({ message: "Server error logging in" });
  }
};

// Handler for POST /register endpoint
exports.registerUser = async (req, res) => {
  const { firstName, lastName, username, email, password, dob } = req.body;

  console.log("Registering user with: ", firstName, lastName, username, email, password, dob);

  // Validate the input
  if (!firstName || !lastName || !username || !email || !password || !dob) {
    return res.status(400).json({ message: "Invalid input" });
  }

  try {
    // Check the database for an existing user with the same username
    const sql = "SELECT * FROM user WHERE user_username = ?";
    const [results] = await conn.query(sql, [username]);
    if (results.length > 0) {
      console.log(sql, " gives: ", results)
      return res.status(409).json({ message: "User already exists" });
    }

    // Insert the new user into the database
    // Salt and hash the password
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(password, salt);
    const insertSQL = "INSERT INTO user (user_first_name, user_last_name, user_username, user_email, user_password, user_dob) VALUES (?, ?, ?, ?, ?, ?)";
    const [insertResults] = await conn.query(insertSQL, [firstName, lastName, username, email, hash, dob]);

    // Return an error if the insert failed
    if (insertResults.affectedRows === 0) {
      return res.status(500).json({ message: "Failed to register user" });
    }

    // GET USER ID TO RETURN
    const userID = insertResults.insertId;
    const token = jwt.sign({ userID, username }, secret, { expiresIn: "1h" });
    
    // Return a success message
    res.status(201).json({ message: "Registered & logged in successfully", userID, token });

  } catch (err) {
    console.error("Server error attempting to register user:", err);
    return res.status(500).json({ message: "Server error attempting to register user" });
  }
};