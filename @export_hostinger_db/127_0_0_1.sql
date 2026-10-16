-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2026 at 10:41 PM
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
-- Database: `blood_pressure_3.0`
--
CREATE DATABASE IF NOT EXISTS `blood_pressure_3.0` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blood_pressure_3.0`;

-- --------------------------------------------------------

--
-- Table structure for table `medication_schedules`
--

CREATE TABLE `medication_schedules` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `medication` varchar(255) NOT NULL,
  `daily_dosage` varchar(255) DEFAULT NULL,
  `morning_dosage` varchar(255) DEFAULT NULL,
  `midday_dosage` varchar(255) DEFAULT NULL,
  `night_dosage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medication_schedules`
--

INSERT INTO `medication_schedules` (`id`, `user_id`, `medication`, `daily_dosage`, `morning_dosage`, `midday_dosage`, `night_dosage`) VALUES
(1, 1, 'lamotrigine', '500 mg', '250', '', '250'),
(2, 1, 'lamotrigine', '500 mg', '250', '', '250'),
(3, 1, 'lamotrigine', '500 mg', '250', '250', '0'),
(4, 1, 'lamotrigine', '500', '250', '', '250'),
(5, 1, 'linisopril', '100', '100', '100', '100'),
(6, 1, 'lamotrigine', '500 mg', '250', '', '250');

-- --------------------------------------------------------

--
-- Table structure for table `readings`
--

CREATE TABLE `readings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `systolic` int(11) NOT NULL,
  `diastolic` int(11) NOT NULL,
  `pulse` int(11) NOT NULL,
  `medication` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `record_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `readings`
--

INSERT INTO `readings` (`id`, `user_id`, `systolic`, `diastolic`, `pulse`, `medication`, `notes`, `record_date`, `created_at`) VALUES
(1, 5, 100, 100, 65, '', '', '2025-08-05', '2025-08-05 11:08:42'),
(2, 5, 100, 100, 65, '', '', '2025-08-05', '2025-08-05 11:08:52'),
(3, 5, 100, 100, 65, 'medication', 'note 1', '2025-08-01', '2025-08-05 11:33:58'),
(4, 1, 100, 100, 65, 'linisopril', '', '2025-08-05', '2025-08-05 12:53:38'),
(5, 1, 100, 100, 65, 'lamotrigine', '', '2025-08-05', '2025-08-05 12:54:11'),
(6, 1, 100, 100, 65, '', 'note', '2025-08-07', '2025-08-07 11:16:01'),
(7, 1, 100, 100, 65, '', 'notes without medication', '2025-08-07', '2025-08-07 11:47:34'),
(8, 1, 100, 100, 65, NULL, 'notes with chart at the end', '2025-08-07', '2025-08-07 11:57:36'),
(9, 1, 100, 100, 65, NULL, 'notes with chart at the end', '2025-08-07', '2025-08-07 11:58:28'),
(10, 1, 100, 150, 65, 'lamotrigine', '', '2025-08-07', '2025-08-07 13:10:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `bio` text DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `twitter_link` varchar(255) DEFAULT NULL,
  `facebook_link` varchar(255) DEFAULT NULL,
  `instagram_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `verification_token`, `is_verified`, `bio`, `profile_picture`, `twitter_link`, `facebook_link`, `instagram_link`, `created_at`) VALUES
