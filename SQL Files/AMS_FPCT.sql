DELIMITER $$
CREATE FUNCTION CalculateUserTotalAssets(p_UserID INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Purchase_Amount) INTO total FROM Asset WHERE User_ID = p_UserID;
    IF total IS NULL THEN
        SET total = 0;
    END IF;
    RETURN total;
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CalculateTotalAssetsAndTypes(IN p_SUser_ID INT)
BEGIN
    DECLARE total_assets DECIMAL(10,2);

    -- Calculate the total assets for all users with p_SUser_ID as SUser_ID or User_ID
    SELECT SUM(Purchase_Amount) INTO total_assets
    FROM Asset
    WHERE User_ID = p_SUser_ID OR SUser_ID = p_SUser_ID;

    -- If there are no assets, set the total_assets to 0
    IF total_assets IS NULL THEN
        SET total_assets = 0;
    END IF;

    -- Display the total assets
    SELECT CONCAT('Total Assets for Users with SUser_ID or User_ID = ', p_SUser_ID, ': ', total_assets) AS Result;

    -- Calculate and display individual asset types
    -- SELECT Asset_Type, SUM(Purchase_Amount) AS TotalAmount
    -- FROM Asset
    -- WHERE User_ID = p_SUser_ID OR SUser_ID = p_SUser_ID
    -- GROUP BY Asset_Type;

END $$

DELIMITER ;


DELIMITER //

CREATE PROCEDURE CalculateAndReturnAssetValues(IN p_User_ID INT)
BEGIN
    DECLARE stock_value DECIMAL(10,2);
    DECLARE mutual_fund_value DECIMAL(10,2);
    DECLARE gold_value DECIMAL(10,2);
    DECLARE bonds_value DECIMAL(10,2);
    DECLARE fixed_deposits_value DECIMAL(10,2);

    -- Calculate the values for each asset type
    SELECT
        SUM(CASE WHEN Asset_Type = 'Stock' THEN Purchase_Amount ELSE 0 END) INTO stock_value,
        SUM(CASE WHEN Asset_Type = 'Mutual Fund' THEN Purchase_Amount ELSE 0 END) INTO mutual_fund_value,
        SUM(CASE WHEN Asset_Type = 'Gold' THEN Purchase_Amount ELSE 0 END) INTO gold_value,
        SUM(CASE WHEN Asset_Type = 'Bonds' THEN Purchase_Amount ELSE 0 END) INTO bonds_value,
        SUM(CASE WHEN Asset_Type = 'Fixed Deposits' THEN Purchase_Amount ELSE 0 END) INTO fixed_deposits_value
    FROM Asset
    WHERE User_ID = p_User_ID OR SUser_ID = p_SUser_ID;

    -- Display the calculated values
    SELECT stock_value AS StockValue,
           mutual_fund_value AS MutualFundValue,
           gold_value AS GoldValue,
           bonds_value AS BondsValue,
           fixed_deposits_value AS FixedDepositsValue;
END //

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
    WHERE User_ID = UserID OR SUser_ID=UserID;

END//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllAssets(UserID INT)
BEGIN
SELECT *
FROM Asset
WHERE User_ID in (SELECT User_ID FROM User WHERE User_ID=UserID OR SUser_ID = UserID);
END//
DELIMITER ;