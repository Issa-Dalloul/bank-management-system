
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2024 at 04:46 PM
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
-- Database: `dbank`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acnumber` int(11) NOT NULL,
  `custid` int(11) DEFAULT NULL,
  `bid` int(11) DEFAULT NULL,
  `opening_balance` decimal(10,2) DEFAULT NULL,
  `aod` date DEFAULT NULL,
  `atype` varchar(50) DEFAULT NULL,
  `astatus` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acnumber`, `custid`, `bid`, `opening_balance`, `aod`, `atype`, `astatus`) VALUES
(1, 11, 101, 1000.00, '2022-01-01', 'Savings', 'Active'),
(2, 5, 101, 1000.00, '2022-01-01', 'Savings', 'Active'),
(3, 7, 101, 1500.00, '2022-01-15', 'Checking', 'Active');

--
-- Triggers `account`
--
DELIMITER $$
CREATE TRIGGER `tr_check_non_negative_balance` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
    IF NEW.opening_balance < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Opening balance cannot be negative';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_prevent_duplicate_accounts` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1
        FROM account
        WHERE custid = NEW.custid
        AND bid = NEW.bid
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer already has an account with the specified branch.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminid`, `username`, `password`, `email`) VALUES
(3, 'ossama', '123', 'newadmin@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `bid` varchar(6) NOT NULL,
  `bname` varchar(30) DEFAULT NULL,
  `bcity` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`bid`, `bname`, `bcity`) VALUES
('B00001', 'Asaf ali road', 'Delhi'),
('B00002', 'New delhi main branch', 'Delhi'),
('B00003', 'Delhi cantt', 'Delhi'),
('B00004', 'Jasola', 'Delhi'),
('B00005', 'Mahim', 'Mumbai'),
('B00006', 'Vile parle', 'Mumbai'),
('B00007', 'Mandvi', 'Mumbai'),
('B00008', 'Jadavpur', 'Kolkata'),
('B00009', 'Kodambakkam', 'Chennai');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `message_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message_text` text NOT NULL,
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `custid` int(11) NOT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `mname` varchar(30) DEFAULT NULL,
  `ltname` varchar(30) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `mobileno` varchar(10) DEFAULT NULL,
  `occupation` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custid`, `fname`, `mname`, `ltname`, `city`, `mobileno`, `occupation`, `dob`) VALUES
(7, 'issa', 'ziad', 'dalloul', 'beirut', '71067246', 'software e', '2003-06-02');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `custid` varchar(6) NOT NULL,
  `bid` varchar(6) NOT NULL,
  `loan_amount` int(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`custid`, `bid`, `loan_amount`) VALUES
('7', '101', 2000);

--
-- Triggers `loan`
--
DELIMITER $$
CREATE TRIGGER `tr_loan_approval_limits` BEFORE INSERT ON `loan` FOR EACH ROW BEGIN
    IF NEW.loan_amount > 1000000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Loan amount exceeds approval limit';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_prevent_duplicate_loan_requests` BEFORE INSERT ON `loan` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1
        FROM loan
        WHERE custid = NEW.custid
        AND bid = NEW.bid
        AND loan_amount > 0
       
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer already has a pending loan request with the specified branch.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `application_id` int(11) NOT NULL,
  `custid` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trandetails`
--

CREATE TABLE `trandetails` (
  `tnumber` varchar(6) NOT NULL,
  `acnumber` varchar(6) DEFAULT NULL,
  `dot` date DEFAULT NULL,
  `medium_of_transaction` varchar(20) DEFAULT NULL,
  `transaction_type` varchar(20) DEFAULT NULL,
  `transaction_amount` int(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trandetails`
--

INSERT INTO `trandetails` (`tnumber`, `acnumber`, `dot`, `medium_of_transaction`, `transaction_type`, `transaction_amount`) VALUES
('', '3', '2022-01-15', 'Online', 'Withdrawal', 200);

--
-- Triggers `trandetails`
--
DELIMITER $$
CREATE TRIGGER `tr_check_non_negative_transaction_amount` BEFORE INSERT ON `trandetails` FOR EACH ROW BEGIN
    IF NEW.transaction_amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction amount cannot be negative';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_check_transaction_amount_vs_balance` BEFORE INSERT ON `trandetails` FOR EACH ROW BEGIN
    DECLARE current_balance DECIMAL(10, 2);
    SELECT opening_balance INTO current_balance FROM account WHERE acnumber = NEW.acnumber;

    IF NEW.transaction_amount > current_balance THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction amount exceeds the account balance';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `custid` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_type` enum('customer','admin') DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `custid`, `username`, `password`, `email`, `user_type`) VALUES
(0, 7, 'issa', '123', 'issadalloul262003@gmail.com', 'customer'),
(0, NULL, 'ossama', '123', 'newadmin@example.com', 'admin');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `tr_check_unique_username` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE username = NEW.username
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username must be unique';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_loan_details`
-- (See below for the actual view)
--
CREATE TABLE `vw_loan_details` (
`custid` varchar(6)
,`bid` varchar(6)
,`loan_amount` int(7)
,`fname` varchar(30)
,`ltname` varchar(30)
,`bname` varchar(30)
,`bcity` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_total_balance_per_customer`
-- (See below for the actual view)
--
CREATE TABLE `vw_total_balance_per_customer` (
`custid` int(11)
,`fname` varchar(30)
,`ltname` varchar(30)
,`total_balance` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_loan_details`
--
DROP TABLE IF EXISTS `vw_loan_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_loan_details`  AS SELECT `l`.`custid` AS `custid`, `l`.`bid` AS `bid`, `l`.`loan_amount` AS `loan_amount`, `c`.`fname` AS `fname`, `c`.`ltname` AS `ltname`, `b`.`bname` AS `bname`, `b`.`bcity` AS `bcity` FROM ((`loan` `l` join `customer` `c` on(`l`.`custid` = `c`.`custid`)) join `branch` `b` on(`l`.`bid` = `b`.`bid`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_total_balance_per_customer`
--
DROP TABLE IF EXISTS `vw_total_balance_per_customer`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_total_balance_per_customer`  AS SELECT `c`.`custid` AS `custid`, `c`.`fname` AS `fname`, `c`.`ltname` AS `ltname`, sum(`a`.`opening_balance`) AS `total_balance` FROM (`customer` `c` join `account` `a` on(`c`.`custid` = `a`.`custid`)) GROUP BY `c`.`custid`, `c`.`fname`, `c`.`ltname` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acnumber`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`custid`),
  ADD KEY `idx_customer_dob` (`dob`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`custid`,`bid`),
  ADD KEY `idx_loan_custid` (`custid`),
  ADD KEY `idx_loan_bid` (`bid`),
  ADD KEY `idx_loan_loan_amount` (`loan_amount`);

--
-- Indexes for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`application_id`);

--
-- Indexes for table `trandetails`
--
ALTER TABLE `trandetails`
  ADD PRIMARY KEY (`tnumber`),
  ADD KEY `idx_trandetails_acnumber` (`acnumber`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `acnumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `adminid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `custid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
