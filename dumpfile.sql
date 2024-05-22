-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(6,NULL,'abc@naver.com',NULL,NULL,25,NULL,'user',NULL,NULL,0),
(7,NULL,'333',NULL,NULL,26,NULL,'user',NULL,NULL,0),
(8,NULL,'hel23lo@naver.com',NULL,NULL,29,NULL,'user',NULL,NULL,0),
(9,NULL,'22222@naver.com',NULL,NULL,21,NULL,'user',NULL,NULL,0),
(10,NULL,'22@naver.com',NULL,NULL,19,NULL,'user',NULL,NULL,0),
(11,NULL,'3333@naver.com',NULL,NULL,26,NULL,'user',NULL,NULL,0),
(12,'kiiiim','bd222dd@naver.com',NULL,NULL,28,NULL,'user',NULL,NULL,0),
(13,'kiiiim','bddd@naver.com',NULL,NULL,27,NULL,'admin',NULL,NULL,0),
(14,NULL,'aaa@naver.com',NULL,NULL,25,NULL,'user','2000-05-17',NULL,0),
(15,NULL,'eee',NULL,NULL,24,NULL,'user',NULL,'2019-01-20 12:12:00',0),
(16,NULL,'222@',NULL,NULL,23,NULL,'user',NULL,'2024-05-17 07:15:25',0),
(30,'park','hello world',NULL,'sun',30,NULL,'user',NULL,NULL,0),
(51,'kim','kim@naver.com',NULL,NULL,31,NULL,'user',NULL,'2024-05-20 06:38:44',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(255) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello world',6,1000.000,'2022-05-21 11:37:39','dc13e3a7-1397-11ef-9d56-0242ac110003'),
(2,'hie',NULL,6,2000.000,'2024-05-11 12:26:33','dc13e48b-1397-11ef-9d56-0242ac110003'),
(3,'hi','hello world',NULL,1000000.000,'2023-05-21 11:37:32','dc13e4b5-1397-11ef-9d56-0242ac110003'),
(7,'hi',NULL,NULL,1234.100,'2026-05-21 11:37:43','dc13e52d-1397-11ef-9d56-0242ac110003'),
(16,'eee',NULL,NULL,3000.000,'2024-05-17 03:31:50','dc13e550-1397-11ef-9d56-0242ac110003'),
(17,'eee',NULL,NULL,400.000,'2024-05-17 03:32:16','dc13e56b-1397-11ef-9d56-0242ac110003'),
(18,'eee',NULL,NULL,7000.000,NULL,'dc13e585-1397-11ef-9d56-0242ac110003');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22  7:39:38
