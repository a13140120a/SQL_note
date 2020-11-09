-- --------------------資料查詢---------------------------
-- -------------------顯示特定欄位-----------------------

SELECT * FROM employee;
SELECT ename,hiredate,salary FROM employee;

-- --------------更改顯示-------------------

SELECT ename AS '員工姓名',salary*12 AS '年薪' FROM employee;

-- -----------------運算---------------

SELECT 17/4,17 DIV 4,17%4,17*NULL;

-- ----------------操作字串--------------------------

SELECT SUBSTRING(ename,1,1)'姓氏'FROM employee;
SELECT SUBSTRING(ename,2)'名字'FROM employee;
SELECT SUBSTRING('David Wang',1,5)'name';-- <---1是開始,5是長度
SELECT SUBSTRING('David Wang',7)'name';-- <--------從7開始到結束
SELECT SUBSTRING('David Wang',-4);-- <------從倒數第4開始
SELECT SUBSTRING('David Wang',-4,2);

SELECT CONCAT(ename,'is a ',title)'員工'FROM employee;
SELECT LENGTH('我是一個student')'length';-- ------顯示多少Byte
SELECT CHAR_LENGTH('我是一個student')'length';-- -------顯示字串長度

-- ------------------操作時間-------------------------

SELECT SYSDATE(),SLEEP(2),SYSDATE();-- -----會改變
SELECT NOW(),SLEEP(2),NOW();-- -------不會改變，因只回傳一次

SELECT SYSDATE() + INTERVAL 5 DAY'DATE';
SELECT SYSDATE() + INTERVAL 3 MONTH'DATE';
SELECT SYSDATE() - INTERVAL 3 HOUR'DATE';

SELECT CURDATE()'TIME';
SELECT CURTIME()'TIME';

SELECT ADDDATE(CURDATE(),5);-- <-------默認加五天
SELECT ADDDATE(CURDATE(),INTERVAL 5 DAY);-- <------interval搭配時間單位
SELECT SUBDATE(CURDATE(),INTERVAL 5 DAY);
SELECT SUBDATE(CURDATE(),INTERVAL 3 YEAR);

SELECT empno,ename,hiredate,
    YEAR(hiredate)'year',
    MONTH(hiredate)'month',
    DAY(hiredate)'day'
    FROM employee;
    -- --------------------年資顯示---------------------
SELECT empno,ename,hiredate,
    DATEDIFF(NOW(),hiredate) div 365 'year', -- 整除
	DATEDIFF(NOW(),hiredate) / 365 'year',-- 有小數點
	ROUND(DATEDIFF(NOW(),hiredate) / 365) 'year',-- 四捨五入
    ROUND(DATEDIFF(NOW(),hiredate) / 365,1) 'year'  -- 四捨五入取到第一位
    FROM employee;
    
-- --------------------幾年零幾個月----------------------
SELECT empno,ename,hiredate,
    DATEDIFF(NOW(),hiredate) div 365 'year',
	DATEDIFF(NOW(),hiredate) % 365 div 30 'month'
    FROM employee;
-- ---------------------------第三堂課-------------------------

SELECT empno,ename,salary,
	CASE
    WHEN salary>100000 THEN 'A'
    WHEN salary BETWEEN 70000 AND 100000 THEN 'B'
	WHEN salary BETWEEN 50000 AND 69999 THEN 'C'
	WHEN salary BETWEEN 30000 AND 49999 THEN 'D'
    ELSE"E"
    END 'Grade'FROM employee;
    
-- ------合併重複資料-----------------------------

SELECT deptno FROM employee;
SELECT DISTINCT deptno FROM employee;
SELECT DISTINCT mgrno FROM department;
SELECT DISTINCT deptno,title FROM employee;
    
-- ----------搜尋特定條件

SELECT * FROM employee WHERE deptno = 100;
SELECT * FROM employee WHERE title = 'engineer';
SELECT * FROM employee WHERE hiredate = '2010/11/10';
SELECT * FROM employee WHERE salary >=50000;
SELECT * FROM employee WHERE salary BETWEEN 30000 AND 40000;
SELECT * FROM employee WHERE title IN ('mamager','engineer'); -- ---------搜尋兩個關鍵字資料
SELECT * FROM department WHERE mgrno IS NULL;

