-- Updated User Table
CREATE TABLE `User` (
  `User_ID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(10) DEFAULT NULL,
  `password` VARCHAR(255) DEFAULT NULL,
  `email_ID` VARCHAR(45) DEFAULT NULL,
  `phone_no` CHAR(10) DEFAULT NULL,
  `SUser_ID` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `superuser_ibfk1` (`SUser_ID`)
);

-- Updated Asset Table
CREATE TABLE `Asset` (
  `Asset_ID` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `User_ID` INT NOT NULL,
  `Asset_Name` VARCHAR(10) DEFAULT NULL,
  `Asset_Type` ENUM('Stock','Mutual Fund','Gold','Bonds','Fixed Deposits') DEFAULT NULL,
  `Purchase_Amount` DECIMAL(10,2) DEFAULT NULL,
  `Purchase_Date` DATETIME DEFAULT NULL,
  `SUser_ID` VARCHAR(10) DEFAULT NULL,
  `Quantity` INT DEFAULT NULL,
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
);

-- Updated Goals Table
CREATE TABLE `Goals` (
  `Goal_ID` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `User_ID` INT NOT NULL,
  `Goal_Desc` VARCHAR(50) DEFAULT NULL,
  `Goal_Amount` DECIMAL(10,2) DEFAULT NULL,
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `goals_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
);

-- Updated Portfolio Table
CREATE TABLE `Portfolio` (
  `Portfolio_ID` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `User_ID` INT NOT NULL,
  `Portfolio_Name` VARCHAR(10) DEFAULT NULL,
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`)
);

-- Updated Portfolio_Assets Table
CREATE TABLE `Portfolio_Assets` (
  `Portfolio_ID` INT NOT NULL,
  `Asset_ID` INT NOT NULL,
  PRIMARY KEY (`Portfolio_ID`,`Asset_ID`),
  CONSTRAINT `portfolio_assets_ibfk_1` FOREIGN KEY (`Portfolio_ID`) REFERENCES `Portfolio` (`Portfolio_ID`),
  CONSTRAINT `portfolio_assets_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
);

-- Updated Watchlist Table
CREATE TABLE `Watchlist` (
  `Asset_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  `Current_Amount` DECIMAL(10,2) DEFAULT NULL,
  `Rating` ENUM('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`Asset_ID`,`User_ID`),
  KEY `user_ibfk1` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`),
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`Asset_ID`) REFERENCES `Asset` (`Asset_ID`)
);
