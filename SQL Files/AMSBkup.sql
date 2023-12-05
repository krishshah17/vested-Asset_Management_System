CREATE TABLE `Asset` (
  `Asset_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Asset_Name` varchar(10) DEFAULT NULL,
  `Asset_Type` enum('Stock','Mutual Fund','Gold','Bonds','Fixed Deposits') DEFAULT NULL,
  `Purchase_Amount` float DEFAULT NULL,
  `Purchase_Date` date DEFAULT NULL,
  `SUser_ID` varchar(10) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
)

CREATE TABLE `Goals` (
  `Goal_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Goal_Desc` varchar(50) DEFAULT NULL,
  `Goal_Amount` float DEFAULT NULL,
  PRIMARY KEY (`Goal_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `goals_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
)

CREATE TABLE `Portfolio` (
  `Portfolio_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Portfolio_Name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Portfolio_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
)

CREATE TABLE `Portfolio_Assets` (
  `Portfolio_ID` varchar(20) NOT NULL,
  `Asset_ID` varchar(20) NOT NULL,
  PRIMARY KEY (`Portfolio_ID`,`Asset_ID`),
  KEY `asset_ibfk1` (`Asset_ID`),
  CONSTRAINT `portfolio_assets_ibfk_1` FOREIGN KEY (`Portfolio_ID`) REFERENCES `Portfolio` (`Portfolio_ID`),
  CONSTRAINT `portfolio_assets_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
)
CREATE TABLE `User` (
  `User_ID` varchar(10) NOT NULL,
  `username` varchar(10) DEFAULT NULL,
  `password` varchar(12) DEFAULT NULL,
  `email_ID` varchar(45) DEFAULT NULL,
  `phone_no` char(10) DEFAULT NULL,
  `SUser_ID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `superuser_ibfk1` (`SUser_ID`)
)
CREATE TABLE `Watchlist` (
  `Asset_ID` varchar(10) NOT NULL,
  `User_ID` varchar(10) NOT NULL,
  `Current_Amount` float DEFAULT NULL,
  `Rating` enum('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`Asset_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
)