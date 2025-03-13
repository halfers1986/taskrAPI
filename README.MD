# Task Management API

## Project Overview
This is the backend API for the Task Management web application. It provides endpoints for managing tasks, user authentication, and session handling. The API supports different task types such as lists, notes, and to-dos, along with filtering and user preferences.

## Tech Stack
- **Backend:** Node.js, Express  
- **Database:** MySQL  
- **Authentication:** JSON Web Tokens (JWT)    

## Installation & Setup

### Prerequisites
- Node.js installed
- MySQL database set up

### Steps to Run Locally
1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Install dependencies:
   ```sh
   npm install
   ```
3. Configure environment variables:
   - Create a `.env` file with the required variables (e.g., session secret, database connection, JWT secret)
4. Set up the database:
   - Ensure MySQL is running and update the database schema if necessary.
   - (Example database is included in sql directory)
5. Run the API:
   ```sh
   npm start
   ```
6. Clone, install, and run the taskr web app (`https://github.com/halfers1986/taskr`)
7. Open the app in your browser (default: `http://localhost:3000`).

## API Endpoints

### Authentication
- `POST /register` - Register a new user
- `POST /login` - Authenticate and obtain a JWT token

### Tasks
- `GET /tasks/:userID` - Fetch all tasks
- `POST /add-task` - Create a new task
- `PATCH /edit-task/:id` - Amend some or all details of a task
- `PATCH /task-status/:id` - Update a task's completion status
- `DELETE /delete-task/:id` - Delete a task

### Subtasks/List Items
- `POST /new-table-item` - Create a new subtask or list item
- `PATCH /:type/:id`- Update a subtask or list item's completion status
- `PATCH /edit-sub-item/:userId/:taskId/:subItemId` - Update some or all details of a subtask or list item
- `DELETE /delete-table-item` - Delete a subtask or list item

### Data Dashboard
- `GET /basic-dashboard/:userID` - Fetch the information to display basic task data
- `GET /completed-by-type/:userID` - Fetch the information to display completed task by type
- `GET /avg-completion-time/:userID` - Fetch the information to display the average completion time of tasks
- `GET /categories-by-type/:userID` - Fetch the information to display the category breakdown by task type

### Settings
- `GET /settings/:userID` - Retrieve user settings
- `POST /add-category/:userID` - Add a new custom task category
- `PATCH /update-password/:userID` - Updates the user's password
- `PATCH /update-user-details/:userID` - Updates the user's name, username or email address
- `DELETE / delete-category/:userID` - Deletes a user's custom category
- `DELETE /delete-account/:userID` - Delete's a user's account and all associated information

## Project Structure
```
├── apiControllers/   # Request handlers
├── routes/           # API route definitions
├── sql/              # Example database
├── utils/            # Database connector
├── app.js            # Main server file
├── package.json      # Dependencies and scripts
├── server.js         # Server connection
└── README.md         # Documentation
```
## Known Issues & Future Improvements
- Optimize database queries for performance
