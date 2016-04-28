-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.21 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-08-29 21:43:44
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for neighbours
DROP DATABASE IF EXISTS `neighbours`;
CREATE DATABASE IF NOT EXISTS `neighbours` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `neighbours`;


-- Dumping structure for table neighbours.event
DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(10) NOT NULL,
  `topic` varchar(100) NOT NULL,
  `eventDescription` varchar(400) NOT NULL,
  `date` varchar(50) NOT NULL,
  `creator` varchar(100) NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_users` (`creator`),
  CONSTRAINT `FK_event_users` FOREIGN KEY (`creator`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.event: ~4 rows (approximately)
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
REPLACE INTO `event` (`event_id`, `topic`, `eventDescription`, `date`, `creator`, `time`) VALUES
	(1, 'Hello World', 'a;lks;laks;alks;lka;lsk', '2012/03/31', 'neville', '08:00'),
	(2, 'asasasasa', 'saasasasasasasasasas', '2012/06/21', 'ankurgupta85', '08:00'),
	(3, 'slkajslkjlsakjl', 'kajslkajslkajslkajs', '2012/06/12', 'ankurgupta85', '08:00'),
	(4, 'kajshdkjsdhksjhdkjh', 'kajhskajhskjahskjahkjsha', '2012/07/24', 'ankurgupta85', '08:00');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;


-- Dumping structure for table neighbours.event_users
DROP TABLE IF EXISTS `event_users`;
CREATE TABLE IF NOT EXISTS `event_users` (
  `event_id` int(10) NOT NULL,
  `user` varchar(100) NOT NULL,
  PRIMARY KEY (`event_id`,`user`),
  KEY `FK__users1` (`user`),
  CONSTRAINT `FK__event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `FK__users1` FOREIGN KEY (`user`) REFERENCES `users` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.event_users: ~12 rows (approximately)
/*!40000 ALTER TABLE `event_users` DISABLE KEYS */;
REPLACE INTO `event_users` (`event_id`, `user`) VALUES
	(2, 'ankurgupta85'),
	(3, 'ankurgupta85'),
	(4, 'ankurgupta85'),
	(1, 'neville'),
	(4, 'neville'),
	(3, 'pragya'),
	(4, 'pragya'),
	(1, 'praveena'),
	(2, 'praveena'),
	(3, 'praveena'),
	(4, 'praveena'),
	(3, 'vinay');
/*!40000 ALTER TABLE `event_users` ENABLE KEYS */;


