const dotenv = require("dotenv").config({ path: './config.env' });
const app = require('./app');

app.listen(process.env.PORT, (err) => {
    if (err) {
      return console.error("Error starting API server:", err);
    }
    console.log(`Server is listening on PORT ${process.env.PORT}`);
  });