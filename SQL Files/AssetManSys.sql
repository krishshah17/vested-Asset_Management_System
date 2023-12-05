-- v 1.0 of SQL for Asset Management System

CREATE TABLE User(User_ID varchar(10), username varchar(10),password varchar(12), email_ID varchar(45), phone_no int, SUser_ID varchar(10), primary key(User_ID), CHECK(phone_no<10000000000 and phone_no>=1000000000));
ALTER TABLE User ADD CONSTRAINT FOREIGN KEY superuser_ibfk1 (SUser_ID) REFERENCES User(User_ID);

CREATE TABLE Asset(Asset_ID varchar(10),User_ID varchar(10), Asset_Name varchar(10), Asset_Type enum("Stock","Mutual Fund","Gold","Bonds", "Fixed Deposits"), Purchase_Amount float(20), Purchase_Date date, SUser_ID varchar(10), Quantity int, primary key(Asset_ID,User_ID));
ALTER TABLE Asset ADD CONSTRAINT FOREIGN KEY user_ibfk1 (User_ID) REFERENCES User(User_ID);

CREATE TABLE Portfolio(Portfolio_ID varchar(10),User_ID varchar(10), Portfolio_Name varchar(10), primary key(Portfolio_ID, User_ID));
ALTER TABLE Portfolio ADD CONSTRAINT FOREIGN KEY user_ibfk1 (User_ID) REFERENCES User(User_ID);


CREATE TABLE Goals(Goal_ID varchar(10),User_ID varchar(10), Goal_Desc varchar(50), Goal_Amount float(20), primary key(Goal_ID, User_ID));
ALTER TABLE Goals ADD CONSTRAINT FOREIGN KEY user_ibfk1 (User_ID) REFERENCES User(User_ID);


CREATE TABLE Watchlist(Asset_ID varchar(10),Asset_Name varchar(10),User_ID varchar(10),Current_Amount float(20), Rating enum("1","2","3","4","5"), primary key(Asset_ID, User_ID));
ALTER TABLE Watchlist ADD CONSTRAINT FOREIGN KEY user_ibfk1 (User_ID) REFERENCES User(User_ID);
ALTER TABLE Watchlist ADD CONSTRAINT FOREIGN KEY asset_ibfk1 (Asset_ID) REFERENCES Asset(Asset_ID);
ALTER TABLE Watchlist ADD CONSTRAINT FOREIGN KEY asset_ibfk2 (Asset_Name) REFERENCES Asset(Asset_Name);


CREATE TABLE Portfolio_Assets (Portfolio_ID varchar(20), Asset_ID varchar(20), primary key (Portfolio_ID, Asset_ID));
ALTER TABLE Portfolio_Assets ADD CONSTRAINT FOREIGN KEY portfolio_ibfk1 (Portfolio_ID) REFERENCES Portfolio(Portfolio_ID);
ALTER TABLE Portfolio_Assets ADD CONSTRAINT FOREIGN KEY asset_ibfk1 (Asset_ID) REFERENCES Asset(Asset_ID);
