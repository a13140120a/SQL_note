USE db01;

-- 1.	查詢所有食物表格中所有欄位的資料
SELECT * FROM food;
-- 2.	查詢所有食物名稱、到期日和價格
SELECT name,expiredate,price FROM food;
-- 3.	查詢所有食物名稱、到期日和價格，並將表頭重新命為'名稱'、'到期日'和'價格'
SELECT name'名稱',expiredate'到期日',price'價格' FROM food;
-- 4.	查詢所有食物的種類有哪些？(重覆的資料只顯示一次)
SELECT DISTINCT catelog FROM food; 
-- 5.	查詢所有食物名稱和種類，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & catalog'
-- - WHERE子句
SELECT CONCAT(name,' ',catelog)'Food name & catalog' FROM food;
-- 6.	查詢所有食物價格超過400的食物名稱和價格
SELECT name,price FROM food WHERE price > 400;
-- 7.	查詢所有食物價格介於250~530之間的食物名稱和價格
SELECT name,price FROM food WHERE price < 531 AND price > 249;
-- 8.	查詢所有食物價格不介於250~530之間的食物名稱和價格
SELECT name,price FROM food WHERE price NOT BETWEEN 250 AND 530;
-- 9.	查詢所有食物種類為'點心'的食物名稱和價格
SELECT name,price FROM food WHERE catelog = "點心";
-- 10.	查詢所有食物種類為'點心'和'飲料'的食物名稱、價格和種類
SELECT name,price,catelog FROM food WHERE catelog IN ("點心","飲料");
-- 11.	查詢所有食物產地為'TW'和'JP'的食物名稱和價格
SELECT name,price FROM food WHERE placeid in ('TW','JP');
-- 12.	查詢所有食物名稱有'油'字的食物名稱、到期日和價格
SELECT name,price,expiredate FROM food WHERE name LIKE '%油%';
-- 13.	查詢所有食物到期日在今年底以前到期的食物名稱和價格
SELECT name,price FROM food WHERE expiredate <= '2020/12/31';
-- 14.	查詢所有食物到期日在明年6月底以前到期的食物名稱和價格
SELECT name,price FROM food WHERE expiredate <= '2021/6/30';
-- 15.	查詢所有食物6個月內到期的食物名稱和價格
SELECT name,price ,DATEDIFF(expiredate,NOW()) / 30'hello' FROM food WHERE 'hello' > 6 ;

-- - ORDER BY子句
-- 16.	查詢所有食物名稱、到期日和價格，並以價格做降冪排序
SELECT name,price,expiredate FROM food ORDER BY price DESC;
-- 17.	查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序
SELECT name,price,expiredate FROM food ORDER BY price DESC LIMIT 3;
-- 18.	查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
SELECT name,price,expiredate FROM food WHERE catelog = '點心' AND price <=250 ORDER BY price ;
-- 19.	顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
SELECT name,price,ROUND(price*1.05)'New Price' FROM food;
-- 20.	接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
SELECT name,price,ROUND(price*1.05)'New Price',ROUND(price*1.05)-price 'Increase' FROM food;
-- 21.	顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；
-- 按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
SELECT name,price,
CASE 
WHEN price <=250 THEN price*1.08
WHEN price BETWEEN 251 AND 500 THEN price*1.05
WHEN price >500 THEN price*1.03
END'New Price' FROM food;
-- 22.	查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)
-- 和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
SELECT name,catelog ,IF(EXPIREDATE-NOW() < 0,'已過期','未過期')'expired or not',DATEDIFF(EXPIREDATE,CURDATE())'Days of expire' FROM food;
-- 23.	接續上題，並以過期天數做升冪排序
SELECT name,catelog ,IF(EXPIREDATE-NOW() < 0,'已過期','未過期')'expired or not',
DATEDIFF(EXPIREDATE,CURDATE()) 'Days of expire'
FROM food
ORDER BY DATEDIFF(EXPIREDATE,CURDATE());

-- - GROUP BY & HAVING子句
-- 24.	查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT ROUND(MAX(price))'max',ROUND(MIN(price))'min',ROUND(SUM(price))'sum',ROUND(AVG(price))'AVG'
FROM food;
-- 25.	接續上題，查詢每個種類
SELECT catelog,ROUND(MAX(price))'max',ROUND(MIN(price))'min',ROUND(SUM(price))'sum',ROUND(AVG(price))'AVG'
FROM food
GROUP BY  catelog;
-- 26.	接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
SELECT catelog,ROUND(AVG(price))'AVG'
FROM food
GROUP BY  catelog
HAVING AVG(price) > 300;
-- 27.	顯示查詢每個種類的食物數量
SELECT catelog,COUNT(catelog)'count'
FROM food
GROUP BY catelog;
-- 28.	查詢不同產地和每個種類的食物數量
SELECT placeid'產地',catelog,COUNT(catelog)'count'
FROM food
GROUP BY catelog,placeid;
