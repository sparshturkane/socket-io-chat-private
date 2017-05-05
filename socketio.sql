-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 03, 2017 at 03:11 PM
-- Server version: 5.7.18-0ubuntu0.17.04.1
-- PHP Version: 5.6.30-10+deb.sury.org~zesty+2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `socketio`
--

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `chatID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `userFriendID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `videoID` int(11) NOT NULL,
  `messageTypeID` tinyint(1) NOT NULL,
  `chatTypeID` tinyint(1) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`chatID`, `userID`, `userFriendID`, `groupID`, `message`, `videoID`, `messageTypeID`, `chatTypeID`, `updated`, `created`) VALUES
(9, 3823, 3870, 0, 'testing chats', 0, 2, 1, '2017-03-28 20:36:05', '2017-03-29 11:36:05'),
(10, 13, 12, 0, 'hello ', 0, 2, 1, '2017-04-22 12:26:35', '2016-01-03 14:10:05'),
(11, 12, 13, 0, 'it is working ', 0, 2, 1, '2017-04-22 12:26:42', '2016-01-03 14:10:05'),
(12, 13, 12, 0, 'testing ', 0, 2, 1, '2017-04-22 12:49:42', '2016-01-03 14:10:05'),
(13, 13, 12, 0, 'hello', 0, 2, 1, '2017-04-22 13:12:55', '2017-04-22 18:42:55'),
(14, 12, 13, 0, 'test ', 0, 2, 1, '2017-04-22 13:13:37', '2017-04-22 18:43:37'),
(15, 12, 13, 0, 'it is working ', 0, 2, 1, '2017-04-22 13:13:41', '2017-04-22 18:43:41'),
(16, 13, 12, 0, 'hellow ', 0, 2, 1, '2017-04-24 06:00:46', '2017-04-24 11:30:46'),
(17, 12, 13, 0, 'hie ', 0, 2, 1, '2017-04-24 06:00:49', '2017-04-24 11:30:49'),
(18, 13, 12, 0, 'hie ', 0, 2, 1, '2017-04-24 06:01:05', '2017-04-24 11:31:05'),
(19, 14, 13, 0, 'hello', 0, 2, 1, '2017-05-03 09:40:51', '2017-05-03 15:10:51'),
(20, 13, 14, 0, 'i am typing and itworks', 0, 2, 1, '2017-05-03 09:41:03', '2017-05-03 15:11:03');

-- --------------------------------------------------------

--
-- Table structure for table `userProfile`
--

