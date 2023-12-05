-- MySQL dump 10.13  Distrib 8.1.0, for macos13 (arm64)
--
-- Host: localhost    Database: AssetManSys
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
  `Asset_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Asset_Name` varchar(10) DEFAULT NULL,
  `Asset_Type` enum('Stock','Mutual Fund','Gold','Bonds','Fixed Deposits') DEFAULT NULL,
  `Purchase_Amount` float DEFAULT NULL,
  `Purchase_Date` date DEFAULT NULL,
  `SUser_ID` varchar(10) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Asset_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Asset`
--

LOCK TABLES `Asset` WRITE;
/*!40000 ALTER TABLE `Asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `Asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Goals`
--

DROP TABLE IF EXISTS `Goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Goals` (
  `Goal_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Goal_Desc` varchar(50) DEFAULT NULL,
  `Goal_Amount` float DEFAULT NULL,
  PRIMARY KEY (`Goal_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `goals_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Goals`
--

LOCK TABLES `Goals` WRITE;
/*!40000 ALTER TABLE `Goals` DISABLE KEYS */;
/*!40000 ALTER TABLE `Goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portfolio`
--

DROP TABLE IF EXISTS `Portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portfolio` (
  `Portfolio_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Portfolio_Name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Portfolio_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portfolio`
--

LOCK TABLES `Portfolio` WRITE;
/*!40000 ALTER TABLE `Portfolio` DISABLE KEYS */;
/*!40000 ALTER TABLE `Portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portfolio_Assets`
--

DROP TABLE IF EXISTS `Portfolio_Assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portfolio_Assets` (
  `Portfolio_ID` varchar(20) NOT NULL,
  `Asset_ID` varchar(20) NOT NULL,
  PRIMARY KEY (`Portfolio_ID`,`Asset_ID`),
  KEY `asset_ibfk1` (`Asset_ID`),
  CONSTRAINT `portfolio_assets_ibfk_1` FOREIGN KEY (`Portfolio_ID`) REFERENCES `Portfolio` (`Portfolio_ID`),
  CONSTRAINT `portfolio_assets_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portfolio_Assets`
--

LOCK TABLES `Portfolio_Assets` WRITE;
/*!40000 ALTER TABLE `Portfolio_Assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `Portfolio_Assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `User_ID` varchar(10) NOT NULL,
  `username` varchar(10) DEFAULT NULL,
  `password` varchar(12) DEFAULT NULL,
  `email_ID` varchar(45) DEFAULT NULL,
  `phone_no` int DEFAULT NULL,
  `SUser_ID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `superuser_ibfk1` (`SUser_ID`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`SUser_ID`) REFERENCES `User` (`User_ID`),
  CONSTRAINT `user_chk_1` CHECK (((`phone_no` < 10000000000) and (`phone_no` >= 1000000000)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Watchlist`
--

DROP TABLE IF EXISTS `Watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Watchlist` (
  `Asset_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Current_Amount` float DEFAULT NULL,
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

-- Dump completed on 2023-10-26 11:48:33
