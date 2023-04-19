-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 193.70.94.34:3306
-- Generation Time: Mar 25, 2023 at 04:39 PM
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
-- Table structure for table `simba_topleaks_ranks`
--

CREATE TABLE `simba_topleaks_ranks` (
  `elo` int(11) DEFAULT 1000,
  `playtime` float DEFAULT 0,
  `kills` int(11) DEFAULT 0,
  `faktury` int(11) DEFAULT 0,
  `napady` int(11) DEFAULT 0,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `simba_topleaks_ranks`
--

INSERT INTO `simba_topleaks_ranks` (`elo`, `playtime`, `kills`, `faktury`, `napady`, `identifier`, `name`) VALUES
(120, 37.58, 34, 0, 2, 'steam:11000013e16a313', 'SIMBA96'),
(440, 11.06, 17, 0, 0, 'steam:11000011b76524a', 'Kacperekღ'),
(1020, 0.62, 5, 0, 0, 'steam:1100001160a7492', 'oL1'),
(480, 10.5, 19, 0, 0, 'steam:11000013b143322', 'pidar12 '),
(980, 2.62, 0, 0, 0, 'steam:11000013fb78100', 'matias');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