CREATE TABLE `userProfile` (
  `userID` int(11) NOT NULL,
  `fullName` varchar(255) CHARACTER SET utf8 NOT NULL,
  `userName` varchar(255) NOT NULL,
  `occupation` varchar(255) CHARACTER SET utf8 NOT NULL,
  `phoneNo` varchar(20) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profilePic` varchar(255) NOT NULL,
  `country` varchar(100) NOT NULL,
  `dob` date DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `aboutMe` varchar(255) CHARACTER SET utf8 NOT NULL,
  `accessToken` varchar(100) NOT NULL,
  `androidKey` varchar(200) NOT NULL,
  `iosKey` varchar(200) NOT NULL,
  `isActive` tinyint(1) DEFAULT NULL,
  `forgotPassword` varchar(255) NOT NULL,
  `validationLink` varchar(255) NOT NULL,
  `isVerified` tinyint(1) DEFAULT '0',
  `isNotificationInActive` tinyint(1) NOT NULL,
  `isSpecialUser` tinyint(1) NOT NULL,
  `twitterHandler` varchar(255) NOT NULL,
  `newID` int(11) DEFAULT '0',
  `lastLogin` datetime DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userProfile`
--

INSERT INTO `userProfile` (`userID`, `fullName`, `userName`, `occupation`, `phoneNo`, `gender`, `email`, `password`, `profilePic`, `country`, `dob`, `state`, `aboutMe`, `accessToken`, `androidKey`, `iosKey`, `isActive`, `forgotPassword`, `validationLink`, `isVerified`, `isNotificationInActive`, `isSpecialUser`, `twitterHandler`, `newID`, `lastLogin`, `updated`, `created`) VALUES
(1, 'faarbetterfilms', 'faarbetterfilms', '', '', '', '', '', '', '', '0000-00-00', '', '', 'c06f3370d7d81bb2e4548c9a26fb8a1e', '', '', 1, '', '', 0, 0, 0, '', 1, '0000-00-00 00:00:00', '2017-01-04 00:38:10', '0000-00-00 00:00:00'),
(2, 'venkatesh', 'venkat', 'ios developer', '9494230691', 'male', 'venkataele@gmail.com', '$2y$10$1NO8P/QeDwO4IHXtcNZR..la8Nw6Iq6wY4IDYbipmSNfQAL7ges1S', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/6p33r2uSupload_file.jpg', 'India', '2015-02-02', 'Andaman Nicobar', 'I am good hiiiiiiii', '1be6ad972524f7e23431aa91685d62f6', '', '', 1, '', '', 1, 0, 0, '', 2, '2017-01-25 14:59:22', '2017-01-24 22:59:22', '2016-05-26 13:23:22'),
(3, 'Karthik CK ', 'Karthik CK', '', '', 'male', ' karthikck@gmail.com', '', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/n0f1sZDoIMG_20160918_173925.jpg', 'India', '0000-00-00', 'Andaman and Nicobar Islands', '', 'c172be4310cd427cd7e16144fd76a24b', '', '', 1, '', '', 0, 0, 0, '', 3, '2017-01-21 21:32:38', '2017-01-21 05:32:38', '0000-00-00 00:00:00'),
(4, 'Aele Venkatesh ', 'Aele Venkatesh', '', '', '', '', '', '', '', '0000-00-00', '', '', '7408e46b63b2cf8e2111d4362ce3b444', '', '', 1, '', '', 0, 0, 0, '', 4, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(5, 'CHAYAN PUROHIT ', 'CHAYAN PUROHIT', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '3e2340116210a50546955dbdc51085e1', '', '', 1, '', '', 0, 0, 0, '', 5, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(6, 'Dharmesh Pathare ', 'Dharmesh Pathare', '', '', '', '', '', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/XUEpHYjjFB_IMG_1474873042824.jpg', '', '0000-00-00', '', '', '39b7ac4b089e26c3d28e7344242f98a1', '', '', 1, '', '', 0, 0, 0, '', 6, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(7, 'Chayan Purohit ', 'Chayan Purohit', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'ff7c50965b2da45f7b7fe173c24897de', '', '', 1, '', '', 0, 0, 0, '', 7, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(8, 'Genie Anand ', 'Genie Anand', '', '', '', '', '', '', '', '0000-00-00', '', '', 'c6744ffac9ecf9c2437f3b850e6f467e', '', '', 1, '', '', 0, 0, 0, '', 8, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(9, 'GenieMobiles ', 'GenieMobiles', 'iOS', '9494230691', 'male', '', '', '', 'India', '2015-02-01', 'Andaman Nicobar', 'About Me', '275bed78e34d86ba5749b4a753ed71a7', '', '', 1, '', '', 0, 0, 0, '', 9, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(10, 'Venkat Aele', 'Venkat Aele', '', '', '', 'venkataele@gmail.com', '', '', '', '0000-00-00', '', '', '49cb5cc1588f456b87205b2d3bc9ff2a', '', '', 1, '', '', 1, 0, 0, '', 10, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '0000-00-00 00:00:00'),
(11, 'Priya Sharma ', 'Priya Sharma', 'Student', '9058056788', 'female', ' ', '', '', 'India', '1992-06-11', 'Uttar nPradesh', '', 'f58f0595f2e64dcadc5051d169e52444', '', '', 1, '', '', 0, 0, 0, '', 11, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(12, 'Neeraj sharma ', 'neeraj.sharma482', 'student ', '0221564747', '', 'Neeraj.sharma482@yahoo.com', '$2y$10$.p4cxLGqiaCKPCMYPjDxy.Tp6l3xkgIis6a7KORyUPGkMqskmHfOe', '', 'India', '1992-01-29', 'Haryana', 'Cool', '9543c16c929289b19521e9c78756644f', '', '', 1, '', '', 1, 0, 0, '', 12, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:19:01'),
(13, 'akhilchapran', 'akhilchaprana', '11 class', '9211000058', 'male', 'akhilchaprana@gmail.com', '$2y$10$VmkhRrC87yhnCBeRqlMtCefnG.GvnwD7G/UzDm42PwbkBdypC.E.G', '', 'India', '0000-00-00', 'Andaman nNicobar', 'akhil chaprana', '9d3a98099d14ad53eaa0cb4486e59d31', '', '', 1, '', '', 1, 0, 0, '', 13, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:24:33'),
(14, 'arbaaz355 ', 'arbaaz355', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '6104304b6bc9a68d50dd94f5b759361a', '', '', 1, '', '', 0, 0, 0, '', 14, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(15, 'samrabilal', 'samrabilal', 'study ', '3228099688', 'female', 'samrabilal1994@gmail.com', '$2y$10$ZmGh9S/VauPnTnIdGBrGDO4/zOWXDY6xxqm/vthle9ul3.70YExZq', '', 'India', '1994-08-09', 'Andaman nNicobar', 'nice one ', '4d7453d6b5620423ed5a0bfe3a88a37a', '', '', 1, '', '', 1, 0, 0, '', 15, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:40:49'),
(16, 'Nahid Ara Koli ', 'Nahid Ara Koli', '', '', '', '', '', '', '', '0000-00-00', '', '', 'd6b526ca4d51dd57f211727cb581de73', '', '', 1, '', '', 0, 0, 0, '', 16, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(17, 'Anvesha Srivastava', 'anvil1124', 'Application Developer', '9566290364', 'female', 'anvesha.srivastava1102@gmail.com', '$2y$10$fk5g8i53eO7MECWXvsnUG.fyLkss19JBkvxKPqtgMkWtwDDlVi3W.', '', 'India', '0000-00-00', 'Tamil nNadu', 'I am a fan of  Hina Khan', '96e0b423d7d59b6b12ebf8ea42f9210b', '', '', 1, '', '', 1, 0, 0, '', 17, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:48:34'),
(18, 'vicku', 'vicku9', 'student', '7719956364', 'male', 'vicku0190@gmail.com', '$2y$10$tFHTEIhxNfFyjBMjL1EOP.KLUptdf8CrjJu8XrwUTgPmZU5odepMe', '', 'India', '0000-00-00', 'Maharashtra', 'nothing????', '5e72786cf3d0a14ece2738969ab09e12', '', '', 1, '', '', 1, 0, 0, '', 18, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:49:09'),
(19, 'shaw200794 ', 'shaw200794', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '605b0ae700f9445ab839fa76796c7f3b', '', '', 1, '', '', 0, 0, 0, '', 19, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(20, 'Puja Shaw ', 'Puja Shaw', '', '', '  Female', ' ', '', 'https://lh3.googleusercontent.com/-sYMLeYsD0Io/AAAAAAAAAAI/AAAAAAAAACI/1M6Y8lAwZ0s/photo.jpg', 'India', '0000-00-00', 'West Bengal', '', 'efeb0ea8587b72cf0c6329c01803a12d', '', '', 1, '', '', 0, 0, 0, '', 20, '2017-02-14 15:47:29', '2017-02-13 23:47:29', '0000-00-00 00:00:00'),
(21, 'Aditi Mane ', 'Aditi Mane', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '049f682a22e641440bff08bb9bfbdcb4', '', '', 1, '', '', 0, 0, 0, '', 21, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(22, 'Xaina Fayaz', 'Xaina Fayaz', '', '', '', 'xainarasheed@gmail.com', '', '', '', '0000-00-00', '', '', '6badffffbf98b62061238ac8e6f859b5', '', '', 1, '', '', 1, 0, 0, '', 22, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '0000-00-00 00:00:00'),
(23, 'sara', 'sara aasiya', '', '00971507528874', '', 'nilofer_14@rediffmail.com', '$2y$10$BGgZ6PpsUR5FI9RwDT8RYuLR330GR3OF8DM8L.ig0deevdMfeTfia', '', 'India', '1989-01-19', 'Kerala', 'Diehard fan of hina khan1', 'ae974e47ec6d958ab2e2a2433e79f14e', '', '', 1, '', '', 1, 0, 0, '', 23, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 17:56:03'),
(24, 'kabra_jatin ', 'kabra_jatin', '', '', '', '', '', '', '', '0000-00-00', '', '', '672b4ba5ab522696df94246ca74cbb58', '', '', 1, '', '', 0, 0, 0, '', 24, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(25, 'eyesapna ', 'eyesapna', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'a1a0caf37510d1ff2333313158376ca5', '', '', 1, '', '', 0, 0, 0, '', 25, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(26, 'Vishesh Khonda ', 'Vishesh Khonda', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'f324648455cacc7dace1a465e9204881', '', '', 1, '', '', 0, 0, 0, '', 26, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(27, 'Mahwish', 'Solanki', 'Banker', '923214405205', 'female', 'mahwish76@hotmail.com', '$2y$10$RfsfNT0WOMUlFnLdldGdIOKevSeGE8w1FcjaZasFWThlV9MZoR/Eu', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/XKejaGL0IMG_20160606_172553.jpg', 'India', '0000-00-00', 'PUNJAB', 'love Sport ', '5cdd08bf95f02c2f1cdadd381e0593a3', 'euAaVoNzIvA:APA91bExR8axLkct6qfxMqH078Jt0Zga3Rn2YoPi42n6FiKlOz3wki7cJQ6m6CAu1UpT5LKJputcq01uH3IaP_2LVUB-l8Ny2C7r6-7kLJHzc1dn-NdjMEQXZTCm1KClP1eMD8kO4Dhi', '', 1, '', '', 1, 0, 0, '', 27, '2017-01-27 14:02:13', '2017-01-26 22:02:13', '2016-06-10 18:05:51'),
(28, 'Sadia Ruu ', 'Sadia Ruu', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '38b4f2b5dd3c1b6cc36f74859088b433', '', '', 1, '', '', 0, 0, 0, '', 28, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(29, 'brahmbhatt217 ', 'brahmbhatt217', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '11fc7dfb47449a6b06d0ad89d292e324', '', '', 1, '', '', 0, 0, 0, '', 29, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(30, 'Disha Pandya ', 'Disha Pandya', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '6c5feec83b9d0f66d93365f92b057e50', '', '', 1, '', '', 0, 0, 0, '', 30, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(31, '@120Arpit ', '120Arpit', 'Student', '', '', ' ', '', '', 'India', '1995-05-03', 'Karnataka', 'Animation Studying', '4a75336ac2c11524e115b44934c4a0fa', '', '', 1, '', '', 0, 0, 0, '', 31, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(32, 'Farhan', 'Sheikh', 'Farhan', '03108735775', 'male', 'sheikhfarhan@ymail.com', '$2y$10$gRamAE8.N7PizxIEu0q62OQzWLxcbhHLe4BoEsQeY5IXj1ajzNn2a', '', 'India', '0000-00-00', 'Jammu And nKashmir', 'im A Rockstar', '7d19ed15635975f46c281c2bd296f151', '', '', 1, '', '', 1, 0, 0, '', 32, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 18:10:16'),
(33, '_NehaNayak ', '_NehaNayak', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'f8f4c7f95224f8d63f07358d9d294f9d', '', '', 1, '', '', 0, 0, 0, '', 33, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(34, 'Aman Singh ', 'Aman Singh', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '7ec0fd456ec17ef304c455c74b514334', '', '', 1, '', '', 0, 0, 0, '', 34, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(35, 'sakshi gada ', 'sakshi gada', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '0e52c9aa55992e3c88847804ba5cb5ca', '', '', 1, '', '', 0, 0, 0, '', 35, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(36, ' ', '', '', '123', '', 'kavi.kadmiya.kk@gmail.com', '', '', '', '0000-00-00', '', '', '7dd63ea254e22de470d9afe834a4f390', '', '', 1, '', '', 1, 0, 0, '', 36, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '0000-00-00 00:00:00'),
(37, 'Anudeepika Mummasani ', 'Anudeepika Mummasani', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '2532e22914cf37ad3c91719619c16d72', '', '', 1, '', '', 0, 0, 0, '', 37, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(38, 'hanisha', 'hanisha', 'Architect', '9494929059', 'female', 'chintha.hanisha@gmail.com', '$2y$10$B.XmkVlHjXA9TIlcrzwL7utdYmgEqd3VA4ZdxiOBGqsaMKkc9q8oG', '', 'India', '0000-00-00', 'Andaman nNicobar', 'chilling', '7ad68ef12fa670020f8316ed6724383f', '', '', 1, '', '', 1, 0, 0, '', 38, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 18:24:55'),
(39, 'Shubhanshu Shukla ', 'Shubhanshu Shukla', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'c872bb993ee1b12f1d966312d1cc11f5', '', '', 1, '', '', 0, 0, 0, '', 39, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(40, 'girl1_princess ', 'girl1_princess', '', '', '', '', '', '', '', '0000-00-00', '', '', '2c449eb0a9c7f248d34c0eb097c954ef', '', '', 1, '', '', 0, 0, 0, '', 40, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(41, 'hinna', 'hinna. k', 'studying ', '07976463246', 'female', 'hinnakhan17@gmail.com', '$2y$10$fcHVHOzzxX3oe90nfcdMNu8aHytIoX26fBgFIdqHkxvxRaTNF56nG', '', 'India', '0000-00-00', 'Delhi', 'I\'m a student studying health and social care science level 3. I love to do art as a hobby.', '9e6f5de4404bf86758810fb0f64b037b', '', '', 1, '', '', 1, 0, 0, '', 41, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 18:45:50'),
(42, 'Nidhi Saini', 'nidhisaini296', 'www.twitter.com', '', 'female', ' ', '', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/BIyibXoyresult_1465895429794.jpg', 'India', '1997-02-13', 'Rajasthan', 'Student', 'c3ec570f57d6bea7a90de31d3fe275bd', '', '', 1, '', '', 0, 0, 0, '', 42, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(43, 'Faar Better Films', 'Faarbetterfilms', 'business', '9811145895', 'male', 'jayant@faarbetterfilms.com', '$2y$10$UNs2gIIv9AYy9KLsvFKZxuW1qYB9tU6xJ6O9hmdDzHFhs2P1ZUKha', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/2zSyON61profileImg.png', 'india', '2016-01-01', 'Maharastra', 'I am good', '03e1b2695bd1d261750636079aaba17c', '', '', 1, '', '', 1, 0, 0, '', 43, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 00:00:00'),
(44, 'AkshayT54657356 ', 'AkshayT54657356', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'd8343427010134c5e48784adcbed9d74', '', '', 1, '', '', 0, 0, 0, '', 44, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(45, 'Akshay Tak ', 'Akshay Tak', '', '', '', ' ', '', '', '', '0000-00-00', '', '', 'c32690868f4bc50693dc3f9e6304ec84', '', '', 1, '', '', 0, 0, 0, '', 45, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(46, 'Siddharth ', 'sidisingh', 'student', '8097405507', 'male', 'sidisingh73@gmail.com', '$2y$10$o5VuTLop/iShCWiLb0CUT.QJsC6olw25/XWCUaBEUYXXWY755CBBu', 'http://188.166.250.72/rockabyte/admin/uploads/profile_photo/users/boIaSc9cPicsArt_05-19-10.15.08.jpg', 'India', '1991-09-13', 'Maharashtra', 'I\'m journalist', '36a12724e56cee06bad033ed2222608c', '', '', 1, '', '', 1, 0, 0, '', 46, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 19:00:50'),
(47, 'Sasikiran.Bantu', 'sasibantu32', 'Business ', '7204626016', 'male', 'sasi32.kiran@gmail.com', '$2y$10$ECf5xzgbpu8iLa4w9KsIzOWCR3FlM26ngjy3XlCwMjHvyvzqf6U8O', '', 'India', '0000-00-00', 'Andhra nPradesh', 'Work hard, enjoy hard', 'a4ec6011484a7e72cb9ef7d0947291c6', 'e3QTnwEMR5I:APA91bHBNlltebFSwVc0TBVoQUiypNjA1EgxsRT7xLy4c5nPLaTMq848GksPx7kqo8DQw0b4amkikpTxC1-Tav1yJ9n9Y6KGdNYAog6-jAVUbumUsz3nQRSWDHcsyqTxWIYNdGO4BcwF', '', 1, '', '', 1, 0, 0, '', 47, '2017-01-26 17:00:57', '2017-01-26 01:00:57', '2016-06-10 19:04:58'),
(48, 'Nansh kashyap', 'Nansh kashyap', 'Graduate', '7509211747', 'female', 'nanshr564@gmail.com', '$2y$10$DlygkQf5xgTU91Mh0Sem3O9K2l4b2NeDXDp2/P3dUPdqissFIZVJ.', '', 'India', '0000-00-00', 'Madhya nPradesh', 'wtyi', 'bf3de697c1429a0f739458b01d65923b', '', '', 1, '', '', 1, 0, 0, '', 48, '0000-00-00 00:00:00', '2017-01-05 04:58:07', '2016-06-10 19:08:03'),
(49, 'aryakanika2 ', 'aryakanika2', '', '', '', ' ', '', '', '', '0000-00-00', '', '', '8cdb553ba15c7012b1fc2c7777ad4f23', '', '', 1, '', '', 0, 0, 0, '', 49, '0000-00-00 00:00:00', '2017-01-03 05:05:49', '0000-00-00 00:00:00'),
(50, 'Kanika Arya', 'Kanika', 'Dentist', '8171686457', 'female', 'lukinkani@gmail.com', '$2y$10$MmqXpGrrunEQzkPtHytDe.sf/EMmvoB8yAy99sOMqBGQ9oUq6Mpwe', 'http://faarbetterfilms.com/rockabyteServicesV2/uploads/userProfilePicture/c384de833d9d1466df918cc4d1e0eb5f.jpg', 'India', '1991-06-14', 'Uttar nPradesh', 'Fun Loving', 'da94a7fb7ae93bbcbb3e853be700cd3a', 'cfnvmTblI-M:APA91bEw7EaeThpD5ffOubCudhu0pOPLLKoHEWmQpcMQ0Um6FaI3FEufRTHpW7Z1n5wN6hljR30M5mVHiz2y9si2-J1i-c0FwA7-PF0D9V_xM_BHTF-8VH0DoNkZ-6_8VDzbANRdRRLw', '', 1, '', '', 1, 0, 0, '', 50, '2017-02-20 22:11:46', '2017-03-02 08:01:47', '2016-06-10 19:24:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`chatID`);

--
-- Indexes for table `userProfile`
--
ALTER TABLE `userProfile`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `chatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `userProfile`
--
ALTER TABLE `userProfile`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4176;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
