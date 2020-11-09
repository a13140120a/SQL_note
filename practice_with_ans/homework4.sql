USE db01;

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
WHERE price < (SELECT AVG(price)
               FROM food
                )
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
