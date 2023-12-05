DELIMITER $$
CREATE PROCEDURE CalculateTotalAssets(IN p_SUser_ID INT)
BEGIN
    DECLARE total_assets DECIMAL(12,2);

    SELECT SUM(Purchase_Amount*Quantity) INTO total_assets
    FROM Asset
    WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=p_SUser_ID OR SUser_ID = p_SUser_ID);

    IF total_assets IS NULL THEN
        SET total_assets = 0;
    END IF;

    SELECT total_assets;


END $$
DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetGoalsByUser(UserID INT)
BEGIN
    SELECT *
    FROM Goals
    WHERE User_ID = UserID;

END//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAssetByUser(UserID INT)
BEGIN
SELECT *
FROM Asset
WHERE User_ID = UserID;
END//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetAllGoals(UserID INT)
BEGIN
    SELECT *
    FROM Goals
    WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=UserID OR SUser_ID = UserID);

END//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllAssets(UserID INT)
BEGIN
SELECT *
FROM Asset
WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=UserID OR SUser_ID = UserID) ;
END//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE CalculateAndReturnAssetValues(IN p_User_ID INT)
BEGIN
    DECLARE stock_value DECIMAL(10,2);
    DECLARE mutual_fund_value DECIMAL(10,2);
    DECLARE gold_value DECIMAL(10,2);
    DECLARE bonds_value DECIMAL(10,2);
    DECLARE fixed_deposits_value DECIMAL(10,2);
    SELECT
        SUM(CASE WHEN Asset_Type = 'Stock' THEN Purchase_Amount*Quantity ELSE 0 END),
        SUM(CASE WHEN Asset_Type = 'Mutual Fund' THEN Purchase_Amount*Quantity ELSE 0 END),
        SUM(CASE WHEN Asset_Type = 'Gold' THEN Purchase_Amount*Quantity ELSE 0 END),
        SUM(CASE WHEN Asset_Type = 'Bonds' THEN Purchase_Amount*Quantity ELSE 0 END),
        SUM(CASE WHEN Asset_Type = 'Fixed Deposits' THEN Purchase_Amount*Quantity ELSE 0 END)
    INTO
        stock_value,
        mutual_fund_value,
        gold_value,
        bonds_value,
        fixed_deposits_value
    FROM Asset
    WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID= p_User_ID OR SUser_ID = p_User_ID);
    SELECT stock_value AS StockValue,
           mutual_fund_value AS MutualFundValue,
           gold_value AS GoldValue,
           bonds_value AS BondsValue,
           fixed_deposits_value AS FixedDepositsValue;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_insert_asset
BEFORE INSERT
ON Asset FOR EACH ROW
BEGIN
    SET @portfolio_id := (SELECT Portfolio_ID FROM Portfolio WHERE User_ID = NEW.User_ID);
END //

CREATE TRIGGER after_insert_asset
AFTER INSERT
ON Asset FOR EACH ROW
BEGIN
    IF @portfolio_id IS NOT NULL THEN
        INSERT INTO Portfolio_Assets (Portfolio_ID, Asset_ID)
        VALUES (@portfolio_id, NEW.Asset_ID);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_delete_asset
BEFORE DELETE
ON Asset FOR EACH ROW
BEGIN
    DELETE FROM Portfolio_Assets
    WHERE Asset_ID = OLD.Asset_ID;
END //

DELIMITER ;

WITH RECURSIVE UserHierarchy AS (SELECT User_ID, SUser_ID, username FROM User WHERE SUser_ID IS NULL UNION SELECT u.User_ID, u.SUser_ID, u.username FROM UserHierarchy h JOIN User u ON h.User_ID = u.SUser_ID )SELECT * FROM UserHierarchy WHERE SUser_ID = %s ;
