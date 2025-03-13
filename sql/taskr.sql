-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 07, 2025 at 03:20 PM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taskr`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_user_id`) VALUES
(1, 'Work', NULL),
(2, 'Personal', NULL),
(3, 'Urgent', NULL),
(4, 'Home', NULL),
(5, 'Health', NULL),
(6, 'Shopping', NULL),
(7, 'Study', NULL),
(8, 'Hobby', NULL),
(9, 'Butt Stuff', 17),
(13, 'Footsacks', 17),
(14, 'Flippidy-dip!', 17);

-- --------------------------------------------------------

--
-- Table structure for table `list_item`
--

CREATE TABLE `list_item` (
  `list_item_id` int(11) NOT NULL,
  `list_item_task_id` int(11) NOT NULL,
  `list_item_user_id` int(11) NOT NULL,
  `list_item_name` varchar(255) NOT NULL,
  `list_item_quantity` varchar(255) NOT NULL,
  `list_item_store` varchar(255) NOT NULL,
  `list_item_complete` tinyint(1) NOT NULL DEFAULT '0',
  `list_item_created_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `list_item_last_modified_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `list_item_completed_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `list_item`
--

INSERT INTO `list_item` (`list_item_id`, `list_item_task_id`, `list_item_user_id`, `list_item_name`, `list_item_quantity`, `list_item_store`, `list_item_complete`, `list_item_created_timestamp`, `list_item_last_modified_timestamp`, `list_item_completed_timestamp`) VALUES
(13, 30, 16, 'Apples', '6', 'Supermarket', 0, '2025-01-02 11:30:00', '2025-02-04 21:58:48', NULL),
(14, 30, 16, 'Bananas', '12', 'Supermarket', 0, '2025-01-02 12:00:00', '2025-02-04 21:58:51', NULL),
(15, 30, 16, 'Chicken breasts', '4', 'Butcher', 0, '2025-01-02 12:30:00', '2025-02-04 21:58:52', NULL),
(16, 30, 16, 'Orange juice', '2', 'Supermarket', 0, '2025-01-02 13:00:00', '2025-02-04 21:58:54', NULL),
(23, 36, 16, 'cupcakes', '12', '', 1, '2025-02-05 16:00:58', '2025-02-05 17:55:03', NULL),
(24, 36, 16, 'bacon', '2', '', 1, '2025-02-05 16:01:05', '2025-02-11 17:04:33', NULL),
(25, 36, 16, 'Creamy filling', '1', '', 0, '2025-02-05 16:07:32', '2025-02-05 16:07:32', NULL),
(26, 36, 16, 'New iPhone', '3', 'Burger King', 0, '2025-02-11 17:07:45', '2025-02-11 17:07:45', NULL),
(27, 30, 16, 'Milk', '2 liters', 'Supermarket', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(28, 30, 16, 'Bread', '1 loaf', 'Bakery', 1, '2025-02-12 19:00:00', '2025-02-12 14:01:56', NULL),
(29, 30, 16, 'Eggs', '1 dozen', 'Supermarket', 1, '2025-02-12 19:00:00', '2025-02-12 14:01:56', NULL),
(30, 30, 16, 'Cheese', '500 grams', 'Deli', 1, '2025-02-12 19:00:00', '2025-02-12 14:01:55', NULL),
(31, 30, 16, 'Vegetables', '1 kg', 'Supermarket', 1, '2025-02-12 19:00:00', '2025-02-12 14:01:55', NULL),
(32, 30, 16, 'Fruits', '1 kg', 'Supermarket', 1, '2025-02-12 19:00:00', '2025-02-12 14:01:55', NULL),
(33, 50, 16, 'Milk', '2 liters', 'Supermarket', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(34, 50, 16, 'Bread', '1 loaf', 'Bakery', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(35, 50, 16, 'Eggs', '1 dozen', 'Supermarket', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(36, 50, 16, 'Cheese', '500 grams', 'Deli', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(37, 50, 16, 'Vegetables', '1 kg', 'Supermarket', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(38, 50, 16, 'Fruits', '1 kg', 'Supermarket', 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(39, 116, 16, 'Wheels', '1', '', 0, '2025-02-12 13:58:34', '2025-02-12 13:58:34', NULL),
(40, 116, 16, 'Frame', '1', '', 1, '2025-02-12 13:58:42', '2025-02-12 13:58:56', NULL),
(41, 116, 16, 'Seat', '1', '', 1, '2025-02-12 13:58:53', '2025-02-12 13:58:56', NULL),
(42, 116, 16, 'Handlebars', '1', 'Bike Shop', 0, '2025-02-12 13:59:11', '2025-02-13 12:01:04', NULL),
(43, 116, 16, 'Brakes', '2', 'Brake Shop', 0, '2025-02-12 13:59:22', '2025-02-12 13:59:22', NULL),
(44, 126, 17, 'Creme Eggs', '6', '', 0, '2025-02-20 14:49:04', '2025-02-20 14:49:04', NULL),
(45, 126, 17, 'Coffee beans', '1kg', '', 0, '2025-02-20 14:49:04', '2025-02-20 14:49:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

CREATE TABLE `priority` (
  `priority_id` int(11) NOT NULL,
  `priority_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `priority`
--

INSERT INTO `priority` (`priority_id`, `priority_name`) VALUES
(1, 'high'),
(2, 'medium'),
(3, 'low');

-- --------------------------------------------------------

--
-- Table structure for table `subtask`
--

CREATE TABLE `subtask` (
  `subtask_id` int(11) NOT NULL,
  `subtask_task_id` int(11) NOT NULL,
  `subtask_user_id` int(11) NOT NULL,
  `subtask_description` varchar(255) NOT NULL,
  `subtask_due_date` date DEFAULT NULL,
  `subtask_priority_id` int(11) DEFAULT NULL,
  `subtask_complete` tinyint(1) NOT NULL DEFAULT '0',
  `subtask_created_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subtask_last_modified_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subtask_completed_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subtask`
--

INSERT INTO `subtask` (`subtask_id`, `subtask_task_id`, `subtask_user_id`, `subtask_description`, `subtask_due_date`, `subtask_priority_id`, `subtask_complete`, `subtask_created_timestamp`, `subtask_last_modified_timestamp`, `subtask_completed_timestamp`) VALUES
(10, 23, 17, 'Complete add subtask', NULL, 3, 1, '2025-01-13 16:45:35', '2025-02-18 20:46:22', NULL),
(11, 23, 17, 'Complete add list item', NULL, 3, 1, '2025-01-13 16:45:35', '2025-02-18 20:46:29', NULL),
(12, 23, 17, 'Get filters working', NULL, 3, 1, '2025-01-13 16:45:35', '2025-02-18 20:46:34', NULL),
(13, 23, 17, 'Get sort working', NULL, 2, 1, '2025-01-13 16:45:35', '2025-02-18 20:46:38', NULL),
(14, 24, 17, 'Redesign nav', NULL, 3, 1, '2025-01-13 16:55:35', '2025-02-18 20:46:42', NULL),
(15, 24, 17, 'fix new task modal (make scroll work)', NULL, 3, 1, '2025-01-13 16:55:35', '2025-02-18 20:48:26', NULL),
(16, 24, 17, 'Fix tables in add-task', NULL, 1, 1, '2025-01-13 16:55:35', '2025-02-18 20:48:29', NULL),
(17, 24, 17, 'Redo ico image', '2025-03-11', 1, 0, '2025-01-13 16:55:35', '2025-02-19 20:15:13', NULL),
(28, 23, 17, 'Complete delete list item', NULL, 2, 1, '2025-01-13 21:12:01', '2025-02-18 20:47:03', NULL),
(29, 23, 17, 'Amend toggle table Item to be more generic', NULL, NULL, 1, '2025-01-14 12:15:12', '2025-02-18 20:48:40', NULL),
(30, 23, 17, 'Login/register functionality', NULL, 3, 1, '2025-01-14 12:17:24', '2025-02-18 20:46:57', NULL),
(31, 23, 17, 'Sessions/state persistence', NULL, NULL, 1, '2025-01-14 12:17:40', '2025-02-18 20:47:07', NULL),
(32, 23, 17, 'Cookies/sessions', NULL, NULL, 1, '2025-01-14 20:23:48', '2025-02-18 20:47:14', NULL),
(34, 23, 17, 'refactor error res for sec (401 vs 404)', NULL, NULL, 1, '2025-01-14 20:46:07', '2025-02-18 20:47:17', NULL),
(35, 23, 17, 'event listeners on newly added tiles', NULL, 3, 1, '2025-01-20 21:08:19', '2025-02-19 21:41:39', NULL),
(36, 23, 17, 'Amend so \"low\" isn\'t default priority on subtasks', NULL, NULL, 1, '2025-01-20 21:09:01', '2025-02-19 20:21:17', NULL),
(37, 23, 17, 'fix table in modal add list', NULL, NULL, 1, '2025-01-20 21:09:21', '2025-02-19 20:16:17', NULL),
(38, 23, 17, 'fix add list item function - not sending to DB', NULL, NULL, 1, '2025-01-20 21:10:25', '2025-02-19 21:41:43', NULL),
(39, 23, 17, 'amend delete to include sql confirmation of incomplete status', NULL, 2, 1, '2025-01-21 10:12:19', '2025-02-18 20:47:33', NULL),
(40, 23, 17, 'add task category to html data', NULL, NULL, 1, '2025-01-28 18:18:46', '2025-02-19 12:34:04', NULL),
(41, 23, 17, 'add task category functionality', NULL, NULL, 1, '2025-01-28 18:18:55', '2025-02-19 12:34:03', NULL),
(42, 23, 17, 'make sure new subtask data is included in html', NULL, NULL, 1, '2025-01-28 18:41:42', '2025-02-18 21:57:38', NULL),
(43, 29, 17, 'Gather data', '2025-02-10', 1, 0, '2025-01-01 10:30:00', '2025-02-18 20:47:47', NULL),
(44, 29, 17, 'Analyze results', '2025-02-12', 1, 0, '2025-01-01 11:00:00', '2025-02-18 20:47:50', NULL),
(45, 29, 16, 'Write introduction', '2025-02-13', 2, 0, '2025-01-01 11:30:00', '2025-02-04 21:55:49', NULL),
(46, 30, 16, 'Buy milk', '2025-02-10', 2, 0, '2025-01-02 11:30:00', '2025-02-04 21:55:52', NULL),
(47, 30, 16, 'Buy bread', '2025-02-10', 2, 0, '2025-01-02 12:00:00', '2025-02-04 21:55:54', NULL),
(48, 30, 16, 'Buy eggs', '2025-02-10', 2, 0, '2025-01-02 12:30:00', '2025-02-04 21:55:56', NULL),
(49, 32, 16, 'Book flights', '2025-05-01', 1, 1, '2025-01-04 13:30:00', '2025-02-12 14:01:36', NULL),
(50, 32, 16, 'Reserve hotel', '2025-05-10', 1, 1, '2025-01-04 14:00:00', '2025-02-12 14:01:35', NULL),
(51, 32, 16, 'Plan activities', '2025-05-20', 2, 1, '2025-01-04 14:30:00', '2025-02-12 14:01:44', NULL),
(52, 35, 16, 'Create outline', '2025-02-20', 1, 0, '2025-01-07 16:30:00', '2025-02-04 21:56:04', NULL),
(53, 35, 16, 'Design slides', '2025-02-22', 1, 0, '2025-01-07 17:00:00', '2025-02-04 21:56:05', NULL),
(54, 35, 16, 'Practice presentation', '2025-02-24', 2, 1, '2025-01-07 17:30:00', '2025-02-11 17:00:39', NULL),
(55, 34, 16, 'First, buy a house', NULL, 3, 0, '2025-01-28 22:28:02', '2025-02-04 21:56:09', NULL),
(56, 34, 16, 'Next, build a kitchen', NULL, 3, 0, '2025-01-28 22:33:00', '2025-02-04 21:56:11', NULL),
(57, 34, 16, 'Thirdly, wait for faucet to start leaking', NULL, 2, 0, '2025-01-28 22:37:01', '2025-02-04 21:56:13', NULL),
(58, 23, 17, 'amend some/all match in filter', NULL, 2, 1, '2025-01-29 10:03:22', '2025-02-19 22:16:44', NULL),
(59, 39, 17, 'Add end-point for getting data', '2025-02-08', 3, 1, '2025-01-29 10:05:28', '2025-02-18 20:48:14', NULL),
(60, 39, 17, 'Add front-end visuals (chart.js) to consume end points', '2025-02-16', 3, 1, '2025-01-29 10:05:28', '2025-02-19 16:14:37', NULL),
(61, 35, 16, 'Shit the bed', NULL, NULL, 1, '2025-02-05 17:31:10', '2025-02-11 17:00:43', NULL),
(62, 29, 16, 'Research project topic', '2025-02-10', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(63, 29, 16, 'Write project outline', '2025-02-12', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(64, 29, 16, 'Draft project report', '2025-02-14', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(65, 34, 16, 'Buy new faucet', '2025-02-15', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(66, 34, 16, 'Install new faucet', '2025-02-20', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(67, 35, 16, 'Create presentation slides', '2025-02-20', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(68, 35, 16, 'Practice presentation', '2025-02-22', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(69, 35, 16, 'Review presentation with team', '2025-02-24', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(70, 38, 16, 'Dust all rooms', '2025-02-10', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(71, 38, 16, 'Vacuum carpets', '2025-02-12', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(72, 38, 16, 'Mop floors', '2025-02-14', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(73, 38, 16, 'Clean windows', '2025-02-16', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(74, 32, 16, 'Research vacation destinations', '2025-02-15', 2, 1, '2025-02-12 19:00:00', '2025-02-12 14:01:38', NULL),
(75, 32, 16, 'Book flights', '2025-02-20', 2, 1, '2025-02-12 19:00:00', '2025-02-12 14:01:33', NULL),
(76, 32, 16, 'Reserve hotel', '2025-02-25', 2, 1, '2025-02-12 19:00:00', '2025-02-12 14:01:33', NULL),
(77, 32, 16, 'Plan activities', '2025-02-28', 2, 1, '2025-02-12 19:00:00', '2025-02-12 14:01:43', NULL),
(78, 54, 16, 'Dust all rooms', '2025-02-10', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(79, 54, 16, 'Vacuum carpets', '2025-02-12', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(80, 54, 16, 'Mop floors', '2025-02-14', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(81, 54, 16, 'Clean windows', '2025-02-16', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(82, 23, 17, 'Grey out edit and delete on completed subitems', NULL, 3, 1, '2025-02-18 21:56:28', '2025-02-19 20:15:33', NULL),
(83, 23, 17, 'Fix priority on added subitems', NULL, 3, 1, '2025-02-18 21:56:54', '2025-02-19 20:15:40', NULL),
(84, 23, 17, 'Fix add shopping list new task appearance in list', NULL, 3, 1, '2025-02-19 17:04:58', '2025-02-19 21:41:51', NULL),
(97, 39, 17, 'Re-add all the missing functions', '2025-02-26', 3, 1, '2025-02-19 22:17:30', '2025-03-05 18:20:10', NULL),
(98, 130, 17, 'Fix client-side verification on login', NULL, 1, 1, '2025-02-20 16:10:02', '2025-03-06 21:12:20', NULL),
(99, 130, 17, 'include category in add task', NULL, 3, 1, '2025-02-20 16:10:02', '2025-03-01 19:35:27', NULL),
(100, 130, 17, 'Fix filter on edited tasks?', NULL, 2, 1, '2025-02-20 16:10:02', '2025-03-01 12:45:22', NULL),
(101, 130, 17, 'RE-do alllllll the massive work on data that went missing', NULL, 3, 1, '2025-02-20 16:10:02', '2025-02-28 14:47:24', NULL),
(102, 130, 17, 'Fix scroll on add task', NULL, 3, 1, '2025-02-20 16:10:02', '2025-03-01 19:35:20', NULL),
(104, 130, 17, 'Fix toggle subtask on new tasks', NULL, 3, 1, '2025-02-20 16:16:29', '2025-03-06 21:12:25', NULL),
(105, 130, 17, 'Fix add subtask on new tasks', NULL, 3, 1, '2025-02-20 16:16:37', '2025-03-06 21:12:24', NULL),
(106, 130, 17, 'Fix edit sub-item on new sub-items', NULL, 3, 1, '2025-02-20 16:17:11', '2025-03-06 21:12:24', NULL),
(114, 130, 17, 'Fix completed date on completed task overlay', NULL, 2, 1, '2025-03-01 18:32:10', '2025-03-01 19:35:15', NULL),
(121, 130, 17, 'settings - user deets, make adaptable to # of fields', NULL, 3, 1, '2025-03-05 20:35:31', '2025-03-06 21:12:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `task_id` int(11) NOT NULL,
  `task_user_id` int(11) NOT NULL,
  `task_title` varchar(255) NOT NULL,
  `task_description` varchar(255) DEFAULT NULL,
  `task_type_id` int(11) NOT NULL,
  `task_category_id` int(11) DEFAULT NULL,
  `task_due_date` date DEFAULT NULL,
  `task_priority_id` int(11) DEFAULT NULL,
  `task_complete` tinyint(1) NOT NULL DEFAULT '0',
  `task_created_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `task_updated_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `task_completed_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`task_id`, `task_user_id`, `task_title`, `task_description`, `task_type_id`, `task_category_id`, `task_due_date`, `task_priority_id`, `task_complete`, `task_created_timestamp`, `task_updated_timestamp`, `task_completed_timestamp`) VALUES
(23, 17, 'Complete the beans', 'Time to do a new thing. Finish the beans, then no more beans.', 1, 7, '2025-01-21', 3, 1, '2025-01-13 16:45:35', '2025-03-05 18:20:38', '2025-03-05 18:20:38'),
(24, 17, 'Pretty-up the front-end', 'Fixes, rejigs, and tidys. It\'s definitely lower on the urgency scale.', 1, 7, NULL, 1, 0, '2025-01-13 16:55:35', '2025-02-19 12:25:24', NULL),
(25, 12, 'Gary myself', 'Gary a bit, now and then', 1, NULL, NULL, NULL, 0, '2025-01-18 20:31:42', '2025-01-19 14:21:35', NULL),
(27, 14, 'Fuck up America just like I like it', 'But still be really angry about everything', 3, NULL, NULL, NULL, 0, '2025-01-22 22:18:50', '2025-01-22 22:18:50', NULL),
(29, 16, 'Complete project report', 'Finish the final report for the project.', 1, 1, '2025-02-15', 1, 0, '2025-01-01 10:00:00', '2025-01-01 10:00:00', NULL),
(30, 16, 'Grocery shopping', 'Buy groceries for the week.', 2, 6, '2025-02-10', 2, 1, '2025-01-02 11:00:00', '2025-02-12 14:02:00', '2025-02-12 14:02:00'),
(31, 16, 'Doctor appointment', 'Annual check-up with Dr. Smith.', 3, 5, '2025-03-01', 3, 0, '2025-01-03 12:00:00', '2025-01-03 12:00:00', NULL),
(32, 16, 'Plan vacation', 'Plan the itinerary for the summer vacation.', 1, 2, '2025-06-01', 2, 1, '2025-01-04 13:00:00', '2025-02-12 14:01:45', '2025-02-12 14:01:45'),
(34, 16, 'Fix the leaky faucet', 'Repair the faucet in the kitchen.', 1, 4, '2025-02-20', 1, 0, '2025-01-06 15:00:00', '2025-01-06 15:00:00', NULL),
(35, 16, 'Prepare presentation', 'Create slides for the upcoming presentation.', 1, 1, '2025-02-25', 1, 0, '2025-01-07 16:00:00', '2025-01-07 16:00:00', NULL),
(36, 16, 'Buy birthday gift', 'Get a gift for Sarah\'s birthday.', 2, 2, '2025-03-10', 2, 0, '2025-01-08 17:00:00', '2025-01-08 17:00:00', NULL),
(37, 16, 'Exercise', 'Go for a run in the ocean.', 3, 5, '2025-01-10', 3, 0, '2025-01-09 18:00:00', '2025-02-05 09:54:30', NULL),
(38, 16, 'Clean the house', 'Do a thorough cleaning of the house.', 1, 4, '2025-01-15', 1, 1, '2025-01-10 19:00:00', '2025-02-05 09:49:43', '2025-02-05 09:49:43'),
(39, 17, 'Add data Analysis', 'Complete final major requirement!', 1, 13, '2025-02-16', 3, 1, '2025-01-29 10:05:28', '2025-03-05 18:20:18', '2025-03-05 18:20:18'),
(40, 16, 'Read more', 'Read Leo Tolstoy\'s \"War and Peace\"', 3, NULL, '2025-06-30', NULL, 0, '2025-02-06 10:01:36', '2025-02-06 10:01:36', NULL),
(47, 16, 'Read even more', 'Read \"Atlas Shrugged\" so that you can be filled with despair at the selfishness of so much human philosophy.', 3, NULL, '2026-12-31', NULL, 0, '2025-02-06 10:14:08', '2025-02-06 22:42:13', NULL),
(48, 16, 'Plan 2026 vacation', 'Plan the itinerary for the 2026 summer vacation.', 1, 2, '2026-06-01', 2, 0, '2025-02-12 10:00:00', '2025-02-12 10:00:00', NULL),
(49, 16, 'Doctor appointment', 'Annual check-up with Dr. Smith.', 3, 5, '2026-03-01', 3, 0, '2025-02-12 11:00:00', '2025-02-12 11:00:00', NULL),
(50, 16, 'Grocery shopping', 'Buy groceries for the week.', 2, 6, '2025-02-17', 2, 0, '2025-02-12 12:00:00', '2025-02-12 12:00:00', NULL),
(51, 16, 'Prepare presentation', 'Create slides for the upcoming presentation.', 1, 1, '2025-02-25', 1, 0, '2025-02-12 13:00:00', '2025-02-12 13:00:00', NULL),
(52, 16, 'Buy birthday gift', 'Get a gift for Sarah\'s birthday.', 2, 2, '2025-03-10', 2, 0, '2025-02-12 14:00:00', '2025-02-12 14:00:00', NULL),
(53, 16, 'Exercise', 'Go for a run in the park.', 3, 5, '2025-02-15', 3, 0, '2025-02-12 15:00:00', '2025-02-12 15:00:00', NULL),
(54, 16, 'Clean the house', 'Do a thorough cleaning of the house.', 1, 4, '2025-02-20', 1, 1, '2025-02-12 16:00:00', '2025-02-12 16:00:00', '2025-02-20 18:00:00'),
(55, 16, 'Read more', 'Read Leo Tolstoy\'s \"War and Peace\"', 3, NULL, '2025-06-30', NULL, 0, '2025-02-12 17:00:00', '2025-02-12 17:00:00', NULL),
(56, 16, 'Read even more', 'Read \"Atlas Shrugged\" by Ayn Rand.', 3, NULL, '2026-12-31', NULL, 0, '2025-02-12 18:00:00', '2025-02-12 18:00:00', NULL),
(57, 16, 'Complete project report', 'Finish the final report for the project.', 1, 1, '2025-02-15', 1, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(58, 16, 'Plan 2027 vacation', 'Plan the itinerary for the 2027 summer vacation.', 1, 2, '2027-06-01', 2, 0, '2025-02-12 20:00:00', '2025-02-12 20:00:00', NULL),
(59, 16, 'Doctor appointment', 'Annual check-up with Dr. Smith.', 3, 5, '2027-03-01', 3, 0, '2025-02-12 21:00:00', '2025-02-12 21:00:00', NULL),
(60, 16, 'Grocery shopping', 'Buy groceries for the week.', 2, 6, '2025-02-24', 2, 0, '2025-02-12 22:00:00', '2025-02-12 22:00:00', NULL),
(61, 16, 'Prepare presentation', 'Create slides for the upcoming presentation.', 1, 1, '2025-03-01', 1, 0, '2025-02-12 23:00:00', '2025-02-12 23:00:00', NULL),
(62, 16, 'Buy birthday gift', 'Get a gift for Sarah\'s birthday.', 2, 2, '2025-03-17', 2, 0, '2025-02-13 00:00:00', '2025-02-13 00:00:00', NULL),
(63, 16, 'Exercise', 'Go for a run in the park.', 3, 5, '2025-02-22', 3, 0, '2025-02-13 01:00:00', '2025-02-13 01:00:00', NULL),
(64, 16, 'Clean the house', 'Do a thorough cleaning of the house.', 1, 4, '2025-02-27', 1, 1, '2025-02-13 02:00:00', '2025-02-13 02:00:00', '2025-02-27 18:00:00'),
(65, 16, 'Read more', 'Read Leo Tolstoy\'s \"War and Peace\"', 3, NULL, '2025-07-30', NULL, 0, '2025-02-13 03:00:00', '2025-02-13 03:00:00', NULL),
(66, 16, 'Read even more', 'Read \"Atlas Shrugged\" by Ayn Rand.', 3, NULL, '2027-12-31', NULL, 0, '2025-02-13 04:00:00', '2025-02-13 04:00:00', NULL),
(67, 16, 'Complete project report', 'Finish the final report for the project.', 1, 1, '2025-03-15', 1, 0, '2025-02-13 05:00:00', '2025-02-13 05:00:00', NULL),
(68, 16, 'Finish reading book', 'Complete reading \"The Great Gatsby\".', 3, NULL, '2025-03-01', 2, 0, '2025-02-12 10:00:00', '2025-02-12 10:00:00', NULL),
(69, 16, 'Organize garage', 'Clean and organize the garage.', 1, 4, '2025-04-01', 1, 0, '2025-02-12 11:00:00', '2025-02-12 11:00:00', NULL),
(70, 16, 'Plan birthday party', 'Plan a surprise birthday party for a friend.', 1, 2, '2025-05-01', 2, 0, '2025-02-12 12:00:00', '2025-02-12 12:00:00', NULL),
(71, 16, 'Write blog post', 'Write a new blog post about web development.', 1, 1, '2025-06-01', 3, 0, '2025-02-12 13:00:00', '2025-02-12 13:00:00', NULL),
(72, 16, 'Renew passport', 'Renew passport before it expires.', 2, 5, '2025-07-01', 1, 0, '2025-02-12 14:00:00', '2025-02-12 14:00:00', NULL),
(73, 16, 'Attend conference', 'Attend the annual tech conference.', 3, 1, '2024-07-01', 2, 1, '2024-05-13 14:00:00', '2025-02-12 13:56:21', '2024-07-01 12:55:40'),
(74, 16, 'Fix car', 'Take the car to the mechanic for repairs.', 1, 4, '2025-09-01', 3, 0, '2025-02-12 16:00:00', '2025-02-12 16:00:00', NULL),
(75, 16, 'Buy new laptop', 'Purchase a new laptop for work.', 2, 6, '2025-10-01', 1, 0, '2025-02-12 17:00:00', '2025-02-12 17:00:00', NULL),
(76, 16, 'Start new project', 'Begin working on a new project.', 1, 1, '2025-11-01', 2, 0, '2025-02-12 18:00:00', '2025-02-12 18:00:00', NULL),
(77, 16, 'Visit family', 'Plan a trip to visit family.', 3, 2, '2025-12-01', 3, 0, '2025-02-12 19:00:00', '2025-02-12 19:00:00', NULL),
(78, 16, 'Complete online course', 'Finish the online course on machine learning.', 1, 7, '2026-01-01', 1, 0, '2025-02-12 20:00:00', '2025-02-12 20:00:00', NULL),
(79, 16, 'Organize files', 'Sort and organize digital files.', 1, 4, '2026-02-01', 2, 0, '2025-02-12 21:00:00', '2025-02-12 21:00:00', NULL),
(80, 16, 'Prepare tax documents', 'Gather and prepare documents for tax filing.', 2, 1, '2026-03-01', 3, 0, '2025-02-12 22:00:00', '2025-02-12 22:00:00', NULL),
(81, 16, 'Update resume', 'Update resume with recent work experience.', 1, 1, '2026-04-01', 1, 0, '2025-02-12 23:00:00', '2025-02-12 23:00:00', NULL),
(82, 16, 'Plan weekend getaway', 'Plan a short trip for the weekend.', 3, 2, '2026-05-01', 2, 0, '2025-02-13 00:00:00', '2025-02-13 00:00:00', NULL),
(83, 16, 'Buy groceries', 'Buy groceries for the week.', 2, 6, '2026-06-01', 3, 0, '2025-02-13 01:00:00', '2025-02-13 01:00:00', NULL),
(84, 16, 'Clean the house', 'Do a thorough cleaning of the house.', 1, 4, '2026-07-01', 1, 0, '2025-02-13 02:00:00', '2025-02-13 02:00:00', NULL),
(85, 16, 'Exercise regularly', 'Create a workout routine and stick to it.', 3, 5, '2026-08-01', 2, 0, '2025-02-13 03:00:00', '2025-02-13 03:00:00', NULL),
(86, 16, 'Learn a new language', 'Start learning Spanish.', 1, 7, '2026-09-01', 3, 0, '2025-02-13 04:00:00', '2025-02-13 04:00:00', NULL),
(87, 16, 'Volunteer', 'Find a local organization to volunteer with.', 3, 2, '2026-10-01', 1, 0, '2025-02-13 05:00:00', '2025-02-13 05:00:00', NULL),
(88, 16, 'Write a book', 'Start writing a novel.', 1, 1, '2026-11-01', 2, 0, '2025-02-13 06:00:00', '2025-02-13 06:00:00', NULL),
(89, 16, 'Attend workshop', 'Attend a workshop on public speaking.', 3, 1, '2026-12-01', 3, 0, '2025-02-13 07:00:00', '2025-02-13 07:00:00', NULL),
(90, 16, 'Plan holiday party', 'Organize a holiday party for friends and family.', 1, 2, '2027-01-01', 1, 0, '2025-02-13 08:00:00', '2025-02-13 08:00:00', NULL),
(91, 16, 'Fix leaky faucet', 'Repair the faucet in the kitchen.', 1, 4, '2027-02-01', 2, 0, '2025-02-13 09:00:00', '2025-02-13 09:00:00', NULL),
(92, 16, 'Read a new book', 'Read \"To Kill a Mockingbird\".', 3, NULL, '2027-03-01', 3, 0, '2025-02-13 10:00:00', '2025-02-13 10:00:00', NULL),
(93, 16, 'Organize closet', 'Clean and organize the closet.', 1, 4, '2027-04-01', 1, 0, '2025-02-13 11:00:00', '2025-02-13 11:00:00', NULL),
(94, 16, 'Plan a road trip', 'Plan a road trip across the country.', 3, 2, '2027-05-01', 2, 0, '2025-02-13 12:00:00', '2025-02-13 12:00:00', NULL),
(95, 16, 'Start a garden', 'Plant a vegetable garden in the backyard.', 1, 4, '2027-06-01', 3, 0, '2025-02-13 13:00:00', '2025-02-13 13:00:00', NULL),
(96, 16, 'Learn to cook', 'Take a cooking class.', 3, 7, '2027-07-01', 1, 0, '2025-02-13 14:00:00', '2025-02-13 14:00:00', NULL),
(97, 16, 'Update website', 'Redesign and update personal website.', 1, 1, '2027-08-01', 2, 0, '2025-02-13 15:00:00', '2025-02-13 15:00:00', NULL),
(98, 16, 'Buy new furniture', 'Purchase new furniture for the living room.', 2, 6, '2027-09-01', 3, 0, '2025-02-13 16:00:00', '2025-02-13 16:00:00', NULL),
(99, 16, 'Attend networking event', 'Go to a local networking event.', 3, 1, '2027-10-01', 1, 0, '2025-02-13 17:00:00', '2025-02-13 17:00:00', NULL),
(100, 16, 'Write a journal', 'Start a daily journal.', 1, 1, '2027-11-01', 2, 0, '2025-02-13 18:00:00', '2025-02-13 18:00:00', NULL),
(101, 16, 'Plan a picnic', 'Organize a picnic in the park.', 3, 2, '2027-12-01', 3, 0, '2025-02-13 19:00:00', '2025-02-13 19:00:00', NULL),
(102, 16, 'Fix the roof', 'Repair the roof before the rainy season.', 1, 4, '2028-01-01', 1, 0, '2025-02-13 20:00:00', '2025-02-13 20:00:00', NULL),
(103, 16, 'Learn to play guitar', 'Take guitar lessons.', 3, 7, '2028-02-01', 2, 0, '2025-02-13 21:00:00', '2025-02-13 21:00:00', NULL),
(104, 16, 'Organize a charity event', 'Plan and organize a charity event.', 1, 2, '2028-03-01', 3, 0, '2025-02-13 22:00:00', '2025-02-13 22:00:00', NULL),
(105, 16, 'Buy a new car', 'Purchase a new car.', 2, 6, '2028-04-01', 1, 0, '2025-02-13 23:00:00', '2025-02-13 23:00:00', NULL),
(106, 16, 'Start a blog', 'Create and start a personal blog.', 1, 1, '2028-05-01', 2, 0, '2025-02-14 00:00:00', '2025-02-14 00:00:00', NULL),
(107, 16, 'Plan a family reunion', 'Organize a family reunion.', 3, 2, '2028-06-01', 3, 1, '2025-02-14 01:00:00', '2025-02-12 14:00:08', '2025-02-12 14:00:08'),
(108, 16, 'Learn to swim', 'Take swimming lessons.', 3, 5, '2028-07-01', 1, 0, '2025-02-14 02:00:00', '2025-02-14 02:00:00', NULL),
(109, 16, 'Write a research paper', 'Write a research paper on a chosen topic.', 1, 1, '2028-08-01', 2, 0, '2025-02-14 03:00:00', '2025-02-14 03:00:00', NULL),
(110, 16, 'Plan a hiking trip', 'Organize a hiking trip with friends.', 3, 2, '2028-09-01', 3, 0, '2025-02-14 04:00:00', '2025-02-14 04:00:00', NULL),
(111, 16, 'Buy a new phone', 'Purchase the latest smartphone.', 2, 6, '2028-10-01', 1, 0, '2025-02-14 05:00:00', '2025-02-14 05:00:00', NULL),
(112, 16, 'Attend a concert', 'Go to a live concert.', 3, 8, '2028-11-01', 2, 0, '2025-02-14 06:00:00', '2025-02-14 06:00:00', NULL),
(113, 16, 'Start a podcast', 'Create and launch a podcast.', 1, 1, '2028-12-01', 3, 0, '2025-02-14 07:00:00', '2025-02-14 07:00:00', NULL),
(114, 16, 'Learn to code', 'Take an online coding course.', 3, 7, '2029-01-01', 1, 0, '2025-02-14 08:00:00', '2025-02-14 08:00:00', NULL),
(115, 16, 'Plan a beach vacation', 'Organize a trip to the beach.', 3, 2, '2029-02-01', 2, 0, '2025-02-14 09:00:00', '2025-02-14 09:00:00', NULL),
(116, 16, 'Buy a bicycle', 'Purchase a new bicycle.', 2, 6, '2029-03-01', 3, 0, '2025-02-14 10:00:00', '2025-02-14 10:00:00', NULL),
(117, 16, 'Attend a cooking class', 'Take a cooking class to learn new recipes.', 3, 7, '2029-04-01', 1, 0, '2025-02-14 11:00:00', '2025-02-14 11:00:00', NULL),
(118, 16, 'Write a short story', 'Write and publish a short story.', 1, 1, '2029-05-01', 2, 0, '2025-02-14 12:00:00', '2025-02-14 12:00:00', NULL),
(119, 16, 'Plan a camping trip', 'Organize a camping trip with friends.', 3, 2, '2029-06-01', 3, 0, '2025-02-14 13:00:00', '2025-02-14 13:00:00', NULL),
(120, 16, 'Learn to paint', 'Take a painting class.', 3, 8, '2029-07-01', 1, 0, '2025-02-14 14:00:00', '2025-02-14 14:00:00', NULL),
(121, 16, 'Buy a new TV', 'Purchase a new television.', 2, 6, '2029-08-01', 2, 0, '2025-02-14 15:00:00', '2025-02-14 15:00:00', NULL),
(122, 16, 'Attend a seminar', 'Go to a seminar on personal development.', 3, 1, '2029-09-01', 3, 0, '2025-02-14 16:00:00', '2025-02-14 16:00:00', NULL),
(123, 16, 'Write a poem', 'Write and publish a poem.', 1, 1, '2029-10-01', 1, 0, '2025-02-14 17:00:00', '2025-02-14 17:00:00', NULL),
(124, 16, 'Plan a surprise', 'Plan a surprise for a loved one.', 3, 2, '2029-11-01', 2, 0, '2025-02-14 18:00:00', '2025-02-14 18:00:00', NULL),
(125, 16, 'Fix the fence now', 'Repair the fence in the backyard.', 1, 4, '2029-12-01', 2, 0, '2025-02-14 19:00:00', '2025-02-17 20:01:38', NULL),
(126, 17, 'Things to buy from Dunnes', '', 2, 9, NULL, 1, 1, '2025-02-20 14:49:04', '2025-03-06 16:11:41', '2025-03-06 16:11:41'),
(130, 17, 'Finishing touches?', 'The last (lol) few things to do', 1, 1, NULL, NULL, 1, '2025-02-20 16:10:02', '2025-03-06 21:12:27', '2025-03-06 21:12:27');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`type_id`, `type_name`) VALUES
(1, 'Todo'),
(2, 'Shopping List'),
(3, 'Note');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_first_name` varchar(255) NOT NULL,
  `user_last_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_dob` date NOT NULL,
  `user_password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_username`, `user_first_name`, `user_last_name`, `user_email`, `user_dob`, `user_password`) VALUES
(12, 'Gary', 'Gary', 'Garysson', 'gary@gary.com', '1865-02-05', '$2a$10$K5NEN6Wlkq9Lq4XweK2Uk.6FPDaKBt2X10Ygo0G/oPm2gY1g2EvcG'),
(14, 'AngryMeatMan', 'Steve', 'Bannon', 'BigFurry@gammon.gammon', '1956-08-14', '$2a$10$35maYeOdvj7/LEMu1E1CWO2GE1sH3cS3.Mfdqyfu7hd93jdKlt4Vm'),
(15, 'Herbie', 'Herbert', 'Herbert', 'herbie@herbie.herb', '1893-01-01', '$2a$10$RX.ApYxbRPLdklNQXgd7n.Fuw3nzrMofuTZE2q.iGkyDnijXC7ZNa'),
(17, 'halfers1986', 'Sam', 'Halfpenny', 'sam.j.halfpenny@gmail.com', '1986-09-24', '$2a$10$OLU3L7FgmohOiy0m68aAc.mt0AjkJ.glci0Nobi8RJR5RWpB684Xi'),
(16, 'spideyboy', 'Peter', 'Parker', 'spiderman@gmail.com', '2000-06-15', '$2a$10$hiiPx3LU7wd76Bpb5SM/6upswTRnDTfoeq51GfUuu9rlfq4.t4tha');

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `FK_user_user_ID` (`category_user_id`);

--
-- Indexes for table `list_item`
--
ALTER TABLE `list_item`
  ADD PRIMARY KEY (`list_item_id`),
  ADD KEY `FK_list_item_task_id` (`list_item_task_id`),
  ADD KEY `FK_list_item_user_id` (`list_item_user_id`);

--
-- Indexes for table `priority`
--
ALTER TABLE `priority`
  ADD PRIMARY KEY (`priority_id`);

--
-- Indexes for table `subtask`
--
ALTER TABLE `subtask`
  ADD PRIMARY KEY (`subtask_id`),
  ADD KEY `FK_subtask_task_id` (`subtask_task_id`),
  ADD KEY `FK_subtask_priority_id` (`subtask_priority_id`),
  ADD KEY `FK_subtask_user_id` (`subtask_user_id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `FK_task_user_id` (`task_user_id`),
  ADD KEY `FK_task_type_id` (`task_type_id`),
  ADD KEY `FK_task_priority_id` (`task_priority_id`),
  ADD KEY `FK_task_category_id` (`task_category_id`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `list_item`
--
ALTER TABLE `list_item`
  MODIFY `list_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `priority`
--
ALTER TABLE `priority`
  MODIFY `priority_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subtask`
--
ALTER TABLE `subtask`
  MODIFY `subtask_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `FK_user_user_ID` FOREIGN KEY (`category_user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `list_item`
--
ALTER TABLE `list_item`
  ADD CONSTRAINT `FK_list_item_task_id` FOREIGN KEY (`list_item_task_id`) REFERENCES `task` (`task_id`),
  ADD CONSTRAINT `FK_list_item_user_id` FOREIGN KEY (`list_item_user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `subtask`
--
ALTER TABLE `subtask`
  ADD CONSTRAINT `FK_subtask_priority_id` FOREIGN KEY (`subtask_priority_id`) REFERENCES `priority` (`priority_id`),
  ADD CONSTRAINT `FK_subtask_task_id` FOREIGN KEY (`subtask_task_id`) REFERENCES `task` (`task_id`),
  ADD CONSTRAINT `FK_subtask_user_id` FOREIGN KEY (`subtask_user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `FK_task_category_id` FOREIGN KEY (`task_category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `FK_task_priority_id` FOREIGN KEY (`task_priority_id`) REFERENCES `priority` (`priority_id`),
  ADD CONSTRAINT `FK_task_type_id` FOREIGN KEY (`task_type_id`) REFERENCES `type` (`type_id`),
  ADD CONSTRAINT `FK_task_user_id` FOREIGN KEY (`task_user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `FK_user_user_ID_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
