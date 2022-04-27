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


-- 找出所有有營業額 (Sales) 的日子
SELECT Txn_Date FROM Store_Information
UNION
SELECT Txn_Date FROM Internet_Sales;