(1, 'dani', '$2y$10$U5Xx6S/P5/BwieTQc/YIXunnCIfYiBzhsY7qZwZ31sLtsTtRSR6mq', 'footroot@mytaller.info', NULL, 1, 'new bio', 'uploads/profile_pictures/5_1754392548.jpg', '', '', '', '2025-08-05 11:07:55'),
(6, 'dani3', '$2y$10$k8yvZ.tWJaIwcKrsnx7ZKuB9lRcVbP0/d7BY94YBFv/sDBwiW2G02', 'footroot.72@gmail.com', NULL, 1, '', 'uploads/profile_pictures/6_1754393043.jpg', '', '', '', '2025-08-05 11:23:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `readings`
--
ALTER TABLE `readings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `readings`
--
ALTER TABLE `readings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  ADD CONSTRAINT `medication_schedules_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `blood_pressure_3.1`
--
CREATE DATABASE IF NOT EXISTS `blood_pressure_3.1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blood_pressure_3.1`;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `creator_id`, `created_at`) VALUES
(4, '1', 1, '2025-08-09 16:10:02'),
(5, '1', 1, '2025-08-09 16:11:29'),
(6, 'first group', 23, '2025-08-12 16:54:27');

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`group_id`, `user_id`) VALUES
(4, 1),
(5, 1),
(6, 23);

-- --------------------------------------------------------

--
-- Table structure for table `medication_schedules`
--

CREATE TABLE `medication_schedules` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `medication_name` varchar(255) NOT NULL,
  `daily_dosage` varchar(255) DEFAULT NULL,
  `morning_dosage` varchar(255) DEFAULT NULL,
  `midday_dosage` varchar(255) DEFAULT NULL,
  `night_dosage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medication_schedules`
--

INSERT INTO `medication_schedules` (`id`, `user_id`, `medication_name`, `daily_dosage`, `morning_dosage`, `midday_dosage`, `night_dosage`) VALUES
(1, 1, 'lamotrigine', '500 mg', '250', '', '250'),
(6, 23, 'lamotrigine', '500 mg', '250', '0', '250');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `group_id`, `user_id`, `message_text`, `created_at`) VALUES
(1, 4, 1, 'hello', '2025-08-09 16:22:06'),
(2, 4, 1, 'hello', '2025-08-09 16:26:00'),
(3, 4, 1, 'hello', '2025-08-09 16:33:39'),
(4, 5, 1, 'hello', '2025-08-09 16:35:25'),
(5, 5, 1, 'hello', '2025-08-09 16:39:14'),
(6, 4, 1, 'hello', '2025-08-09 16:51:15'),
(7, 4, 1, 'hello', '2025-08-11 16:03:10'),
(8, 4, 1, 'hello', '2025-08-11 16:03:12'),
(9, 4, 1, 'hello', '2025-08-12 11:51:54'),
(10, 6, 23, 'hello', '2025-08-12 16:54:39'),
(11, 6, 23, 'he you', '2025-08-12 16:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `readings`
--

CREATE TABLE `readings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `systolic` int(11) NOT NULL,
  `diastolic` int(11) NOT NULL,
  `pulse` int(11) NOT NULL,
  `medication` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `record_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `readings`
--

INSERT INTO `readings` (`id`, `user_id`, `systolic`, `diastolic`, `pulse`, `medication`, `notes`, `record_date`, `created_at`) VALUES
(1, 1, 100, 100, 65, 'lamotrigine', 'notes', '2025-08-08', '2025-08-08 17:30:10'),
(2, 1, 110, 120, 75, 'medication', 'note 2', '2025-08-08', '2025-08-08 21:26:46'),
(3, 1, 120, 110, 85, 'medico', 'note 4', '2025-08-09', '2025-08-08 21:27:33'),
(8, 1, 100, 110, 90, NULL, '', '2025-09-09', '2025-08-09 00:56:48'),
(12, 23, 110, 100, 65, NULL, 'note 1', '2025-08-12', '2025-08-12 16:49:43'),
(13, 23, 150, 120, 90, NULL, 'note 2', '2025-08-12', '2025-08-12 16:50:10'),
(14, 23, 120, 110, 80, NULL, 'note 3 inserted data past', '2025-08-05', '2025-08-12 16:51:03');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reminder_type` varchar(50) NOT NULL,
  `reminder_text` text NOT NULL,
  `reminder_time` time NOT NULL,
  `recurrence_days` varchar(20) DEFAULT 'daily',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reminders`
--

INSERT INTO `reminders` (`id`, `user_id`, `reminder_type`, `reminder_text`, `reminder_time`, `recurrence_days`, `created_at`) VALUES
(3, 1, 'medication', 'take medication', '10:00:00', 'custom', '2025-08-09 15:58:21'),
(4, 1, 'medication', 'blood presure', '17:00:00', 'daily', '2025-08-09 15:59:16'),
(5, 1, 'medication', 'blood presure', '17:00:00', 'daily', '2025-08-09 16:01:59'),
(6, 1, 'medication', 'blood presure', '17:00:00', 'daily', '2025-08-09 16:08:58'),
(8, 23, 'reading', 'blood presure', '17:54:00', 'daily', '2025-08-12 16:53:10');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verification_token` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `twitter_link` varchar(255) DEFAULT NULL,
  `facebook_link` varchar(255) DEFAULT NULL,
  `instagram_link` varchar(255) DEFAULT NULL,
  `linkedin_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `is_verified`, `verification_token`, `bio`, `profile_picture`, `twitter_link`, `facebook_link`, `instagram_link`, `linkedin_link`, `created_at`) VALUES
(1, 'dani', 'footroot.72@gmail.com', '$2y$10$cF7/bI21BkQ3M63mku3W7urkXeqyeYs1MBpwm3peVcQHjnHmZSq0m', 1, '1847a7e86db67b50d4d719abed4f9b4a', '', '68966dee5566c_robot.jpeg', '', '', '', '', '2025-08-08 17:23:37'),
(23, 'dani2', 'footroot@mytaller.info', '$2y$10$rnY8KWCwtkYI6Dg0e9ReTu48XjKy3RSGSiZyiHJlpQx1bAIIyJHSC', 1, '0f56b59066cae63748240102f1ca449847a7ad533535e5c61b837c83fa8fc158', '', '689b705990f45_logoweb.jpg', '', '', '', '', '2025-08-12 16:41:50'),
(24, 'admin@example.com', 'Daniostes@hotmail.com', '$2y$10$Hn6NpvZ4RrAtgRGjgj8V/.9IWzoX06KPPRY1wDmRY8Yh95lM5LLLO', 0, '0e9a79c179be57fb1f15288e0afb50bc8e801d17cb49ba5b373f2a1838590eb3', NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-22 10:54:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`group_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `readings`
--
ALTER TABLE `readings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `readings`
--
ALTER TABLE `readings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  ADD CONSTRAINT `medication_schedules_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `readings`
--
ALTER TABLE `readings`
  ADD CONSTRAINT `readings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `blood_pressure_db`
--
CREATE DATABASE IF NOT EXISTS `blood_pressure_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blood_pressure_db`;

-- --------------------------------------------------------

--
-- Table structure for table `readings`
--

CREATE TABLE `readings` (
  `id` int(11) NOT NULL,
  `systolic` int(11) NOT NULL,
  `diastolic` int(11) NOT NULL,
  `pulse` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `reading_date` date NOT NULL,
  `reading_time` time NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `readings`
--

INSERT INTO `readings` (`id`, `systolic`, `diastolic`, `pulse`, `notes`, `reading_date`, `reading_time`, `timestamp`) VALUES
(6, 100, 100, 100, '111', '2025-05-27', '02:17:00', '2025-05-27 02:17:50'),
(7, 100, 100, 100, '1', '2025-05-28', '00:57:00', '2025-05-29 00:58:13'),
(8, 100, 100, 100, '1000', '2025-05-29', '01:03:00', '2025-05-29 01:04:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `readings`
--
ALTER TABLE `readings`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `readings`
--
ALTER TABLE `readings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Database: `blood_pressure_tracker`
--
CREATE DATABASE IF NOT EXISTS `blood_pressure_tracker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blood_pressure_tracker`;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_readings`
--

CREATE TABLE `blood_pressure_readings` (
  `id` int(11) NOT NULL,
  `systolic` int(11) NOT NULL,
  `diastolic` int(11) NOT NULL,
  `pulse` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood_pressure_readings`
--

INSERT INTO `blood_pressure_readings` (`id`, `systolic`, `diastolic`, `pulse`, `timestamp`, `notes`) VALUES
(1, 170, 94, 50, '2025-05-10 12:57:44', 'primera '),
(2, 120, 95, 1, '2025-05-24 17:49:30', '111'),
(18, 1, 1, 1, '2025-05-19 17:50:40', '1'),
(19, 1, 1, 1, '2025-05-19 18:20:03', 'monday'),
(20, 1, 1, 2, '2025-05-19 18:26:31', 'monday'),
(21, 10, 20, 50, '2025-05-19 18:37:45', 'new'),
(22, 12, 12, 50, '2025-05-19 21:50:21', 'testing again'),
(23, 10, 10, 10, '2025-05-19 21:57:47', 'test 2'),
(24, 150, 65, 65, '2025-05-19 23:53:39', 'test 3'),
(25, 160, 80, 65, '2025-05-19 23:54:52', 'test 3'),
(26, 150, 80, 75, '2025-05-20 01:51:48', 'test with the calendar'),
(27, 90, 120, 70, '2025-05-20 02:23:09', 'test 5 calendar');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'a2', '', '$2y$10$VDdwbVNmh96oARHg0NHZZeodqyWr00D4oaoxLUzb5/BDCDNQnQAHi', '2025-05-25 02:02:36'),
(5, 'dani2', 'a@a.b', '$2y$10$CfxCrPUvw44i6cptiVDKCeButAFL2HhkSzVA0icU/f0P7ejKWmBRy', '2025-05-25 12:11:59'),
(6, 'dani3', 'a@a.c', '$2y$10$UF4Tqx7MV234.k1Aws2tquFC5V9ZIjKyH0sSTzglHrJwe9R35kOnG', '2025-05-25 12:17:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blood_pressure_readings`
--
ALTER TABLE `blood_pressure_readings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blood_pressure_readings`
--
ALTER TABLE `blood_pressure_readings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Database: `blood_pressure_tracker-hostinger`
--
CREATE DATABASE IF NOT EXISTS `blood_pressure_tracker-hostinger` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blood_pressure_tracker-hostinger`;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_readings`
--

CREATE TABLE `blood_pressure_readings` (
  `id` int(11) NOT NULL,
  `systolic` int(11) NOT NULL,
  `diastolic` int(11) NOT NULL,
  `pulse` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood_pressure_readings`
--

INSERT INTO `blood_pressure_readings` (`id`, `systolic`, `diastolic`, `pulse`, `timestamp`, `notes`) VALUES
(1, 170, 94, 50, '2025-05-10 12:57:44', 'primera '),
(2, 120, 95, 1, '2025-05-24 17:49:30', '111'),
(18, 1, 1, 1, '2025-05-19 17:50:40', '1'),
(19, 1, 1, 1, '2025-05-19 18:20:03', 'monday'),
(20, 1, 1, 2, '2025-05-19 18:26:31', 'monday'),
(21, 10, 20, 50, '2025-05-19 18:37:45', 'new'),
(22, 12, 12, 50, '2025-05-19 21:50:21', 'testing again'),
(23, 10, 10, 10, '2025-05-19 21:57:47', 'test 2'),
(24, 150, 65, 65, '2025-05-19 23:53:39', 'test 3'),
(25, 160, 80, 65, '2025-05-19 23:54:52', 'test 3'),
(26, 150, 80, 75, '2025-05-20 01:51:48', 'test with the calendar'),
(27, 90, 120, 70, '2025-05-20 02:23:09', 'test 5 calendar');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'a2', '', '$2y$10$VDdwbVNmh96oARHg0NHZZeodqyWr00D4oaoxLUzb5/BDCDNQnQAHi', '2025-05-25 02:02:36'),
(5, 'dani2', 'a@a.b', '$2y$10$CfxCrPUvw44i6cptiVDKCeButAFL2HhkSzVA0icU/f0P7ejKWmBRy', '2025-05-25 12:11:59'),
(6, 'dani3', 'a@a.c', '$2y$10$UF4Tqx7MV234.k1Aws2tquFC5V9ZIjKyH0sSTzglHrJwe9R35kOnG', '2025-05-25 12:17:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blood_pressure_readings`
--
ALTER TABLE `blood_pressure_readings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blood_pressure_readings`
--
ALTER TABLE `blood_pressure_readings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Database: `dani`
--
CREATE DATABASE IF NOT EXISTS `dani` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dani`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `email` text NOT NULL,
  `contact_number` varchar(32) NOT NULL,
  `access_level` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `dob` date DEFAULT NULL,
  `image` varchar(256) DEFAULT NULL,
  `access_code` varchar(200) NOT NULL,
  `status` varchar(100) NOT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_validator_hash` varchar(255) DEFAULT NULL,
  `remember_expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `contact_number`, `access_level`, `created`, `password`, `address`, `dob`, `image`, `access_code`, `status`, `remember_selector`, `remember_validator_hash`, `remember_expires_at`) VALUES
(1, 'Daniel', 'Perez', 'footroot@mytaller.info', '00447506994559', 1, '0000-00-00 00:00:00', '$2y$10$zPnjgVYCdlon7/eJAHLLrO.QRRfgMs/Wa0FNl4tt2/CUIP8mOpBO2', '19C\r\nwaverley Road', '1972-09-13', '09d41f17c00c219950c242b444e0b0bd02222f9b.jpg', '', '0', NULL, NULL, NULL),
(37, 'Daniel', 'Perez', 'footroot.72@gmail.com', '', 1, '2025-08-22 19:41:02', '$2y$10$YwB72rxW/rhVJ5pgHKJEQ.HHUMgq.0YXW2s7K2q8tSxJ7RYC2OXva', '', '2000-10-10', 'fc5d5058a082aeafcf92cb7f6124962b8ea81945.png', '', '0', NULL, NULL, NULL),
(51, 'Daniel', 'Perez', 'Daniostes@hotmail.com', '', 0, '2025-08-26 20:41:06', '$2y$10$S.uS7rG1pjJQk8rPIOueoOBTSnC8yiY9MyrkaznCNMZzIkDdvpCPq', '', '2000-10-10', NULL, 'd38ae4c06ad880d91c0415b1aa016318', '0', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
--
-- Database: `expat_girl_friday`
--
CREATE DATABASE IF NOT EXISTS `expat_girl_friday` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `expat_girl_friday`;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `client_name` varchar(100) NOT NULL,
  `client_email` varchar(255) NOT NULL,
  `client_message` text NOT NULL,
  `subscribed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `service_key` varchar(50) NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `icon` varchar(20) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `service_key`, `class_name`, `icon`, `title`, `description`) VALUES
(1, 'interpreting', '', 'GB 💬ES', 'English ↔ Spanish Interpreting', 'Take the stress out of appointments and official business.'),
(2, 'van', 'blue', '🚐', 'Large Van & Collection Service', 'Got something that won\'t fit in the car?'),
(3, 'airport', 'green', '✈️', 'Airport Transfers', 'Take the hassle out of getting to or from the airport.'),
(4, 'parking', 'purple', '🅿️', 'Secure Private Parking', 'Need somewhere safe to leave your car while you\'re away?');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Database: `my_travel_planner`
--
CREATE DATABASE IF NOT EXISTS `my_travel_planner` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `my_travel_planner`;

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_07_105625_create_trips_table', 1),
(5, '2025_09_07_105808_create_cities_table', 1),
(6, '2025_09_07_105836_create_activities_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('KT8huh4VYTnEtTbnBlsLpczLcMj76Bi6oUVB5ozb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUlwRlFBc2h5VWV3RDlLT0h4M3JkRnNrZ3ZlNVJuQ3JwdGNtMHFNcyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC90cmlwcy9jcmVhdGUiO319', 1757255337);

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Dumping data for table `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"snap_to_grid\":\"off\",\"relation_lines\":\"true\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"expat_girl_friday\",\"table\":\"messages\"},{\"db\":\"expat_girl_friday\",\"table\":\"services\"},{\"db\":\"travel_planner\",\"table\":\"trips\"},{\"db\":\"travel_planner\",\"table\":\"cities\"},{\"db\":\"my_travel_planner\",\"table\":\"users\"},{\"db\":\"my_travel_planner\",\"table\":\"trips\"},{\"db\":\"my_travel_planner\",\"table\":\"sessions\"},{\"db\":\"my_travel_planner\",\"table\":\"migrations\"},{\"db\":\"my_travel_planner\",\"table\":\"job_batches\"},{\"db\":\"my_travel_planner\",\"table\":\"jobs\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'blood_pressure_3.0', 'medication_schedules', '[]', '2025-08-07 11:14:50'),
('root', 'blood_pressure_tracker', 'users', '{\"sorted_col\":\"`users`.`email` ASC\"}', '2025-05-25 11:36:58');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-09-22 20:38:53', '{\"Console\\/Mode\":\"show\",\"lang\":\"en_GB\",\"NavigationWidth\":0}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `travel_planner`
--
CREATE DATABASE IF NOT EXISTS `travel_planner` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `travel_planner`;

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `arrival_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `name`, `start_date`, `end_date`) VALUES
(4, 'Singapore', '2025-10-29', '2025-11-30');

-- --------------------------------------------------------

--
-- Table structure for table `trip_details`
--

CREATE TABLE `trip_details` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `city_name` varchar(255) NOT NULL,
  `visit_datetime` datetime NOT NULL,
  `todo_list` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trip_details`
--
ALTER TABLE `trip_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trip_details`
--
ALTER TABLE `trip_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trip_details`
--
ALTER TABLE `trip_details`
  ADD CONSTRAINT `trip_details_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
