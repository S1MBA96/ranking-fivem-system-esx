-- phpMyAdmin SQL Dump15
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 193.70.94.34:3306
-- Generation Time: Mar 25, 2023 at 05:07 PM
-- Server version: 10.5.18-MariaDB-0+deb11u1
-- PHP Version: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_92759`
--

-- --------------------------------------------------------

--
-- Table structure for table `simba_topleaks_ranks_orgs`
--

CREATE TABLE `simba_topleaks_ranks_orgs` (
  `org` varchar(50) DEFAULT NULL,
  `wins` int(11) DEFAULT 0,
  `orglabel` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `simba_topleaks_ranks_orgs`
--

INSERT INTO `simba_topleaks_ranks_orgs` (`org`, `wins`, `orglabel`) VALUES
('org100', 1, '#100 7.7.7'),
('org120', 3, '#120 HASH'),
('org50', 0, '#witam witam');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
