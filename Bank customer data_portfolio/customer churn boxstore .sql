/*
**NAME -    Nishchayjeet Singh 
**PROJECT - Customer-Churn-Records 
**File -    Customer Churn boxstore.sql
**History - 
-- -------------------------------------------------------------------
 2024-11-20 Created boxstore database
           - Added DROP/CREATE/USE DATABASE block.
           - DROP/CREATE TABLE block.
           - Loaded data from CSV into CustomerChurn table.
		   - Added SELECT statement.
*/
-- -------------------------------------------------------------------

USE mysql;

DROP DATABASE IF EXISTS ns_0411433_boxstore;     
CREATE DATABASE IF NOT EXISTS ns_0411433_boxstore
CHARSET='utf8mb4'
COLLATE='utf8mb4_unicode_ci';

USE ns_0411433_boxstore;

CREATE TABLE IF NOT EXISTS ns_0411433_boxstore.CustomerChurn (
    RowNumber INT,
    CustomerId INT,
    Surname VARCHAR(255),
    CreditScore INT,
    Geography VARCHAR(255),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15, 2),
    NumOfProducts INT,
    HasCrCard BOOLEAN,
    IsActiveMember BOOLEAN,
    EstimatedSalary DECIMAL(15, 2),
    Exited BOOLEAN,
    Complain BOOLEAN,
    SatisfactionScore INT,
    CardType VARCHAR(50),
    PointEarned INT
);


LOAD DATA LOCAL INFILE 'C:/Users/14379/Desktop/Customer-Churn-Records.csv' 
INTO TABLE CustomerChurn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;


-- Selecting All Data
SELECT * FROM CustomerChurn;

--  Counting the Total Number of Records
SELECT COUNT(*) AS TotalRecords FROM CustomerChurn;

-- Selecting Customers Who Exited (Churned)
SELECT CustomerId, Surname, Age, Geography, Exited
FROM CustomerChurn
WHERE Exited = 1;

-- Selecting Customers Who Have Complaints
SELECT CustomerId, Surname, Age, Geography, Complain
FROM CustomerChurn
WHERE Complain = 1;

-- Calculating the Average Credit Score by Gender
SELECT Gender, AVG(CreditScore) AS AvgCreditScore
FROM CustomerChurn
GROUP BY Gender;

-- Selecting Customers with the Highest Credit Scores
SELECT CustomerId, Surname, CreditScore
FROM CustomerChurn
ORDER BY CreditScore DESC
LIMIT 5;

-- Selecting Active Members by Geography
SELECT Geography, COUNT(*) AS ActiveMembers
FROM CustomerChurn
WHERE IsActiveMember = 1
GROUP BY Geography;

-- Top 5 Customers with the Highest Point Earned
SELECT CustomerId, Surname, PointEarned
FROM CustomerChurn
ORDER BY PointEarned DESC
LIMIT 5;

-- Customers with the Longest Tenure and Their Exit Status
SELECT CustomerId, Surname, Tenure, Exited
FROM CustomerChurn
ORDER BY Tenure DESC
LIMIT 5;

-- Finding Exited Customers with Low Credit Scores
SELECT 
    C.CustomerId, 
    C.Surname, 
    C.CreditScore
FROM CustomerChurn C
WHERE C.Exited = 1 AND C.CreditScore < 600;

-- Finding Active Customers with High Credit Scores
SELECT 
    CustomerId, 
    Surname, 
    CreditScore, 
    Age, 
    Geography, 
    IsActiveMember
FROM ns_0411433_boxstore.CustomerChurn
WHERE IsActiveMember = 1 AND CreditScore >= 700
ORDER BY CreditScore DESC;

-- -------------------------------------------------------------------
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(255),
    Geography VARCHAR(255),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15, 2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary DECIMAL(15, 2)
);

