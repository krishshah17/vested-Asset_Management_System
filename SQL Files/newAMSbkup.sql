-- MySQL dump 10.13  Distrib 8.1.0, for macos13 (arm64)
--
-- Host: localhost    Database: newAMS
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Asset`
--

DROP TABLE IF EXISTS `Asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Asset` (
  `Asset_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Asset_Name` varchar(50) DEFAULT NULL,
  `Asset_Type` enum('Stock','Mutual Fund','Gold','Bonds','Fixed Deposits') DEFAULT NULL,
  `Purchase_Amount` decimal(10,2) DEFAULT NULL,
  `Purchase_Date` datetime DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Asset_ID`),
  KEY `asset_ibfk_1` (`User_ID`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Asset`
--

LOCK TABLES `Asset` WRITE;
/*!40000 ALTER TABLE `Asset` DISABLE KEYS */;
INSERT INTO `Asset` VALUES (1,4,'AAPL','Stock',1000.00,'2023-01-01 00:00:00',10),(3,8,'Axis Blue Chip MF','Mutual Fund',3000.00,'2023-03-20 00:00:00',5),(4,9,'Union Bank FD ','Fixed Deposits',15000.00,'2023-04-10 00:00:00',1),(5,10,'TSLA','Stock',800.00,'2023-05-05 00:00:00',8),(19,6,'Govt Bond','Bonds',1000.00,'2023-11-18 00:00:00',7),(20,9,'HDFC FD','Fixed Deposits',10000.00,'2023-11-18 22:58:39',5),(21,25,'Passion Fund','Fixed Deposits',10000.00,'2023-11-18 00:00:00',4),(22,6,'NewAsset','Stock',10.00,'2023-11-18 00:00:00',100);
/*!40000 ALTER TABLE `Asset` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_asset` BEFORE INSERT ON `asset` FOR EACH ROW BEGIN
    -- Get the user's Portfolio ID and set it as a session variable
    SET @portfolio_id := (SELECT Portfolio_ID FROM Portfolio WHERE User_ID = NEW.User_ID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_asset` AFTER INSERT ON `asset` FOR EACH ROW BEGIN
    -- Check if Portfolio_ID is not NULL
    IF @portfolio_id IS NOT NULL THEN
        -- Insert into Portfolio_Assets
        INSERT INTO Portfolio_Assets (Portfolio_ID, Asset_ID)
        VALUES (@portfolio_id, NEW.Asset_ID);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_asset` BEFORE DELETE ON `asset` FOR EACH ROW BEGIN
    -- Delete corresponding entry in Portfolio_Assets
    DELETE FROM Portfolio_Assets
    WHERE Asset_ID = OLD.Asset_ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Goals`
--

DROP TABLE IF EXISTS `Goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Goals` (
  `Goal_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Goal_Desc` varchar(50) DEFAULT NULL,
  `Goal_Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Goal_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `goals_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Goals`
--

LOCK TABLES `Goals` WRITE;
/*!40000 ALTER TABLE `Goals` DISABLE KEYS */;
INSERT INTO `Goals` VALUES (1,4,'Retirement',1000000.00),(3,8,'Education',20000.00),(13,10,'Emergency Fund',1000.00),(20,6,'Retirement Fund',10000000.00);
/*!40000 ALTER TABLE `Goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portfolio`
--

DROP TABLE IF EXISTS `Portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portfolio` (
  `Portfolio_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Portfolio_Name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Portfolio_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portfolio`
--

LOCK TABLES `Portfolio` WRITE;
/*!40000 ALTER TABLE `Portfolio` DISABLE KEYS */;
INSERT INTO `Portfolio` VALUES (1,4,'Port1'),(2,6,'Port2'),(3,8,'Port3'),(4,9,'Port4'),(5,10,'Port5');
/*!40000 ALTER TABLE `Portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portfolio_Assets`
--

DROP TABLE IF EXISTS `Portfolio_Assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portfolio_Assets` (
  `Portfolio_ID` int NOT NULL,
  `Asset_ID` int NOT NULL,
  PRIMARY KEY (`Portfolio_ID`,`Asset_ID`),
  KEY `portfolio_assets_ibfk_2` (`Asset_ID`),
  CONSTRAINT `portfolio_assets_ibfk_1` FOREIGN KEY (`Portfolio_ID`) REFERENCES `Portfolio` (`Portfolio_ID`),
  CONSTRAINT `portfolio_assets_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portfolio_Assets`
--

LOCK TABLES `Portfolio_Assets` WRITE;
/*!40000 ALTER TABLE `Portfolio_Assets` DISABLE KEYS */;
INSERT INTO `Portfolio_Assets` VALUES (2,19),(4,20),(2,22);
/*!40000 ALTER TABLE `Portfolio_Assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email_id` varchar(45) DEFAULT NULL,
  `phone_no` char(10) DEFAULT NULL,
  `SUser_ID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `username` (`username`),
  KEY `superuser_ibfk1` (`SUser_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (4,'krishshah','krish1710','krishshah.17@gmail.com','8971775677',NULL),(6,'Sanjay','nahi','sanjay@gmail.com','8971775678',NULL),(8,'krish','krish','krish@gmail.com','8971775677',NULL),(9,'Roshni','shah','chuprsh@gmail.com','9343233354','6'),(10,'Vidhi','shah','vss@gmail.com','9876543210','6'),(15,'happy','sad','nothappy@gmail.com','9876543210',NULL),(19,'jugal','jugal123','jug@gmail.com','9900360365',NULL),(20,'yes','shah1234','happy@gmail.com','',NULL),(23,'kshitij','agar','kshitj@gmail.com','9876543210',NULL),(24,'Niranjan','nope','niranjan@gmail.com','9876543210',NULL),(25,'vishh','shsh','nagarkattiviha@ggail.co.in','9876543210','4');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Watchlist`
--

DROP TABLE IF EXISTS `Watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Watchlist` (
  `Asset_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  `Current_Amount` decimal(10,2) DEFAULT NULL,
  `Rating` enum('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`Asset_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Watchlist`
--

LOCK TABLES `Watchlist` WRITE;
/*!40000 ALTER TABLE `Watchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Watchlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-20  8:42:38
