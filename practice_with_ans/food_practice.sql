 CREATE TABLE db01.food (
		id 				char(5) 		PRIMARY KEY,
		`name`  			varchar(30)  	NOT NULL,
		expiredate 		datetime 		NOT NULL,
		placeid 		char(2) 		NOT NULL,
		price 			int unsigned 	NOT NULL,
		catelog 		varchar(20) 	NOT NULL);

CREATE TABLE `place`(
	`id` CHAR(2) NOT NULL,
        `name` VARCHAR(20) NULL,
        PRIMARY KEY(`id`));

INSERT INTO food VALUES ('CK001', '曲奇餅乾', '2017/01/10', 'TL', 250, '點心');
INSERT INTO food VALUES ('CK002', '蘇打餅乾', '2020/10/12', 'TW', 80, '點心');
INSERT INTO food VALUES ('DK001', '高山茶', '2021/05/23', 'TW', 780, '飲料');
INSERT INTO food VALUES ('DK002', '綠茶', '2022/06/11', 'JP', 530, '飲料');
INSERT INTO food VALUES ('OL001', '苦茶油', '2019/03/16', 'TW', 360, '調味品');
INSERT INTO food VALUES ('OL002', '橄欖油', '2020/11/25', 'TL', 420, '調味品');
INSERT INTO food VALUES ('CK003', '仙貝', '2020/11/01', 'JP', 270, '點心');
INSERT INTO food VALUES ('SG001', '醬油', '2018/05/05', 'JP', 260, '調味品');
INSERT INTO food VALUES ('OL003', '葡萄子油', '2021/05/05', 'JP', 550, '調味品');
INSERT INTO food VALUES ('CK004', '鳳梨酥', '2020/10/12', 'TW', 340, '點心');
INSERT INTO food VALUES ('CK005', '太陽餅', '2020/9/27', 'TW', 150, '點心');
INSERT INTO food VALUES ('DK003', '紅茶', '2020/11/12', 'TL', 260, '飲料');
INSERT INTO food VALUES ('SG002', '醋', '2020/09/18', 'TW', 60, '調味品');

INSERT INTO place VALUES ('TW', '台灣');
INSERT INTO place VALUES ('JP', '日本');
INSERT INTO place VALUES ('TL', '泰國');
INSERT INTO place VALUES ('US', '美國');

-- -------------------------------------------------------------------------------------------------------
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
SELECT 
    name,price,
    CASE 
	WHEN price <=250 
	    THEN price*1.08
	WHEN price BETWEEN 251 AND 500 
	    THEN price*1.05
	WHEN price >500 
	    THEN price*1.03
    END'New Price' 
FROM food;
-- 22.	查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)
-- 和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
SELECT name,catelog ,IF(EXPIREDATE-NOW() < 0,'已過期','未過期')'expired or not',
       DATEDIFF(EXPIREDATE,CURDATE())'Days of expire' 
FROM food;
-- 23.	接續上題，並以過期天數做升冪排序
SELECT name,catelog ,IF(EXPIREDATE-NOW() < 0,'已過期','未過期')'expired or not',
DATEDIFF(EXPIREDATE,CURDATE()) 'Days of expire'
FROM food
ORDER BY DATEDIFF(EXPIREDATE,CURDATE());

-- - GROUP BY & HAVING子句
-- 24.	查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT 
    ROUND(MAX(price))'max',
    ROUND(MIN(price))'min',
    ROUND(SUM(price))'sum',
    ROUND(AVG(price))'AVG' 
FROM food;
-- 25.	接續上題，查詢每個種類
SELECT 
    catelog,ROUND(MAX(price))'max',
    ROUND(MIN(price))'min',
    ROUND(SUM(price))'sum',
    ROUND(AVG(price))'AVG' 
FROM 
    food
GROUP BY  
    catelog;
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

