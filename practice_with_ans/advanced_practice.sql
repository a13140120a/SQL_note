CREATE TABLE IF NOT EXISTS Store_Information(
        Store_Name  VARCHAR(20),
        Sales       INT,
        Txn_Date    DATE
);
CREATE TABLE IF NOT EXISTS Internet_Sales(
        Txn_Date    DATE,
        Sales       INT
);

INSERT INTO Store_Information VALUES ('Los Angeles', 1500, '1999-01-05');
INSERT INTO Store_Information VALUES ('San Diego', 250, '1999-01-07');
INSERT INTO Store_Information VALUES ('Los Angeles', 300, '1999-01-08');
INSERT INTO Store_Information VALUES ('Boston', 700, '1999-01-08');

INSERT INTO Internet_Sales VALUES ('1999-01-07', 250);
INSERT INTO Internet_Sales VALUES ('1999-01-10', 535);
INSERT INTO Internet_Sales VALUES ('1999-01-11', 320);
INSERT INTO Internet_Sales VALUES ('1999-01-12', 750);


-- 1. 找出所有有營業額 (Sales) 的日子
SELECT Txn_Date FROM Store_Information
UNION
SELECT Txn_Date FROM Internet_Sales;
-- 2. 找出有店面營業額(Sales)以及網路營業額的日子
SELECT Txn_Date FROM Store_Information
UNION ALL
SELECT Txn_Date FROM Internet_Sales;
-- 3. 找出哪幾天有店面交易和網路交易
SELECT Txn_Date FROM Store_Information
INTERSECT
SELECT Txn_Date FROM Internet_Sales;
-- 4. 找出哪幾天是有店面營業額而沒有網路營業額的
SELECT Txn_Date FROM Store_Information
MINUS
SELECT Txn_Date FROM Internet_Sales;
-- 5. 找出所有在西部的店的營業額。
SELECT SUM(Sales) FROM Store_Information
WHERE Store_Name IN
(SELECT Store_Name FROM Geography
WHERE Region_Name = 'West');
-- 或者
SELECT SUM(a1.Sales) FROM Store_Information a1
WHERE a1.Store_Name IN
(SELECT Store_Name FROM Geography a2
WHERE a2.Store_Name = a1.Store_Name);
-- EXISTS 用法
SELECT SUM(Sales) FROM Store_Information
WHERE EXISTS
(SELECT * FROM Geography
WHERE Region_Name = 'West');
-- 6. 顯示Store_Name跟Sales, 並將 'Los Angeles' 的 Sales 數值乘以 2，以及將 'San Diego' 的 Sales 數值乘以 1.5
SELECT Store_Name, 
CASE Store_Name
  WHEN 'Los Angeles' THEN Sales * 2
  WHEN 'San Diego' THEN Sales * 1.5
  ELSE Sales
  END
"New Sales",
Txn_Date
FROM Store_Information;










