
-- ------------------subquery子查詢---------------------------------
SELECT ename,salary -- <------找出薪水大於潘麗珍的人
FROM employee
WHERE salary>(SELECT salary FROM employee WHERE ename='潘麗珍');

SELECT  ename,title,salary-- <----找出編號為1002且薪資大於編號1005員工的所有員工
FROM employee
WHERE title=(SELECT title
			   FROM employee
				WHERE empno = 1002)
AND  salary> (SELECT salary
			    FROM employee
				WHERE empno = 1005);


SELECT deptno,MIN(salary)'min salary' -- <---找出所有最低薪資比部門代號200的最低薪資還高的部門
FROM employee 
GROUP BY deptno
HAVING MIN(salary) > (SELECT MIN(salary)
					  FROM employee
                      WHERE deptno = 200);
                

SELECT ename,title,salary,deptno,。-- <----找出部門代號100每個員工薪資占部門100所有員工薪資百分比
CONCAT(ROUND(salary*100/ (SELECT SUM(salary)
                  FROM employee
				  WHERE deptno = 100),1),"%")'percentage'
FROM employee
WHERE deptno = 100;
                

SELECT ename,title,salary, -- <---同上
ROUND(salary*100/t.total,1)'percentage'
FROM employee,(SELECT SUM(salary)'total'
               FROM employee
               WHERE deptno = 100)t  -- 別名，把deptno=100全部加總，回傳 1 row
WHERE deptno = 100;

-- Error Code: 1242. Subquery returns more than 1 row

SELECT empno,ename
FROM employee 
WHERE salary = (SELECT MIN(salary)
                FROM employee
                GROUP BY deptno);
-- -----------------------------------------------------------------                
-- subquery中條件有=、！=、<、>等等作為運算式使用時，不允許傳回多值
-- 必須使用ANY、ALL、IN
-- <ANY 小於最大的
-- >ANY 大於最小的
-- =ANY 等於IN
-- <ALL 小於最小的
-- >ALL 大於最大的
-- IN =ANY
-- NOT IN <>ALL


SELECT ename,title,salary,title -- <---找出職稱不是senior engineer 且薪資比任何一個senior engineer 還低的員工
FROM employee
WHERE salary < ANY(SELECT salary
                   FROM employee        
                   WHERE title ='senior engineer') -- 即小於最大
AND title <> 'senior engineer';

-- 等同於------
SELECT ename,title,salary
FROM employee
WHERE salary < (SELECT MAX(salary)
                   FROM employee        
                   WHERE title ='senior engineer')
AND title <> 'senior engineer';
-- -------------------------------------------------------

SELECT ename,title,salary-- <---找出職稱不是senior engineer 且薪資比所有senior engineer 還低的員工
FROM employee
WHERE salary < ALL(SELECT salary
                   FROM employee        
                   WHERE title ='senior engineer')
AND title <> 'senior engineer';
-- 等同於-----
SELECT ename,title,salary
FROM employee
WHERE salary < (SELECT MIN(salary)
                   FROM employee        
                   WHERE title ='senior engineer')
AND title <> 'senior engineer';
-- ------------------------------------------------------


-- --找出所有主管---------------------
SELECT ename
FROM emp
WHERE empno IN (SELECT DISTINCT mgrno
                FROM emp);
-- ---找出所有不是主管的員工--------


SELECT ename
FROM emp
WHERE empno NOT IN (SELECT DISTINCT mgrno
                FROM emp);-- -------------錯誤示範-----NOT IN運算子碰到NULL會變成NULL
-- ------正確示範---------     
SELECT ename
FROM emp
WHERE empno NOT IN (SELECT DISTINCT mgrno
                FROM emp
                WHERE mgrno IS NOT NULL);      
                
-- -----------------------------------------
SELECT e.ename,e.title,e.salary,-- <----找出部門代號100每個員工薪資占部門100所有員工薪資百分比
ROUND(salary*100/(SELECT SUM(salary)
		FROM employee
        -- WHERE deptno = e.deptno 把外面的deptno抓進來(限制deptno=100)(等同WHERE deptno=100)
        WHERE deptno = e.deptno),1)'percentage' 
FROM employee e
WHERE e.deptno = 100;

-- -----------------------------------------
SELECT deptno,ename,salary -- <---找出每個部門薪資最低的員工
FROM employee e
WHERE salary IN
               (SELECT MIN(salary)
               FROM employee
               GROUP BY deptno
               HAVING deptno = e.deptno);
               
-- ----------等同於------------------
SELECT deptno,ename,salary
FROM employee e
WHERE salary =
               (SELECT MIN(salary)
               FROM employee
               WHERE deptno = e.deptno);
               
CREATE TABLE emp100 AS
SELECT empno,ename,salary*12'annualsalary',hiredate
FROM employee
WHERE 	deptno = 100;



