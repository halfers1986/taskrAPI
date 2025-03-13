const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const app = express();
const router = require("./routes/routes");

// Middleware to log requests
app.use(morgan("tiny"));

// Middleware to enable CORS - Cross Origin Resource Sharing
// This helps secure the API by preventing unauthorized access
app.use(cors({
    origin: "http://localhost:3000",
    credentials: true
}));

// Middleware to parse incoming JSON data
app.use(express.json());

// Middleware to serve the routes
app.use("/", router);

module.exports = app;

