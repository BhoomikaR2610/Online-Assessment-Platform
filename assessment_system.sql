-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: May 11, 2026 at 06:53 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assessment_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `assessment`
--

CREATE TABLE `assessment` (
  `id` int(11) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `easy` int(11) DEFAULT NULL,
  `medium` int(11) DEFAULT NULL,
  `hard` int(11) DEFAULT NULL,
  `easy_file` varchar(255) DEFAULT NULL,
  `medium_file` varchar(255) DEFAULT NULL,
  `hard_file` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`id`, `subject`, `duration`, `total`, `easy`, `medium`, `hard`, `easy_file`, `medium_file`, `hard_file`, `status`) VALUES
(1, 'Data Science', 30, 30, 10, 10, 10, 'easy.json', 'medium.json', 'hard.json', 'active'),
(2, 'Data Science', 3, 3, 1, 1, 1, 'easy.json', 'medium.json', 'hard.json', 'active'),
(3, 'Machine Learning', 10, 10, 5, 4, 1, 'easy.json', 'medium.json', 'hard.json', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exam_attempts`
--

CREATE TABLE `exam_attempts` (
  `id` int(11) NOT NULL,
  `student_email` varchar(100) DEFAULT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `questions` longtext DEFAULT NULL,
  `answers` longtext DEFAULT NULL,
  `score` int(11) DEFAULT 0,
  `status` varchar(50) DEFAULT 'in_progress',
  `result_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_attempts`
--

INSERT INTO `exam_attempts` (`id`, `student_email`, `assessment_id`, `questions`, `answers`, `score`, `status`, `result_status`) VALUES
(1, 'sanvi@gmail.com', 1, '[{\"question\": \"Which command updates data?\", \"options\": [\"UPDATE\", \"INSERT\", \"DELETE\", \"DROP\"], \"answer\": \"UPDATE\", \"id\": \"q1\", \"option1\": \"UPDATE\", \"option2\": \"INSERT\", \"option3\": \"DELETE\", \"option4\": \"DROP\", \"correct_answer\": \"UPDATE\"}, {\"question\": \"Which normal form removes transitive dependency?\", \"options\": [\"1NF\", \"2NF\", \"3NF\", \"BCNF\"], \"answer\": \"3NF\", \"id\": \"q2\", \"option1\": \"1NF\", \"option2\": \"2NF\", \"option3\": \"3NF\", \"option4\": \"BCNF\", \"correct_answer\": \"3NF\"}, {\"question\": \"Which command is used to retrieve data?\", \"options\": [\"SELECT\", \"INSERT\", \"DELETE\", \"UPDATE\"], \"answer\": \"SELECT\", \"id\": \"q3\", \"option1\": \"SELECT\", \"option2\": \"INSERT\", \"option3\": \"DELETE\", \"option4\": \"UPDATE\", \"correct_answer\": \"SELECT\"}, {\"question\": \"Full form of SQL?\", \"options\": [\"Structured Query Language\", \"Simple Query Language\", \"Standard Question Language\", \"None\"], \"answer\": \"Structured Query Language\", \"id\": \"q4\", \"option1\": \"Structured Query Language\", \"option2\": \"Simple Query Language\", \"option3\": \"Standard Question Language\", \"option4\": \"None\", \"correct_answer\": \"Structured Query Language\"}, {\"question\": \"Which of the following is not DBMS?\", \"options\": [\"Excel\", \"MySQL\", \"Oracle\", \"PostgreSQL\"], \"answer\": \"Excel\", \"id\": \"q5\", \"option1\": \"Excel\", \"option2\": \"MySQL\", \"option3\": \"Oracle\", \"option4\": \"PostgreSQL\", \"correct_answer\": \"Excel\"}, {\"question\": \"Which normal form removes partial dependency?\", \"options\": [\"1NF\", \"2NF\", \"3NF\", \"BCNF\"], \"answer\": \"2NF\", \"id\": \"q6\", \"option1\": \"1NF\", \"option2\": \"2NF\", \"option3\": \"3NF\", \"option4\": \"BCNF\", \"correct_answer\": \"2NF\"}, {\"question\": \"Which join returns common records?\", \"options\": [\"INNER JOIN\", \"LEFT JOIN\", \"RIGHT JOIN\", \"FULL JOIN\"], \"answer\": \"INNER JOIN\", \"id\": \"q7\", \"option1\": \"INNER JOIN\", \"option2\": \"LEFT JOIN\", \"option3\": \"RIGHT JOIN\", \"option4\": \"FULL JOIN\", \"correct_answer\": \"INNER JOIN\"}, {\"question\": \"Primary key is used to?\", \"options\": [\"Uniquely identify records\", \"Delete records\", \"Update records\", \"None\"], \"answer\": \"Uniquely identify records\", \"id\": \"q8\", \"option1\": \"Uniquely identify records\", \"option2\": \"Delete records\", \"option3\": \"Update records\", \"option4\": \"None\", \"correct_answer\": \"Uniquely identify records\"}, {\"question\": \"Which clause filters records?\", \"options\": [\"WHERE\", \"GROUP BY\", \"ORDER BY\", \"HAVING\"], \"answer\": \"WHERE\", \"id\": \"q9\", \"option1\": \"WHERE\", \"option2\": \"GROUP BY\", \"option3\": \"ORDER BY\", \"option4\": \"HAVING\", \"correct_answer\": \"WHERE\"}, {\"question\": \"Which property ensures durability?\", \"options\": [\"ACID\", \"BASE\", \"CAP\", \"None\"], \"answer\": \"ACID\", \"id\": \"q10\", \"option1\": \"ACID\", \"option2\": \"BASE\", \"option3\": \"CAP\", \"option4\": \"None\", \"correct_answer\": \"ACID\"}, {\"question\": \"Which key allows duplicate values?\", \"options\": [\"Foreign Key\", \"Primary Key\", \"Unique Key\", \"None\"], \"answer\": \"Foreign Key\", \"id\": \"q11\", \"option1\": \"Foreign Key\", \"option2\": \"Primary Key\", \"option3\": \"Unique Key\", \"option4\": \"None\", \"correct_answer\": \"Foreign Key\"}, {\"question\": \"What does DBMS stand for?\", \"options\": [\"Database Management System\", \"Data Backup System\", \"Digital Base Management\", \"None\"], \"answer\": \"Database Management System\", \"id\": \"q12\", \"option1\": \"Database Management System\", \"option2\": \"Data Backup System\", \"option3\": \"Digital Base Management\", \"option4\": \"None\", \"correct_answer\": \"Database Management System\"}, {\"question\": \"Which function counts rows?\", \"options\": [\"COUNT()\", \"SUM()\", \"AVG()\", \"MAX()\"], \"answer\": \"COUNT()\", \"id\": \"q13\", \"option1\": \"COUNT()\", \"option2\": \"SUM()\", \"option3\": \"AVG()\", \"option4\": \"MAX()\", \"correct_answer\": \"COUNT()\"}, {\"question\": \"Which SQL command is DDL?\", \"options\": [\"CREATE\", \"SELECT\", \"INSERT\", \"UPDATE\"], \"answer\": \"CREATE\", \"id\": \"q14\", \"option1\": \"CREATE\", \"option2\": \"SELECT\", \"option3\": \"INSERT\", \"option4\": \"UPDATE\", \"correct_answer\": \"CREATE\"}, {\"question\": \"What is a foreign key?\", \"options\": [\"Key linking two tables\", \"Primary key\", \"Unique key\", \"None\"], \"answer\": \"Key linking two tables\", \"id\": \"q15\", \"option1\": \"Key linking two tables\", \"option2\": \"Primary key\", \"option3\": \"Unique key\", \"option4\": \"None\", \"correct_answer\": \"Key linking two tables\"}, {\"question\": \"Which of the following is a database?\", \"options\": [\"MySQL\", \"HTML\", \"CSS\", \"Python\"], \"answer\": \"MySQL\", \"id\": \"q16\", \"option1\": \"MySQL\", \"option2\": \"HTML\", \"option3\": \"CSS\", \"option4\": \"Python\", \"correct_answer\": \"MySQL\"}, {\"question\": \"What is transaction?\", \"options\": [\"Unit of work\", \"Table\", \"Query\", \"None\"], \"answer\": \"Unit of work\", \"id\": \"q17\", \"option1\": \"Unit of work\", \"option2\": \"Table\", \"option3\": \"Query\", \"option4\": \"None\", \"correct_answer\": \"Unit of work\"}, {\"question\": \"Which index improves search speed?\", \"options\": [\"B-Tree\", \"Array\", \"Stack\", \"Queue\"], \"answer\": \"B-Tree\", \"id\": \"q18\", \"option1\": \"B-Tree\", \"option2\": \"Array\", \"option3\": \"Stack\", \"option4\": \"Queue\", \"correct_answer\": \"B-Tree\"}, {\"question\": \"Which command removes table?\", \"options\": [\"DROP\", \"DELETE\", \"REMOVE\", \"CLEAR\"], \"answer\": \"DROP\", \"id\": \"q19\", \"option1\": \"DROP\", \"option2\": \"DELETE\", \"option3\": \"REMOVE\", \"option4\": \"CLEAR\", \"correct_answer\": \"DROP\"}, {\"question\": \"Which isolation level avoids dirty reads?\", \"options\": [\"READ COMMITTED\", \"READ UNCOMMITTED\", \"SERIALIZABLE\", \"NONE\"], \"answer\": \"READ COMMITTED\", \"id\": \"q20\", \"option1\": \"READ COMMITTED\", \"option2\": \"READ UNCOMMITTED\", \"option3\": \"SERIALIZABLE\", \"option4\": \"NONE\", \"correct_answer\": \"READ COMMITTED\"}, {\"question\": \"What is a table in DBMS?\", \"options\": [\"Collection of rows and columns\", \"A programming language\", \"A software\", \"None\"], \"answer\": \"Collection of rows and columns\", \"id\": \"q21\", \"option1\": \"Collection of rows and columns\", \"option2\": \"A programming language\", \"option3\": \"A software\", \"option4\": \"None\", \"correct_answer\": \"Collection of rows and columns\"}, {\"question\": \"What is BCNF?\", \"options\": [\"Advanced normal form\", \"Basic normal form\", \"Binary form\", \"None\"], \"answer\": \"Advanced normal form\", \"id\": \"q22\", \"option1\": \"Advanced normal form\", \"option2\": \"Basic normal form\", \"option3\": \"Binary form\", \"option4\": \"None\", \"correct_answer\": \"Advanced normal form\"}, {\"question\": \"Which key cannot be null?\", \"options\": [\"Primary Key\", \"Foreign Key\", \"Candidate Key\", \"None\"], \"answer\": \"Primary Key\", \"id\": \"q23\", \"option1\": \"Primary Key\", \"option2\": \"Foreign Key\", \"option3\": \"Candidate Key\", \"option4\": \"None\", \"correct_answer\": \"Primary Key\"}, {\"question\": \"Which join returns all records?\", \"options\": [\"FULL JOIN\", \"INNER JOIN\", \"LEFT JOIN\", \"RIGHT JOIN\"], \"answer\": \"FULL JOIN\", \"id\": \"q24\", \"option1\": \"FULL JOIN\", \"option2\": \"INNER JOIN\", \"option3\": \"LEFT JOIN\", \"option4\": \"RIGHT JOIN\", \"correct_answer\": \"FULL JOIN\"}, {\"question\": \"What is normalization?\", \"options\": [\"Reducing redundancy\", \"Increasing redundancy\", \"Deleting data\", \"None\"], \"answer\": \"Reducing redundancy\", \"id\": \"q25\", \"option1\": \"Reducing redundancy\", \"option2\": \"Increasing redundancy\", \"option3\": \"Deleting data\", \"option4\": \"None\", \"correct_answer\": \"Reducing redundancy\"}, {\"question\": \"Which constraint ensures uniqueness?\", \"options\": [\"UNIQUE\", \"NOT NULL\", \"CHECK\", \"DEFAULT\"], \"answer\": \"UNIQUE\", \"id\": \"q26\", \"option1\": \"UNIQUE\", \"option2\": \"NOT NULL\", \"option3\": \"CHECK\", \"option4\": \"DEFAULT\", \"correct_answer\": \"UNIQUE\"}, {\"question\": \"Which language is used in DBMS?\", \"options\": [\"SQL\", \"HTML\", \"CSS\", \"Java\"], \"answer\": \"SQL\", \"id\": \"q27\", \"option1\": \"SQL\", \"option2\": \"HTML\", \"option3\": \"CSS\", \"option4\": \"Java\", \"correct_answer\": \"SQL\"}, {\"question\": \"Which join returns all records from left table?\", \"options\": [\"LEFT JOIN\", \"INNER JOIN\", \"RIGHT JOIN\", \"FULL JOIN\"], \"answer\": \"LEFT JOIN\", \"id\": \"q28\", \"option1\": \"LEFT JOIN\", \"option2\": \"INNER JOIN\", \"option3\": \"RIGHT JOIN\", \"option4\": \"FULL JOIN\", \"correct_answer\": \"LEFT JOIN\"}, {\"question\": \"Which SQL keyword groups rows?\", \"options\": [\"GROUP BY\", \"ORDER BY\", \"WHERE\", \"HAVING\"], \"answer\": \"GROUP BY\", \"id\": \"q29\", \"option1\": \"GROUP BY\", \"option2\": \"ORDER BY\", \"option3\": \"WHERE\", \"option4\": \"HAVING\", \"correct_answer\": \"GROUP BY\"}, {\"question\": \"What is a row in DBMS?\", \"options\": [\"Record\", \"Column\", \"Table\", \"Database\"], \"answer\": \"Record\", \"id\": \"q30\", \"option1\": \"Record\", \"option2\": \"Column\", \"option3\": \"Table\", \"option4\": \"Database\", \"correct_answer\": \"Record\"}]', '{\"q1\": \"UPDATE\", \"q2\": \"1NF\", \"q3\": \"SELECT\", \"q4\": \"Structured Query Language\", \"q5\": \"MySQL\", \"q6\": \"BCNF\", \"q7\": \"INNER JOIN\", \"q8\": \"Uniquely identify records\", \"q9\": \"WHERE\", \"q10\": \"CAP\", \"q11\": \"Foreign Key\", \"q12\": \"Database Management System\", \"q13\": \"COUNT()\", \"q14\": \"CREATE\", \"q15\": \"Primary key\", \"q16\": \"MySQL\", \"q17\": \"Table\", \"q19\": \"DROP\", \"q20\": \"READ COMMITTED\", \"q21\": \"A programming language\", \"q22\": \"Basic normal form\", \"q23\": \"Primary Key\", \"q24\": \"RIGHT JOIN\", \"q25\": \"Reducing redundancy\", \"q26\": \"NOT NULL\", \"q27\": \"HTML\", \"q28\": \"RIGHT JOIN\", \"q29\": \"WHERE\", \"q30\": \"Record\", \"time_remaining\": \"1706\"}', 16, 'completed', 'PASSED'),
(2, 'ramesh@gamil.com', 1, '[{\"question\": \"Which property ensures durability?\", \"options\": [\"ACID\", \"BASE\", \"CAP\", \"None\"], \"answer\": \"ACID\", \"id\": \"q1\", \"option1\": \"ACID\", \"option2\": \"BASE\", \"option3\": \"CAP\", \"option4\": \"None\", \"correct_answer\": \"ACID\"}, {\"question\": \"What is a row in DBMS?\", \"options\": [\"Record\", \"Column\", \"Table\", \"Database\"], \"answer\": \"Record\", \"id\": \"q2\", \"option1\": \"Record\", \"option2\": \"Column\", \"option3\": \"Table\", \"option4\": \"Database\", \"correct_answer\": \"Record\"}, {\"question\": \"Which function counts rows?\", \"options\": [\"COUNT()\", \"SUM()\", \"AVG()\", \"MAX()\"], \"answer\": \"COUNT()\", \"id\": \"q3\", \"option1\": \"COUNT()\", \"option2\": \"SUM()\", \"option3\": \"AVG()\", \"option4\": \"MAX()\", \"correct_answer\": \"COUNT()\"}, {\"question\": \"Which language is used in DBMS?\", \"options\": [\"SQL\", \"HTML\", \"CSS\", \"Java\"], \"answer\": \"SQL\", \"id\": \"q4\", \"option1\": \"SQL\", \"option2\": \"HTML\", \"option3\": \"CSS\", \"option4\": \"Java\", \"correct_answer\": \"SQL\"}, {\"question\": \"Which normal form removes transitive dependency?\", \"options\": [\"1NF\", \"2NF\", \"3NF\", \"BCNF\"], \"answer\": \"3NF\", \"id\": \"q5\", \"option1\": \"1NF\", \"option2\": \"2NF\", \"option3\": \"3NF\", \"option4\": \"BCNF\", \"correct_answer\": \"3NF\"}, {\"question\": \"Which join returns all records from left table?\", \"options\": [\"LEFT JOIN\", \"INNER JOIN\", \"RIGHT JOIN\", \"FULL JOIN\"], \"answer\": \"LEFT JOIN\", \"id\": \"q6\", \"option1\": \"LEFT JOIN\", \"option2\": \"INNER JOIN\", \"option3\": \"RIGHT JOIN\", \"option4\": \"FULL JOIN\", \"correct_answer\": \"LEFT JOIN\"}, {\"question\": \"Which join returns common records?\", \"options\": [\"INNER JOIN\", \"LEFT JOIN\", \"RIGHT JOIN\", \"FULL JOIN\"], \"answer\": \"INNER JOIN\", \"id\": \"q7\", \"option1\": \"INNER JOIN\", \"option2\": \"LEFT JOIN\", \"option3\": \"RIGHT JOIN\", \"option4\": \"FULL JOIN\", \"correct_answer\": \"INNER JOIN\"}, {\"question\": \"Which SQL keyword groups rows?\", \"options\": [\"GROUP BY\", \"ORDER BY\", \"WHERE\", \"HAVING\"], \"answer\": \"GROUP BY\", \"id\": \"q8\", \"option1\": \"GROUP BY\", \"option2\": \"ORDER BY\", \"option3\": \"WHERE\", \"option4\": \"HAVING\", \"correct_answer\": \"GROUP BY\"}, {\"question\": \"Primary key is used to?\", \"options\": [\"Uniquely identify records\", \"Delete records\", \"Update records\", \"None\"], \"answer\": \"Uniquely identify records\", \"id\": \"q9\", \"option1\": \"Uniquely identify records\", \"option2\": \"Delete records\", \"option3\": \"Update records\", \"option4\": \"None\", \"correct_answer\": \"Uniquely identify records\"}, {\"question\": \"What is BCNF?\", \"options\": [\"Advanced normal form\", \"Basic normal form\", \"Binary form\", \"None\"], \"answer\": \"Advanced normal form\", \"id\": \"q10\", \"option1\": \"Advanced normal form\", \"option2\": \"Basic normal form\", \"option3\": \"Binary form\", \"option4\": \"None\", \"correct_answer\": \"Advanced normal form\"}, {\"question\": \"What is normalization?\", \"options\": [\"Reducing redundancy\", \"Increasing redundancy\", \"Deleting data\", \"None\"], \"answer\": \"Reducing redundancy\", \"id\": \"q11\", \"option1\": \"Reducing redundancy\", \"option2\": \"Increasing redundancy\", \"option3\": \"Deleting data\", \"option4\": \"None\", \"correct_answer\": \"Reducing redundancy\"}, {\"question\": \"What is a table in DBMS?\", \"options\": [\"Collection of rows and columns\", \"A programming language\", \"A software\", \"None\"], \"answer\": \"Collection of rows and columns\", \"id\": \"q12\", \"option1\": \"Collection of rows and columns\", \"option2\": \"A programming language\", \"option3\": \"A software\", \"option4\": \"None\", \"correct_answer\": \"Collection of rows and columns\"}, {\"question\": \"Which command updates data?\", \"options\": [\"UPDATE\", \"INSERT\", \"DELETE\", \"DROP\"], \"answer\": \"UPDATE\", \"id\": \"q13\", \"option1\": \"UPDATE\", \"option2\": \"INSERT\", \"option3\": \"DELETE\", \"option4\": \"DROP\", \"correct_answer\": \"UPDATE\"}, {\"question\": \"What is a foreign key?\", \"options\": [\"Key linking two tables\", \"Primary key\", \"Unique key\", \"None\"], \"answer\": \"Key linking two tables\", \"id\": \"q14\", \"option1\": \"Key linking two tables\", \"option2\": \"Primary key\", \"option3\": \"Unique key\", \"option4\": \"None\", \"correct_answer\": \"Key linking two tables\"}, {\"question\": \"Which SQL command is DDL?\", \"options\": [\"CREATE\", \"SELECT\", \"INSERT\", \"UPDATE\"], \"answer\": \"CREATE\", \"id\": \"q15\", \"option1\": \"CREATE\", \"option2\": \"SELECT\", \"option3\": \"INSERT\", \"option4\": \"UPDATE\", \"correct_answer\": \"CREATE\"}, {\"question\": \"Which of the following is a database?\", \"options\": [\"MySQL\", \"HTML\", \"CSS\", \"Python\"], \"answer\": \"MySQL\", \"id\": \"q16\", \"option1\": \"MySQL\", \"option2\": \"HTML\", \"option3\": \"CSS\", \"option4\": \"Python\", \"correct_answer\": \"MySQL\"}, {\"question\": \"What does DBMS stand for?\", \"options\": [\"Database Management System\", \"Data Backup System\", \"Digital Base Management\", \"None\"], \"answer\": \"Database Management System\", \"id\": \"q17\", \"option1\": \"Database Management System\", \"option2\": \"Data Backup System\", \"option3\": \"Digital Base Management\", \"option4\": \"None\", \"correct_answer\": \"Database Management System\"}, {\"question\": \"What is transaction?\", \"options\": [\"Unit of work\", \"Table\", \"Query\", \"None\"], \"answer\": \"Unit of work\", \"id\": \"q18\", \"option1\": \"Unit of work\", \"option2\": \"Table\", \"option3\": \"Query\", \"option4\": \"None\", \"correct_answer\": \"Unit of work\"}, {\"question\": \"Which command is used to retrieve data?\", \"options\": [\"SELECT\", \"INSERT\", \"DELETE\", \"UPDATE\"], \"answer\": \"SELECT\", \"id\": \"q19\", \"option1\": \"SELECT\", \"option2\": \"INSERT\", \"option3\": \"DELETE\", \"option4\": \"UPDATE\", \"correct_answer\": \"SELECT\"}, {\"question\": \"Which join returns all records?\", \"options\": [\"FULL JOIN\", \"INNER JOIN\", \"LEFT JOIN\", \"RIGHT JOIN\"], \"answer\": \"FULL JOIN\", \"id\": \"q20\", \"option1\": \"FULL JOIN\", \"option2\": \"INNER JOIN\", \"option3\": \"LEFT JOIN\", \"option4\": \"RIGHT JOIN\", \"correct_answer\": \"FULL JOIN\"}, {\"question\": \"Which of the following is not DBMS?\", \"options\": [\"Excel\", \"MySQL\", \"Oracle\", \"PostgreSQL\"], \"answer\": \"Excel\", \"id\": \"q21\", \"option1\": \"Excel\", \"option2\": \"MySQL\", \"option3\": \"Oracle\", \"option4\": \"PostgreSQL\", \"correct_answer\": \"Excel\"}, {\"question\": \"Which key cannot be null?\", \"options\": [\"Primary Key\", \"Foreign Key\", \"Candidate Key\", \"None\"], \"answer\": \"Primary Key\", \"id\": \"q22\", \"option1\": \"Primary Key\", \"option2\": \"Foreign Key\", \"option3\": \"Candidate Key\", \"option4\": \"None\", \"correct_answer\": \"Primary Key\"}, {\"question\": \"Full form of SQL?\", \"options\": [\"Structured Query Language\", \"Simple Query Language\", \"Standard Question Language\", \"None\"], \"answer\": \"Structured Query Language\", \"id\": \"q23\", \"option1\": \"Structured Query Language\", \"option2\": \"Simple Query Language\", \"option3\": \"Standard Question Language\", \"option4\": \"None\", \"correct_answer\": \"Structured Query Language\"}, {\"question\": \"Which index improves search speed?\", \"options\": [\"B-Tree\", \"Array\", \"Stack\", \"Queue\"], \"answer\": \"B-Tree\", \"id\": \"q24\", \"option1\": \"B-Tree\", \"option2\": \"Array\", \"option3\": \"Stack\", \"option4\": \"Queue\", \"correct_answer\": \"B-Tree\"}, {\"question\": \"Which clause filters records?\", \"options\": [\"WHERE\", \"GROUP BY\", \"ORDER BY\", \"HAVING\"], \"answer\": \"WHERE\", \"id\": \"q25\", \"option1\": \"WHERE\", \"option2\": \"GROUP BY\", \"option3\": \"ORDER BY\", \"option4\": \"HAVING\", \"correct_answer\": \"WHERE\"}, {\"question\": \"Which key allows duplicate values?\", \"options\": [\"Foreign Key\", \"Primary Key\", \"Unique Key\", \"None\"], \"answer\": \"Foreign Key\", \"id\": \"q26\", \"option1\": \"Foreign Key\", \"option2\": \"Primary Key\", \"option3\": \"Unique Key\", \"option4\": \"None\", \"correct_answer\": \"Foreign Key\"}, {\"question\": \"Which command removes table?\", \"options\": [\"DROP\", \"DELETE\", \"REMOVE\", \"CLEAR\"], \"answer\": \"DROP\", \"id\": \"q27\", \"option1\": \"DROP\", \"option2\": \"DELETE\", \"option3\": \"REMOVE\", \"option4\": \"CLEAR\", \"correct_answer\": \"DROP\"}, {\"question\": \"Which isolation level avoids dirty reads?\", \"options\": [\"READ COMMITTED\", \"READ UNCOMMITTED\", \"SERIALIZABLE\", \"NONE\"], \"answer\": \"READ COMMITTED\", \"id\": \"q28\", \"option1\": \"READ COMMITTED\", \"option2\": \"READ UNCOMMITTED\", \"option3\": \"SERIALIZABLE\", \"option4\": \"NONE\", \"correct_answer\": \"READ COMMITTED\"}, {\"question\": \"Which normal form removes partial dependency?\", \"options\": [\"1NF\", \"2NF\", \"3NF\", \"BCNF\"], \"answer\": \"2NF\", \"id\": \"q29\", \"option1\": \"1NF\", \"option2\": \"2NF\", \"option3\": \"3NF\", \"option4\": \"BCNF\", \"correct_answer\": \"2NF\"}, {\"question\": \"Which constraint ensures uniqueness?\", \"options\": [\"UNIQUE\", \"NOT NULL\", \"CHECK\", \"DEFAULT\"], \"answer\": \"UNIQUE\", \"id\": \"q30\", \"option1\": \"UNIQUE\", \"option2\": \"NOT NULL\", \"option3\": \"CHECK\", \"option4\": \"DEFAULT\", \"correct_answer\": \"UNIQUE\"}]', '{\"q1\": \"ACID\", \"q2\": \"Record\", \"q3\": \"COUNT()\", \"q4\": \"SQL\", \"q5\": \"1NF\", \"q6\": \"LEFT JOIN\", \"q7\": \"INNER JOIN\", \"q8\": \"GROUP BY\", \"q9\": \"Uniquely identify records\", \"q10\": \"Advanced normal form\", \"q11\": \"Reducing redundancy\", \"q12\": \"Collection of rows and columns\", \"q13\": \"UPDATE\", \"q14\": \"Key linking two tables\", \"q15\": \"SELECT\", \"q16\": \"MySQL\", \"q17\": \"None\", \"q18\": \"Unit of work\", \"q19\": \"DELETE\", \"q20\": \"INNER JOIN\", \"q21\": \"Excel\", \"q22\": \"Primary Key\", \"q23\": \"Standard Question Language\", \"q24\": \"Queue\", \"q25\": \"GROUP BY\", \"q26\": \"Foreign Key\", \"q27\": \"CLEAR\", \"q28\": \"READ COMMITTED\", \"q29\": \"1NF\", \"q30\": \"NOT NULL\", \"time_remaining\": \"1713\"}', 19, 'completed', 'PASSED'),
(3, 'sanvi@gmail.com', 2, '[{\"question\": \"Which constraint ensures uniqueness?\", \"options\": [\"UNIQUE\", \"NOT NULL\", \"CHECK\", \"DEFAULT\"], \"answer\": \"UNIQUE\", \"id\": \"q1\", \"option1\": \"UNIQUE\", \"option2\": \"NOT NULL\", \"option3\": \"CHECK\", \"option4\": \"DEFAULT\", \"correct_answer\": \"UNIQUE\"}, {\"question\": \"What is BCNF?\", \"options\": [\"Advanced normal form\", \"Basic normal form\", \"Binary form\", \"None\"], \"answer\": \"Advanced normal form\", \"id\": \"q2\", \"option1\": \"Advanced normal form\", \"option2\": \"Basic normal form\", \"option3\": \"Binary form\", \"option4\": \"None\", \"correct_answer\": \"Advanced normal form\"}, {\"question\": \"Which key allows duplicate values?\", \"options\": [\"Foreign Key\", \"Primary Key\", \"Unique Key\", \"None\"], \"answer\": \"Foreign Key\", \"id\": \"q3\", \"option1\": \"Foreign Key\", \"option2\": \"Primary Key\", \"option3\": \"Unique Key\", \"option4\": \"None\", \"correct_answer\": \"Foreign Key\"}]', '{\"q1\": \"UNIQUE\", \"q2\": \"Advanced normal form\", \"q3\": \"Foreign Key\", \"time_remaining\": \"168\"}', 3, 'completed', 'PASSED'),
(4, 'ragu@gamil.com', 3, '[{\"question\": \"Which function counts rows?\", \"options\": [\"COUNT()\", \"SUM()\", \"AVG()\", \"MAX()\"], \"answer\": \"COUNT()\", \"id\": \"q1\", \"option1\": \"COUNT()\", \"option2\": \"SUM()\", \"option3\": \"AVG()\", \"option4\": \"MAX()\", \"correct_answer\": \"COUNT()\"}, {\"question\": \"Which join returns all records from left table?\", \"options\": [\"LEFT JOIN\", \"INNER JOIN\", \"RIGHT JOIN\", \"FULL JOIN\"], \"answer\": \"LEFT JOIN\", \"id\": \"q2\", \"option1\": \"LEFT JOIN\", \"option2\": \"INNER JOIN\", \"option3\": \"RIGHT JOIN\", \"option4\": \"FULL JOIN\", \"correct_answer\": \"LEFT JOIN\"}, {\"question\": \"What is a row in DBMS?\", \"options\": [\"Record\", \"Column\", \"Table\", \"Database\"], \"answer\": \"Record\", \"id\": \"q3\", \"option1\": \"Record\", \"option2\": \"Column\", \"option3\": \"Table\", \"option4\": \"Database\", \"correct_answer\": \"Record\"}, {\"question\": \"What is a table in DBMS?\", \"options\": [\"Collection of rows and columns\", \"A programming language\", \"A software\", \"None\"], \"answer\": \"Collection of rows and columns\", \"id\": \"q4\", \"option1\": \"Collection of rows and columns\", \"option2\": \"A programming language\", \"option3\": \"A software\", \"option4\": \"None\", \"correct_answer\": \"Collection of rows and columns\"}, {\"question\": \"Full form of SQL?\", \"options\": [\"Structured Query Language\", \"Simple Query Language\", \"Standard Question Language\", \"None\"], \"answer\": \"Structured Query Language\", \"id\": \"q5\", \"option1\": \"Structured Query Language\", \"option2\": \"Simple Query Language\", \"option3\": \"Standard Question Language\", \"option4\": \"None\", \"correct_answer\": \"Structured Query Language\"}, {\"question\": \"What is normalization?\", \"options\": [\"Reducing redundancy\", \"Increasing redundancy\", \"Deleting data\", \"None\"], \"answer\": \"Reducing redundancy\", \"id\": \"q6\", \"option1\": \"Reducing redundancy\", \"option2\": \"Increasing redundancy\", \"option3\": \"Deleting data\", \"option4\": \"None\", \"correct_answer\": \"Reducing redundancy\"}, {\"question\": \"Primary key is used to?\", \"options\": [\"Uniquely identify records\", \"Delete records\", \"Update records\", \"None\"], \"answer\": \"Uniquely identify records\", \"id\": \"q7\", \"option1\": \"Uniquely identify records\", \"option2\": \"Delete records\", \"option3\": \"Update records\", \"option4\": \"None\", \"correct_answer\": \"Uniquely identify records\"}, {\"question\": \"Which normal form removes partial dependency?\", \"options\": [\"1NF\", \"2NF\", \"3NF\", \"BCNF\"], \"answer\": \"2NF\", \"id\": \"q8\", \"option1\": \"1NF\", \"option2\": \"2NF\", \"option3\": \"3NF\", \"option4\": \"BCNF\", \"correct_answer\": \"2NF\"}, {\"question\": \"What is BCNF?\", \"options\": [\"Advanced normal form\", \"Basic normal form\", \"Binary form\", \"None\"], \"answer\": \"Advanced normal form\", \"id\": \"q9\", \"option1\": \"Advanced normal form\", \"option2\": \"Basic normal form\", \"option3\": \"Binary form\", \"option4\": \"None\", \"correct_answer\": \"Advanced normal form\"}, {\"question\": \"Which language is used in DBMS?\", \"options\": [\"SQL\", \"HTML\", \"CSS\", \"Java\"], \"answer\": \"SQL\", \"id\": \"q10\", \"option1\": \"SQL\", \"option2\": \"HTML\", \"option3\": \"CSS\", \"option4\": \"Java\", \"correct_answer\": \"SQL\"}]', '{\"q1\": \"COUNT()\", \"q2\": \"LEFT JOIN\", \"q3\": \"Record\", \"q4\": \"Collection of rows and columns\", \"q5\": \"Structured Query Language\", \"q6\": \"Reducing redundancy\", \"q7\": \"Delete records\", \"q8\": \"2NF\", \"q9\": \"Binary form\", \"q10\": \"SQL\", \"time_remaining\": \"548\"}', 8, 'completed', 'PASSED');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `option1` varchar(255) DEFAULT NULL,
  `option2` varchar(255) DEFAULT NULL,
  `option3` varchar(255) DEFAULT NULL,
  `option4` varchar(255) DEFAULT NULL,
  `correct_answer` varchar(255) DEFAULT NULL,
  `difficulty` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentss`
--

CREATE TABLE `studentss` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `school` varchar(150) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL,
  `roll_no` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `assessment_status` varchar(50) DEFAULT 'NOT_STARTED',
  `score` int(11) DEFAULT 0,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentss`
--

INSERT INTO `studentss` (`id`, `name`, `email`, `password`, `course`, `school`, `semester`, `roll_no`, `photo`, `assessment_status`, `score`, `reset_token`, `reset_token_expiry`) VALUES
(1, 'Arun', 'aruns@gamil.com', 'scrypt:32768:8:1$BEVRkkmjIwWBnbxo$2f1416df33a8d8864884b87f2a18ba7fdd508573fc90b8cfeeb7dbe8bc7332cc4e0bfc65307ab04c16c0c67814fbbe398a8898210162f7b6ecfa1f06ff83a1d7', 'Data Science', 'Manipal InstituteOf Technology', '4', 101, 'aa7022d1-3089-4446-82cc-054818638f4b_pss.jpg', 'NOT_STARTED', 0, NULL, NULL),
(2, 'Sanvi', 'sanvi@gmail.com', 'scrypt:32768:8:1$jA3eZOtG6xEBZNz1$91140fa4b0c6b8bf421ec78a21c07dfc698b14d21a96bb6cc80ed79286c3ce65ab73307698fefd27318f3be603a82b5e74e0e26b8ce5bf1cc2a047bc7540f18e', 'Data Science', 'Manipal InstituteOf Technology', '4', 105, '1cca5b66-faa1-4258-bf7f-53bcec34941a_pss.jpg', 'NOT_STARTED', 0, NULL, NULL),
(3, 'Ramesh', 'ramesh@gamil.com', 'scrypt:32768:8:1$ANDmLRvAhFXFubnU$14b135f544b1edcf2626b50ee4832875cf406485e63351ff17828211d191d48c38242765eb105fd701d9eb6d1d1c5c5c155a9379cf9a9baf3bf55c9cd29dc0df', 'Data Science', 'Manipal InstituteOf Technology', '4', 102, '0084b429-9bb6-4fa6-906a-7c3ece989be3_images_1.jpg', 'NOT_STARTED', 0, NULL, NULL),
(4, 'Ragu', 'ragu@gamil.com', 'scrypt:32768:8:1$vbfLRzAGy6TT76yd$a11ffd3a925fbd3a939c8fab2571877bad7b0a0448437ac3299a9f5b725b5f06b992aa3b4f5911a92d3d213fa35f00be7a1a140d5778d9cb43a9498b5ee17001', 'Machine Learning', 'Manipal InstituteOf Technology', '4', 103, '1972c9c4-1f35-42f1-b2c0-f4ba91993b91_images_1.jpg', 'NOT_STARTED', 0, NULL, NULL),
(5, 'Puneeth Acharya', 'puneeth17me047@gmail.com', 'scrypt:32768:8:1$YlnP9yQoUGYMhvng$1bc0e78bf4afbd1142c508f2f0bff8ae43ad452b26df2a56ca5b9a99a3df7cf18069fbe11e2cc1d1f4c6562c4d21ef74795561fecc52052290a59ed2859edff0', 'Full Stack Development', 'Manipal skill developmentcenter', '4', 108, '3019e622-fa55-49e8-9d8f-d604404ed061_images_1.jpg', 'NOT_STARTED', 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `student_email` (`student_email`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`);

--
-- Indexes for table `studentss`
--
ALTER TABLE `studentss`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `roll_no` (`roll_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment`
--
ALTER TABLE `assessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentss`
--
ALTER TABLE `studentss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  ADD CONSTRAINT `exam_attempts_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  ADD CONSTRAINT `exam_attempts_ibfk_2` FOREIGN KEY (`student_email`) REFERENCES `studentss` (`email`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
