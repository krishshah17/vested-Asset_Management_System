-- Sample data for Asset table
INSERT INTO Asset (User_ID, Asset_Name, Asset_Type, Purchase_Amount, Purchase_Date,Quantity)
VALUES
  (4, 'AAPL', 'Stock', 1000.00, '2023-01-01', 10),
  (6, 'Gold', 'Gold', 5000.00, '2023-02-15',2),
  (8, 'Axis Blue Chip MF', 'Mutual Fund', 3000.00, '2023-03-20', 5),
  (9, 'Union Bank FD ', 'Fixed Deposits', 15000.00, '2023-04-10', 6),
  (10, 'TSLA', 'Stock', 800.00, '2023-05-05', 8);

-- Sample data for Portfolio table
INSERT INTO Portfolio (Portfolio_ID, User_ID, Portfolio_Name)
VALUES
  (4, 'Port1'),
  (6, 'Port2'),
  (8, 'Port3'),
  (9, 'Port4'),
  (10, 'Port5');

-- Sample data for Goals table
INSERT INTO Goals (User_ID, Goal_Desc, Goal_Amount)
VALUES
  (4, 'Retirement', 1000000.00),
  (6, 'Vacation', 5000.00),
  (8, 'Education', 20000.00),
  (9, 'Buy a House', 150000.00),
  (10, 'Emergency Fund', 1000.00);