-- Dumping structure for table neighbours.invitesent
DROP TABLE IF EXISTS `invitesent`;
CREATE TABLE IF NOT EXISTS `invitesent` (
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.invitesent: ~1 rows (approximately)
/*!40000 ALTER TABLE `invitesent` DISABLE KEYS */;
REPLACE INTO `invitesent` (`email`) VALUES
	('agupta85@yahoo.com');
/*!40000 ALTER TABLE `invitesent` ENABLE KEYS */;


-- Dumping structure for table neighbours.likes_unlikes
DROP TABLE IF EXISTS `likes_unlikes`;
CREATE TABLE IF NOT EXISTS `likes_unlikes` (
  `username` varchar(100) NOT NULL,
  `post_id` int(10) NOT NULL,
  `like_unlike` varchar(50) NOT NULL,
  PRIMARY KEY (`username`,`post_id`),
  KEY `FK_likes_unlikes_updates` (`post_id`),
  CONSTRAINT `FK_likes_unlikes_updates` FOREIGN KEY (`post_id`) REFERENCES `updates` (`post_id`),
  CONSTRAINT `FK_likes_unlikes_users` FOREIGN KEY (`username`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.likes_unlikes: ~0 rows (approximately)
/*!40000 ALTER TABLE `likes_unlikes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes_unlikes` ENABLE KEYS */;


-- Dumping structure for table neighbours.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` int(10) NOT NULL,
  `message` varchar(200) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `receiver` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date_time` varchar(50) NOT NULL,
  `messageTopic` varchar(50) NOT NULL,
  `prev_message_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  KEY `FK_messages_users` (`sender`),
  KEY `FK_messages_users_2` (`receiver`),
  KEY `FK_messages_messages` (`prev_message_id`),
  CONSTRAINT `FK_messages_users` FOREIGN KEY (`sender`) REFERENCES `users` (`Username`),
  CONSTRAINT `FK_messages_users_2` FOREIGN KEY (`receiver`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.messages: ~6 rows (approximately)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
REPLACE INTO `messages` (`message_id`, `message`, `sender`, `receiver`, `status`, `date_time`, `messageTopic`, `prev_message_id`) VALUES
	(1, 'Hello NEville kya haal hai ... ', 'ankurgupta85', 'neville', 'UNREAD', '04-10-2012 00:23:11', 'Hi', 0),
	(2, 'Hello Mr. Neville', 'ankurgupta85', 'neville', 'READ', '04-10-2012 00:23:34', 'Hello Sir', 0),
	(3, 'bas yaar sab badhiya.... tum sunao ', 'neville', 'ankurgupta85', 'READ', '04-10-2012 00:24:10', 'Hi', 1),
	(4, 'tumhara kya chal raha hai ??? ', 'neville', 'ankurgupta85', 'READ', '04-10-2012 00:24:19', 'Hi', 1),
	(5, 'bas yaar tum sunao', 'ankurgupta85', 'neville', 'UNREAD', '04-10-2012 00:35:05', 'Hi', 1),
	(6, 'aur bhai ankiur', 'shriram', 'ankurgupta85', 'READ', '04-15-2012 01:13:12', 'Hello Boss', 0);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


-- Dumping structure for table neighbours.neighbours
DROP TABLE IF EXISTS `neighbours`;
CREATE TABLE IF NOT EXISTS `neighbours` (
  `username1` varchar(100) NOT NULL DEFAULT '',
  `username2` varchar(100) NOT NULL DEFAULT '',
  `Status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`username1`,`username2`),
  KEY `FK__users_2` (`username2`),
  CONSTRAINT `FK__users` FOREIGN KEY (`username1`) REFERENCES `users` (`Username`),
  CONSTRAINT `FK__users_2` FOREIGN KEY (`username2`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.neighbours: ~15 rows (approximately)
/*!40000 ALTER TABLE `neighbours` DISABLE KEYS */;
REPLACE INTO `neighbours` (`username1`, `username2`, `Status`) VALUES
	('abc', 'neville', 'NEIGHBOURS'),
	('abc', 'praveena', 'NEIGHBOURS'),
	('ankurgupta85', 'hrishi', 'NEIGHBOURS'),
	('ankurgupta85', 'neville', 'NEIGHBOURS'),
	('ankurgupta85', 'pragya', 'NEIGHBOURS'),
	('ankurgupta85', 'praveena', 'NEIGHBOURS'),
	('ankurgupta85', 'vinay', 'NEIGHBOURS'),
	('neville', 'hrishi', 'REQUEST_FOR_NEIGHBOURS'),
	('neville', 'praveena', 'NEIGHBOURS'),
	('pragya', 'praveena', 'REQUEST_FOR_NEIGHBOURS'),
	('praveena', 'vinay', 'NEIGHBOURS'),
	('vinay', 'abc', 'REQUEST_FOR_NEIGHBOURS'),
	('vinay', 'abcdef', 'REQUEST_FOR_NEIGHBOURS'),
	('vinay', 'hrishi', 'NEIGHBOURS'),
	('vinay', 'pragya', 'NEIGHBOURS');
/*!40000 ALTER TABLE `neighbours` ENABLE KEYS */;


-- Dumping structure for table neighbours.updates
DROP TABLE IF EXISTS `updates`;
CREATE TABLE IF NOT EXISTS `updates` (
  `post_id` int(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `post` varchar(150) NOT NULL,
  `date_time` varchar(50) NOT NULL,
  `parent_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `FK_updates_users` (`username`),
  CONSTRAINT `FK_updates_users` FOREIGN KEY (`username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.updates: ~22 rows (approximately)
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
REPLACE INTO `updates` (`post_id`, `username`, `post`, `date_time`, `parent_id`) VALUES
	(1, 'ankurgupta85', 'This is cool app ', '05-13-2012 23:28:13', 0),
	(2, 'ankurgupta85', 'Hello ', '05-21-2012 01:48:44', 1),
	(3, 'praveena', 'Hello Ankur\r\n', '05-21-2012 01:49:09', 1),
	(5, 'ankurgupta85', 'Hello World\r\n', '05-27-2012 18:25:21', 0),
	(6, 'ankurgupta85', 'I am back\r\n', '05-27-2012 18:25:35', 0),
	(7, 'ankurgupta85', 'Wasssup', '06-09-2012 15:25:50', 0),
	(8, 'vinay', 'I am in for neighbourhood ppl ', '06-19-2012 17:55:20', 0),
	(9, 'vinay', '<a href=otheruser.jsp?username=pragya style=text-decoration: none;>Pragya Jain</a> is now my neighbour', '07-05-2012 23:15:37', 0),
	(10, 'vinay', '<a href=otheruser.jsp?username=hrishi>Hrishikesh Deshmukh</a> is now my neighbour', '07-18-2012 20:39:37', 0),
	(11, 'vinay', 'Great... Makemore neighbours :)', '07-28-2012 18:12:02', 9),
	(12, 'vinay', 'Hello All', '07-28-2012 18:13:32', 0),
	(13, 'ankurgupta85', 'Hello Vinay\r\n', '07-28-2012 19:47:13', 12),
	(14, 'ankurgupta85', 'Awesome... ', '07-28-2012 19:47:59', 10),
	(15, 'ankurgupta85', 'I like this app', '07-28-2012 19:48:28', 10),
	(16, 'ankurgupta85', 'Hi', '07-28-2012 19:49:01', 12),
	(17, 'ankurgupta85', 'aksjlkaj', '07-28-2012 19:49:07', 12),
	(18, 'ankurgupta85', 'skajskjaskajskajskajskas', '07-28-2012 19:49:33', 9),
	(19, 'ankurgupta85', 'laskjlksjalksjalksj', '07-28-2012 20:00:42', 12),
	(20, 'vinay', 'lskjdlksjdlksjdlksjds', '07-28-2012 20:38:30', 8),
	(21, 'hrishi', 'jgcgjucxjuc', '08-27-2012 22:44:49', 12),
	(22, 'hrishi', 'jgcgjucxjuc', '08-27-2012 22:44:49', 12),
	(23, 'hrishi', 'jgcgjucxjuc', '08-27-2012 22:45:13', 12);
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;


-- Dumping structure for table neighbours.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `ZipCode` varchar(50) NOT NULL,
  `ProfilePic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Username`),
  KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table neighbours.users: ~9 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`First_Name`, `Last_Name`, `Username`, `Password`, `Email`, `ZipCode`, `ProfilePic`) VALUES
	('ABC', 'ABC', 'abc', 'abc', 'abc@gmail.com', '94086', NULL),
	('Ankur', 'Sharma', 'abcdef', 'abcdef@gmail.com', 'abcdef', '94090', 'null'),
	('Ankur', 'Gupta', 'ankurgupta85', 'ankur', 'ankurgupta85@gmail.com', '94086', 'down_time.gif'),
	('Hrishikesh', 'Deshmukh', 'hrishi', 'hrishi', 'hrishi@abc.com', '94090', NULL),
	('Neville', 'Neville', 'neville', 'neville', 'shri_ram_s@yahoo.co.in', '94086', NULL),
	('Pragya', 'Jain', 'pragya', 'pragya', 'prag@ya.com', '94087', NULL),
	('Praveena', 'Kuppa', 'praveena', 'praveena', 'praveena@kuppa.com', '94087', NULL),
	('Shriram', 'Shankar', 'shriram', 'shriram', 'shriram@gmail.com', '94085', NULL),
	('Vinay', 'Jain', 'vinay', 'vinay', 'vinay@vinay.com', '94089', 'right.gif');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