-- --------------------格式化搜尋----------------------------------
SELECT * FROM employee WHERE ename LIKE '林%';
SELECT * FROM employee WHERE ename LIKE '%生';
SELECT * FROM employee WHERE ename LIKE '%麗%';
SELECT * FROM employee WHERE ename LIKE '_麗%';
SELECT * FROM employee WHERE title LIKE '%SA\_%';-- ---------底線系統可能判斷為一個任意字元的意思
SELECT * FROM employee WHERE title LIKE '%SA_%';
SELECT * FROM employee WHERE title LIKE '%SA/_%' ESCAPE '/'; --  ---'/'變成魔法字元
    
-- ------------------------邏輯運算子----------------------------- 
SELECT * FROM employee WHERE salary >=45000 AND ename LIKE '林%';
SELECT * FROM employee WHERE salary >=45000 OR ename LIKE '林%';
SELECT * FROM employee WHERE salary >=45000 AND salary <=40000;
SELECT * FROM employee WHERE title like 'manager' OR title LIKE 'engineer';

SELECT * FROM employee WHERE title NOT IN ('manager','engineer');
SELECT * FROM department WHERE mgrno IS NOT NULL;
SELECT * FROM employee WHERE salary NOT BETWEEN 40000 AND 60000;
SELECT * FROM employee WHERE ename NOT LIKE '林%';

-- ------------------升降冪排列------------------------------------
SELECT ename,deptno,salary FROM employee ORDER BY hiredate DESC;
SELECT ename,deptno,salary FROM employee ORDER BY hiredate ;
SELECT ename,deptno,salary FROM employee ORDER BY salary DESC;
SELECT ename,deptno,salary FROM employee ORDER BY salary ;

-- ---------------------預設升冪排列-------------------------------------
SELECT ename,deptno,salary FROM employee ORDER BY deptno,salary DESC;-- -------deptno沒有預設的話會按照升冪排列
SELECT ename,deptno,salary FROM employee ORDER BY deptno DESC,salary DESC;-- ------deptno 設定降冪排列之後


SELECT ename,salary*12 'Annual' FROM employee ORDER BY Annual ;
SELECT ename,salary*12 'Annual' FROM employee ORDER BY salary*12 ;
SELECT ename,deptno,salary FROM employee ORDER BY 3 ;-- ---------從第三個(salary)開始排序----
SELECT * FROM employee ORDER BY 3 ;-- ---------從所有的欄位中第三個欄位開始排序----

-- -------------------------LIMIT用法--------------------------------

SELECT * FROM employee LIMIT 3;
SELECT * FROM employee LIMIT 4,3;


SELECT * FROM employee ORDER BY hiredate LIMIT 3;-- -------找出最資深的三名員工
SELECT * FROM employee ORDER BY salary DESC LIMIT 3;-- -------找出薪水最高的三名員工




SELECT COUNT(salary)'count'          FROM employee;-- ------計算員工數量
SELECT COUNT(deptno)'count'          FROM employee;
SELECT COUNT(*)'count'               FROM employee;-- ----------最好用*號
SELECT COUNT(DISTINCT deptno)'count' FROM employee;-- -----------員工所屬的部門數量
SELECT COUNT(mgrno)'count'           FROM department;-- ----------計算主管的部門數(皆不包含NULL)




-- --------------GROUP BY---------以某欄位為集合，透過集合計算---------------------------------------

SELECT deptno,COUNT(*) 'count',SUM(salary)'sum' ,AVG(salary)'average',-- ------算出不同部門的人數和平均薪資等等
    MAX(salary)'max',MIN(salary)'min'
    FROM employee
	GROUP BY deptno;
    
SELECT deptno,COUNT(*) 'count',SUM(salary)'sum' ,AVG(salary)'average'-- ------算出不同部門的人數和平均薪資並以薪資排序
    FROM employee 
    GROUP BY deptno,title
    order by AVG(salary);

SELECT deptno,title,SUM(salary)'total' FROM employee-- -------列出不同部門和職稱的員工總薪資
    GROUP BY deptno,title
    ORDER BY  SUM(salary) DESC;
    
-- -----------------------HAVING 要接在GROUP BY 後面-----------------------------------------

SELECT deptno,AVG(salary)'average'
    FROM employee 
    GROUP BY deptno
    HAVING AVG(salary)>50000;