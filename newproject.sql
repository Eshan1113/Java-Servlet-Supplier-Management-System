-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 23, 2024 at 06:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `newproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `old_username` varchar(255) DEFAULT NULL,
  `old_email` varchar(255) DEFAULT NULL,
  `old_mobile` varchar(20) DEFAULT NULL,
  `old_address` text DEFAULT NULL,
  `old_role` varchar(50) DEFAULT NULL,
  `new_username` varchar(255) DEFAULT NULL,
  `new_email` varchar(255) DEFAULT NULL,
  `new_mobile` varchar(20) DEFAULT NULL,
  `new_address` text DEFAULT NULL,
  `new_role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `timestamp`, `user_id`, `action`, `old_username`, `old_email`, `old_mobile`, `old_address`, `old_role`, `new_username`, `new_email`, `new_mobile`, `new_address`, `new_role`) VALUES
(3, '2024-04-13 05:36:03', 20, 'Updated user details for user with ID: 20', 'eshan 1', 'eshandanan@gmail.com', '778519382', '123/2 pansalpathana', 'admin', 'eshan1', 'eshandanan@gmail.com', '778519382', '123/2 pansalpathana', 'admin'),
(4, '2024-04-13 11:08:01', 34, 'Updated user details for user with ID: 34', 'eshan1234', 'dammikahemamali59@gmail.com', '778519383', '123/2 pansalpathana ', 'user', 'eshan1234', 'dammikahemamali59@gmail.com', '778519383', '123/2 pansalpathana ', 'user'),
(5, '2024-04-17 11:38:18', 26, 'Updated user details for user with ID: 26', 'eshan126', 'kamalsudurshanawikrmathun33ga@gmail.com', '778519383', '123/2 pansalpathana', 'user', 'eshan126', 'kamalsudurshanawikrmathun36ga@gmail.com', '778519383', '123/2 pansalpathana', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_description` text DEFAULT NULL,
  `product_added_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `price`, `product_description`, `product_added_date`) VALUES
(1, 'laptop', 1275.50, '1', '2024-04-17');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `ContactPerson` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `DateAdded` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `Name`, `ContactPerson`, `Email`, `Phone`, `Address`, `City`, `State`, `PostalCode`, `Country`, `Notes`, `DateAdded`) VALUES
(1, 'Supplier22', 'John ', 'eshan@gmail.com', '0778519383', '123 Main St', 'Anytown', 'State', '12345', 'indian', 'Example note ', '2024-04-04'),
(2, 'Supplier 2', 'eshan', 'jane@example.com', '456-789-0123', '456 Oak St', 'Othertown', 'State', '67890', 'Country', 'Example note 2', '2024-04-04'),
(3, 'Supplier 3', 'Alice Johnson', 'alice@example.com', '789-012-3456', '789 Elm St', 'Anothertown', 'State', '23456', 'Country', 'Example note ', '2024-04-04'),
(4, 'Supplier 4', 'Bob Williams', 'bob@example.com', '012-345-6789', '101 Maple St', 'Sometown', 'State', '34567', 'Country', 'Example note 4', '2024-04-04'),
(5, 'Supplier 5', 'Eva Brown', 'eva@example.com', '234-567-8901', '202 Pine St', 'Anytown', 'State', '45678', 'Country', 'Example note 5', '2024-04-04'),
(6, 'Supplier 6', 'Michael Lee', 'michael@example.com', '567-890-1234', '303 Cedar St', 'Othertown', 'State', '56789', 'Country', 'Example note ', '2024-04-04'),
(7, 'Supplier 7', 'Sarah Clark', 'sarah@example.com', '890-123-4567', '404 Birch St', 'Anothertown', 'State', '67890', 'Country', 'Example note 7', '2024-04-04'),
(8, 'Supplier 8', 'David Martinez', 'david@example.com', '012-345-6789', '505 Walnut St', 'Sometown', 'State', '78901', 'Country', 'Example note 8', '2024-04-04'),
(9, 'Supplier 9', 'Emily Taylor', 'emily@example.com', '345-678-9012', '606 Elm St', 'Anytown', 'State', '89012', 'Country', 'Example note 9', '2024-04-04'),
(10, 'Supplier 10', 'Daniel Anderson', 'daniel@example.com', '678-901-2345', '707 Oak Si', 'Othertown', 'State', '90123', 'Country', 'Example note 10', '2024-04-04');

-- --------------------------------------------------------

--
-- Table structure for table `userdetials`
--

CREATE TABLE `userdetials` (
  `id` int(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `mobile` int(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userdetials`
--

INSERT INTO `userdetials` (`id`, `username`, `email`, `address`, `mobile`, `password`, `role`) VALUES
(20, 'eshan 1', 'eshandanan@gmail.com', '123/2 pansalpathana', 778519383, '1234', 'admin'),
(26, 'eshan126', 'kamalsudurshanawikrmathun36ga@gmail.com', '123/2 pansalpathana', 778519383, '1234', 'user'),
(27, 'eshan1234', 'dammikahemamali59@gmail.com', '123/2 pansalpathana', 778519383, '123456', 'user'),
(28, 'eshan12345', 'dammikahemamali4@gmail.com', '123/2 pansalpathana', 778519348, '12345', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Indexes for table `userdetials`
--
ALTER TABLE `userdetials`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `userdetials`
--
ALTER TABLE `userdetials`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
