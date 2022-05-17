CREATE TABLE IF NOT EXISTS Fact_Order(
        Order_num   VARCHAR(15),
        Order_date  DATE,
        Order_type  CHAR(1),
        Dept_id     INT,
        Unit_price  INT,
        Qty         INT,
        Amt         INT
);

CREATE TABLE IF NOT EXISTS SS_Order(
        Year        INT,
        Dept_id     INT,
        Amt         INT
);

INSERT INTO Fact_Order VALUES ('AQ20170700001', '2017-05-21', 'A', 3103, 400, 2, 800);
INSERT INTO Fact_Order VALUES ('AQ20170700002', '2018-05-21', 'A', 3104, 820, 2, 1640);
INSERT INTO Fact_Order VALUES ('AQ20170700003', '2017-05-21', 'B', 3101, 399, 1, 399);
INSERT INTO Fact_Order VALUES ('AQ20170700004', '2017-05-21', 'C', 3104, 359, 3, 1077);
INSERT INTO Fact_Order VALUES ('AQ20170700005', '2018-05-21', 'C', 3101, 359, 3, 1077);
INSERT INTO Fact_Order VALUES ('AQ20170700006', '2019-05-21', 'C', 3102, 359, 3, 1077);
INSERT INTO Fact_Order VALUES ('AQ20170700007', '2019-05-21', 'B', 3102, 359, 3, 1077);
INSERT INTO Fact_Order VALUES ('AQ20170700008', '2019-05-21', 'A', 3103, 400, 2, 800);


INSERT INTO SS_Order VALUES (2017, 3101, 0);
INSERT INTO SS_Order VALUES (2017, 3102, 0);
INSERT INTO SS_Order VALUES (2017, 3103, 0);
INSERT INTO SS_Order VALUES (2017, 3104, 0);
INSERT INTO SS_Order VALUES (2018, 3101, 0);
INSERT INTO SS_Order VALUES (2018, 3102, 0);
INSERT INTO SS_Order VALUES (2018, 3103, 0);
INSERT INTO SS_Order VALUES (2018, 3104, 0);
INSERT INTO SS_Order VALUES (2019, 3101, 0);
INSERT INTO SS_Order VALUES (2019, 3102, 0);
INSERT INTO SS_Order VALUES (2019, 3103, 0);
INSERT INTO SS_Order VALUES (2019, 3104, 0);

-- UPDATE JOIN
-- 請將銷售明細表(Fact_Order)資料，依各部門(Dept_id)+年度統計(Year)訂單金額更新至銷售彙總表(SS_Order)
UPDATE 
    SS_Order s 
JOIN 
    (SELECT 
         DATE_FORMAT(Order_date, "%Y")`Year`, 
         ANY_VALUE(Dept_id)`Dept_id`, 
         SUM(Amt)`sum` 
     FROM 
         Fact_Order 
     GROUP BY 
         DATE_FORMAT(Order_date,"%Y"), Dept_id
    )`t` 
ON 
    s.Year = t.Year AND s.Dept_id = t.Dept_id 
SET 
    s.Amt=t.sum 
WHERE 
    s.Year=t.Year AND s.Dept_id=t.Dept_id;


-- -------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Store_Information(
        Store_Name  VARCHAR(20),
        Sales       INT,
        Txn_Date    DATE
);
CREATE TABLE IF NOT EXISTS Internet_Sales(
        Txn_Date    DATE,
        Sales       INT
);

CREATE TABLE IF NOT EXISTS Geography(
        Region_Name VARCHAR(20),
        Store_Name  VARCHAR(20)
);

INSERT INTO Store_Information VALUES ('Los Angeles', 1500, '1999-01-05');
INSERT INTO Store_Information VALUES ('San Diego', 250, '1999-01-07');
INSERT INTO Store_Information VALUES ('Los Angeles', 300, '1999-01-08');
INSERT INTO Store_Information VALUES ('Boston', 700, '1999-01-08');

INSERT INTO Internet_Sales VALUES ('1999-01-07', 250);
INSERT INTO Internet_Sales VALUES ('1999-01-10', 535);
INSERT INTO Internet_Sales VALUES ('1999-01-11', 320);
INSERT INTO Internet_Sales VALUES ('1999-01-12', 750);

INSERT INTO Geography VALUES ('East', 'Boston');
INSERT INTO Geography VALUES ('East', 'New York');
INSERT INTO Geography VALUES ('West', 'Los Angeles');
INSERT INTO Geography VALUES ('West', 'San Diego');


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
SELECT 
    SUM(Sales) 
FROM 
    Store_Information s 
WHERE 
    EXISTS (SELECT Store_Name FROM Geography g WHERE s.Store_Name=g.Store_Name AND  g.Region_Name = 'West');
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
-- 7. 取得每一個區域(region_name)的總營業額(sales)
SELECT g.Region_Name, SUM(s.Sales) FROM Store_Information s JOIN Geography g ON s.Store_Name = g.Store_Name GROUP BY Region_Name;
-- 8. 取得每一個區域(region_name)的總營業額與每個商店(store_name)的總營業額的百分比(store_name/region_name X 100%)
SELECT 
    s.Region_Name, s.Store_Name, s.Sales/t.sum * 100
FROM 
    (SELECT
         g.Region_Name, s.Store_Name, s.Sales
     FROM
         Store_Information s 
     JOIN 
         Geography g 
     ON 
         s.Store_Name = g.Store_Name)`s`
JOIN 
    (SELECT 
         g.Region_Name, SUM(s.Sales)`sum`
     FROM 
         Store_Information s 
     JOIN 
         Geography g 
     ON 
         s.Store_Name = g.Store_Name 
     GROUP BY 
         Region_Name)`t`
ON 
    s.Region_Name = t.Region_Name;