-- --------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM place;
-- 1.	查詢所有食物名稱、產地編號、產地名稱和價格
SELECT food.name,food.price,place.id,place.name
FROM food JOIN place
on food.placeid = place.id;
-- 2.	查詢所有食物名稱和產地名稱，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & place'
SELECT concat(food.name,' ',place.name)'Food name & place'
FROM food JOIN place
on food.placeid = place.id;
-- 3.	查詢所有'台灣'生產的食物名稱和價格
SELECT food.name,food.price,place.name
FROM food JOIN place
WHERE food.placeid = place.id
AND place.name ='台灣' ;
-- 4.	查詢所有'台灣'和'日本'生產的食物名稱和價格，並以價格做降冪排序
SELECT food.name,food.price,place.name
FROM food JOIN place
WHERE food.placeid = place.id
AND place.name IN('台灣','日本')
ORDER BY food.price DESC;
-- 5.	查詢前三個價格最高且'台灣'生產的食物名稱、到期日和價格，並以價格做降冪排序
SELECT food.name,food.price,place.name
FROM food JOIN place
ON food.placeid = place.id
WHERE place.name ='台灣' 
ORDER BY food.price DESC
LIMIT 3;
-- 6.	查詢每個產地(顯示產地名稱)最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，
-- 結果皆以四捨五入的整數來顯示
SELECT place.name,ROUND(MAX(food.price))'MAX',ROUND(MIN(food.price))'MIN',ROUND(SUM(food.price))'SUM',ROUND(AVG(food.price))'AVG'
FROM food JOIN place
on food.placeid = place.id
GROUP BY place.name;
-- 7.	查詢不同產地(顯示產地名稱)和每個種類的食物數量
SELECT place.name,COUNT(catelog)'種類食物數量' 
FROM 
    food JOIN place
ON 
    food.placeid = place.id
GROUP BY place.name,catelog;
-- --------------------------------------------------------------------------------------------------------------------------------------

-- 1.	查詢所有比'鳳梨酥'貴的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE price > (SELECT price
               FROM food
               WHERE name = '鳳梨酥');

-- 2.	查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE price < (SELECT price
               FROM food
               WHERE name = '曲奇餅乾')
AND catelog = '點心';
-- 3.	查詢所有和'鳳梨酥'同一年到期的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE YEAR(expiredate) = (SELECT YEAR(expiredate)
					FROM food
					WHERE name = '鳳梨酥');
-- 4.	查詢所有比平均價格高的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE price > (SELECT AVG(price)
               FROM food);
-- 5.	查詢所有比平均價格低的'台灣'食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food
WHERE 
    price < (SELECT AVG(price) FROM food)
AND placeid = 'TW';
-- 6.	查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food 
WHERE catelog = (SELECT catelog 
             FROM food 
             WHERE name = '仙貝')
AND price < (SELECT price 
             FROM food 
             WHERE name = '仙貝');
-- 7.	查詢所有產地和'仙貝'相同且過期超過6個月以上的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food 
WHERE placeid = (SELECT placeid 
             FROM food 
             WHERE name = '仙貝')
AND DATEDIFF(expiredate,CURDATE())/30 < -6;
-- 8.	查詢每個產地價格最低的食物名稱、到期日和價格
SELECT name,expiredate,price
FROM food f 
WHERE price IN (SELECT MIN(price)
                 FROM food
                 GROUP BY placeid
                 HAVING placeid = f.placeid);
-- 9.	查詢每個種類的食物價格最高者的食物名稱和價格
SELECT 	name,price
    FROM food f
    WHERE price IN (SELECT MAX(price)
                    FROM food
                    GROUP BY catelog
                    HAVING catelog = f.catelog);
-- 10.	查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
SELECT name,catelog,price
FROM food
WHERE price > ANY(SELECT price 
				FROM food
               WHERE catelog = '點心')
AND catelog <>'點心'
ORDER BY price DESC;
-- 11.	查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
SELECT f.name,price,p.name
FROM food f,place p
WHERE price IN (SELECT MAX(price) 
               FROM food 
			   GROUP BY placeid
               HAVING f.placeid = p.id );
