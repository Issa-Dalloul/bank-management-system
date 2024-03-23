-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2024 at 12:28 AM
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
  `acnumber` varchar(6) NOT NULL,
  `custid` varchar(6) DEFAULT NULL,
  `bid` varchar(6) DEFAULT NULL,
  `opening_balance` int(7) DEFAULT NULL,
  `aod` date DEFAULT NULL,
  `atype` varchar(10) DEFAULT NULL,
  `astatus` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acnumber`, `custid`, `bid`, `opening_balance`, `aod`, `atype`, `astatus`) VALUES
('A00001', 'C00001', 'B00001', 1000, '2012-12-15', 'Saving', 'Active'),
('A00002', 'C00002', 'B00001', 1000, '2012-06-12', 'Saving', 'Active'),
('A00003', 'C00003', 'B00002', 1000, '2012-05-17', 'Saving', 'Active'),
('A00004', 'C00002', 'B00005', 1000, '2013-01-27', 'Saving', 'Active'),
('A00005', 'C00006', 'B00006', 1000, '2012-12-17', 'Saving', 'Active'),
('A00006', 'C00007', 'B00007', 1000, '2010-08-12', 'Saving', 'Suspended'),
('A00007', 'C00007', 'B00001', 1000, '2012-10-02', 'Saving', 'Active'),
('A00008', 'C00001', 'B00003', 1000, '2009-11-09', 'Saving', 'Terminated'),
('A00009', 'C00003', 'B00007', 1000, '2008-11-30', 'Saving', 'Terminated'),
('A00010', 'C00004', 'B00002', 1000, '2013-03-01', 'Saving', 'Active');

--
-- Triggers `account`
--
DELIMITER $$
CREATE TRIGGER `tr_prevent_negative_balances` BEFORE UPDATE ON `account` FOR EACH ROW BEGIN
    IF NEW.opening_balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account balance cannot go negative.';
    END IF;
END
$$
DELIMITER ;

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
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `custid` varchar(6) NOT NULL,
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
('C00001', 'Ramesh', 'Chandra', 'Sharma', 'Delhi', '9543198345', 'Service', '1976-12-06'),
('C00002', 'Avinash', 'Sunder', 'Minha', 'Delhi', '9876532109', 'Service', '1974-10-16'),
('C00003', 'Rahul', NULL, 'Rastogi', 'Delhi', '9765178901', 'Student', '1981-09-26'),
('C00004', 'Parul', NULL, 'Gandhi', 'Delhi', '9876532109', 'Housewife', '1976-11-03'),
('C00005', 'Naveen', 'Chandra', 'Aedekar', 'Mumbai', '8976523190', 'Service', '1976-09-19'),
('C00006', 'Chitresh', NULL, 'Barwe', 'Mumbai', '7651298321', 'Student', '1992-11-06'),
('C00007', 'Amit', 'Kumar', 'Borkar', 'Mumbai', '9875189761', 'Student', '1981-09-06'),
('C00008', 'Nisha', NULL, 'Damle', 'Mumbai', '7954198761', 'Service', '1975-12-03'),
('C00009', 'Abhishek', NULL, 'Dutta', 'Kolkata', '9856198761', 'Service', '1973-05-22'),
('C00010', 'Shankar', NULL, 'Nair', 'Chennai', '8765489076', 'Service', '1976-07-12');

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
('C00001', 'B00001', 100000),
('C00002', 'B00002', 200000),
('C00009', 'B00008', 400000),
('C00010', 'B00009', 500000),
('C00001', 'B00003', 600000),
('C00002', 'B00001', 600000);

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
        AND astatus = 'Pending'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer already has a pending loan request with the specified branch.';
    END IF;
END
$$
DELIMITER ;

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
('T00001', 'A00001', '2013-01-01', 'Cheque', 'Deposit', 2000),
('T00002', 'A00001', '2013-02-01', 'Cash', 'Withdrawal', 1000),
('T00003', 'A00002', '2013-01-01', 'Cash', 'Deposit', 2000),
('T00004', 'A00002', '2013-02-01', 'Cash', 'Deposit', 3000),
('T00005', 'A00007', '2013-01-11', 'Cash', 'Deposit', 7000),
('T00006', 'A00007', '2013-01-13', 'Cash', 'Deposit', 9000),
('T00007', 'A00001', '2013-03-13', 'Cash', 'Deposit', 4000),
('T00008', 'A00001', '2013-03-14', 'Cheque', 'Deposit', 3000),
('T00009', 'A00001', '2013-03-21', 'Cash', 'Withdrawal', 9000),
('T00010', 'A00001', '2013-03-22', 'Cash', 'Withdrawal', 2000),
('T00011', 'A00002', '2013-03-25', 'Cash', 'Withdrawal', 7000),
('T00012', 'A00007', '2013-03-26', 'Cash', 'Withdrawal', 2000);

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
`custid` varchar(6)
,`fname` varchar(30)
,`ltname` varchar(30)
,`total_balance` decimal(32,0)
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
  ADD PRIMARY KEY (`acnumber`),
  ADD KEY `idx_account_custid` (`custid`),
  ADD KEY `idx_account_bid` (`bid`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`bid`);

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
-- Indexes for table `trandetails`
--
ALTER TABLE `trandetails`
  ADD PRIMARY KEY (`tnumber`),
  ADD KEY `idx_trandetails_acnumber` (`acnumber`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_bid_fk` FOREIGN KEY (`bid`) REFERENCES `branch` (`bid`),
  ADD CONSTRAINT `account_custid_fk` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_bid_fk` FOREIGN KEY (`bid`) REFERENCES `branch` (`bid`),
  ADD CONSTRAINT `loan_custid_fk` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`);

--
-- Constraints for table `trandetails`
--
ALTER TABLE `trandetails`
  ADD CONSTRAINT `trandetails_acnumber_fk` FOREIGN KEY (`acnumber`) REFERENCES `account` (`acnumber`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
