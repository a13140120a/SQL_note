USE db01;

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
FROM food JOIN place
ON food.placeid = place.id
GROUP BY place.name,catelog;