CREATE TABLE CreditInfo (
    CustomerId INT PRIMARY KEY,
    CreditScore INT,
    Balance DECIMAL(15, 2),
    EstimatedSalary DECIMAL(15, 2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- Insert Data into the Customer Table
INSERT INTO Customer (CustomerId, Surname, Geography, Gender, Age, Tenure, Balance, NumOfProducts, HasCrCard, IsActiveMember, EstimatedSalary) 
VALUES
(15634602, 'Hargrave', 'France', 'Female', 42, 2, 0, 1, 1, 1, 101348.88),
(15647311, 'Hill', 'Spain', 'Female', 41, 1, 83807.86, 1, 0, 1, 112542.58),
(15619304, 'Onio', 'France', 'Female', 42, 8, 159660.8, 3, 1, 0, 113931.57),
(15701354, 'Boni', 'France', 'Female', 39, 1, 0, 2, 0, 0, 93826.63),
(15737888, 'Mitchell', 'Spain', 'Female', 43, 2, 125510.82, 1, 1, 1, 79084.1),
(15574012, 'Chu', 'Spain', 'Male', 44, 8, 113755.78, 2, 1, 0, 149756.71),
(15592531, 'Bartlett', 'France', 'Male', 50, 7, 0, 2, 1, 1, 10062.8),
(15656148, 'Obinna', 'Germany', 'Female', 29, 4, 115046.74, 4, 1, 0, 119346.88),
(15792365, 'He', 'France', 'Male', 44, 4, 142051.07, 2, 0, 1, 74940.5),
(15592389, 'H?', 'France', 'Male', 27, 2, 134603.88, 1, 1, 1, 71725.73),
(15767821, 'Bearce', 'France', 'Male', 31, 6, 102016.72, 2, 0, 0, 80181.12),
(15737173, 'Andrews', 'Spain', 'Male', 24, 3, 0, 2, 1, 0, 76390.01),
(15632264, 'Kay', 'France', 'Female', 34, 10, 0, 2, 1, 0, 26260.98),
(15691483, 'Chin', 'France', 'Female', 25, 5, 0, 2, 0, 0, 190857.79),
(15600882, 'Scott', 'Spain', 'Female', 35, 7, 0, 2, 1, 1, 65951.65),
(15643966, 'Goforth', 'Germany', 'Male', 45, 3, 143129.41, 2, 0, 1, 64327.26),
(15737452, 'Romeo', 'Germany', 'Male', 58, 1, 132602.88, 1, 1, 0, 5097.67),
(15788218, 'Henderson', 'Spain', 'Female', 24, 9, 0, 2, 1, 1, 14406.41);

-- Insert Data into CreditInfo Table
INSERT INTO CreditInfo (CustomerId, CreditScore, Balance, EstimatedSalary)
VALUES
(15634602, 619, 0, 101348.88),
(15647311, 608, 83807.86, 112542.58),
(15619304, 502, 159660.8, 113931.57),
(15701354, 699, 0, 93826.63),
(15737888, 850, 125510.82, 79084.1),
(15574012, 645, 113755.78, 149756.71),
(15592531, 822, 0, 10062.8),
(15656148, 376, 115046.74, 119346.88),
(15792365, 501, 142051.07, 74940.5),
(15592389, 684, 134603.88, 71725.73),
(15767821, 528, 102016.72, 80181.12),
(15737173, 497, 0, 76390.01),
(15632264, 476, 0, 26260.98),
(15691483, 549, 0, 190857.79),
(15600882, 635, 0, 65951.65),
(15643966, 616, 143129.41, 64327.26),
(15737452, 653, 132602.88, 5097.67),
(15788218, 549, 0, 14406.41);

-- Join query (Customer and CreditInfo tables)
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId;

-- Inner Join Between Customer and CreditInfo
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
INNER JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId
WHERE ci.Balance > 10000;

--  Right Join to Include All Credit Info Records and Corresponding Customers
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
RIGHT JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId;





