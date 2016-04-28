# --------------------------------------------------------
# Host:                         127.0.0.1
# Server version:               5.1.50-community
# Server OS:                    Win64
# HeidiSQL version:             6.0.0.3603
# Date/time:                    2013-01-03 21:22:23
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

# Dumping database structure for neighbours
DROP DATABASE IF EXISTS `neighbours`;
CREATE DATABASE IF NOT EXISTS `neighbours` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `neighbours`;


# Dumping structure for table neighbours.block_updates
DROP TABLE IF EXISTS `block_updates`;
CREATE TABLE IF NOT EXISTS `block_updates` (
  `blocked_by` varchar(100) NOT NULL,
  `blocked_user` varchar(100) NOT NULL,
  PRIMARY KEY (`blocked_by`,`blocked_user`),
  KEY `FK__blocked_users_2` (`blocked_user`),
  CONSTRAINT `FK__blocked_users` FOREIGN KEY (`blocked_by`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__blocked_users_2` FOREIGN KEY (`blocked_user`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.event
DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(100) NOT NULL,
  `topic` varchar(200) NOT NULL,
  `eventDescription` varchar(500) NOT NULL,
  `date` varchar(100) NOT NULL,
  `creator` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_users` (`creator`),
  CONSTRAINT `FK_event_users` FOREIGN KEY (`creator`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.event_users
DROP TABLE IF EXISTS `event_users`;
CREATE TABLE IF NOT EXISTS `event_users` (
  `event_id` int(100) NOT NULL,
  `user` varchar(100) NOT NULL,
  PRIMARY KEY (`event_id`,`user`),
  KEY `FK__users1` (`user`),
  CONSTRAINT `FK__event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `FK__users1` FOREIGN KEY (`user`) REFERENCES `users` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.invitesent
DROP TABLE IF EXISTS `invitesent`;
CREATE TABLE IF NOT EXISTS `invitesent` (
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.likes_unlikes
DROP TABLE IF EXISTS `likes_unlikes`;
CREATE TABLE IF NOT EXISTS `likes_unlikes` (
  `username` varchar(100) NOT NULL,
  `post_id` int(100) NOT NULL,
  `like_unlike` varchar(50) NOT NULL,
  PRIMARY KEY (`username`,`post_id`),
  KEY `FK_likes_unlikes_updates` (`post_id`),
  CONSTRAINT `FK_likes_unlikes_updates` FOREIGN KEY (`post_id`) REFERENCES `updates` (`post_id`),
  CONSTRAINT `FK_likes_unlikes_users` FOREIGN KEY (`username`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` int(100) NOT NULL,
  `message` varchar(500) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date_time` varchar(100) NOT NULL,
  `messageTopic` varchar(100) NOT NULL,
  `prev_message_id` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  KEY `FK_messages_users` (`sender`),
  KEY `FK_messages_users_2` (`receiver`),
  KEY `FK_messages_parent_messages` (`prev_message_id`),
  CONSTRAINT `FK_messages_users` FOREIGN KEY (`sender`) REFERENCES `users` (`Username`),
  CONSTRAINT `FK_messages_users_2` FOREIGN KEY (`receiver`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.neighbours
DROP TABLE IF EXISTS `neighbours`;
CREATE TABLE IF NOT EXISTS `neighbours` (
  `username1` varchar(100) NOT NULL DEFAULT '',
  `username2` varchar(100) NOT NULL DEFAULT '',
  `Status` varchar(100) NOT NULL,
  PRIMARY KEY (`username1`,`username2`),
  KEY `FK__users_2` (`username2`),
  CONSTRAINT `FK__users` FOREIGN KEY (`username1`) REFERENCES `users` (`Username`),
  CONSTRAINT `FK__users_2` FOREIGN KEY (`username2`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.parent_messages
DROP TABLE IF EXISTS `parent_messages`;
CREATE TABLE IF NOT EXISTS `parent_messages` (
  `message_id` int(100) NOT NULL,
  `message` varchar(400) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date_time` varchar(100) NOT NULL,
  `messageTopic` varchar(100) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `FK_parent_messages_users` (`sender`),
  KEY `FK_parent_messages_users_2` (`receiver`),
  CONSTRAINT `FK_parent_messages_users` FOREIGN KEY (`sender`) REFERENCES `users` (`Username`),
  CONSTRAINT `FK_parent_messages_users_2` FOREIGN KEY (`receiver`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.parent_updates
DROP TABLE IF EXISTS `parent_updates`;
CREATE TABLE IF NOT EXISTS `parent_updates` (
  `post_id` int(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `post` varchar(400) NOT NULL,
  `date_time` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK_updates_users` (`username`),
  KEY `Index 3` (`username`),
  CONSTRAINT `FK_parent_updates_users` FOREIGN KEY (`username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.search_users
DROP TABLE IF EXISTS `search_users`;
CREATE TABLE IF NOT EXISTS `search_users` (
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `ZipCode` varchar(100) NOT NULL,
  PRIMARY KEY (`Username`),
  KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

# Data exporting was unselected.


# Dumping structure for table neighbours.updates
DROP TABLE IF EXISTS `updates`;
CREATE TABLE IF NOT EXISTS `updates` (
  `post_id` int(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `post` varchar(400) NOT NULL,
  `date_time` varchar(100) NOT NULL,
  `parent_id` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `FK_updates_users` (`username`),
  KEY `FK_updates_parent_updates` (`parent_id`),
  CONSTRAINT `FK_updates_parent_updates` FOREIGN KEY (`parent_id`) REFERENCES `parent_updates` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_updates_users` FOREIGN KEY (`username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.


# Dumping structure for table neighbours.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `ZipCode` varchar(100) NOT NULL,
  `ProfilePic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Username`),
  KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Data exporting was unselected.
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
