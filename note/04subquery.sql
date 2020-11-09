
-- ------------------subquery子查詢---------------------------------
SELECT ename,salary -- <------找出薪水大於潘麗珍的人
FROM employee
WHERE salary>(SELECT salary FROM employee WHERE ename='潘麗珍');

SELECT  ename,title,salary
FROM employee
WHERE title=(SELECT title
			   FROM employee
				WHERE empno = 1002)
AND  salary> (SELECT salary
			    FROM employee
				WHERE empno = 1005);


SELECT deptno,MIN(salary)'min salary'
FROM employee 
GROUP BY deptno
HAVING MIN(salary) > (SELECT MIN(salary)
					  FROM employee
                      WHERE deptno = 200);
                

SELECT ename,title,salary,deptno,
CONCAT(ROUND(salary*100/ (SELECT SUM(salary)
                  FROM employee
				  WHERE deptno = 100),1),"%")'percentage'
FROM employee
WHERE deptno = 100;
                

SELECT ename,title,salary,
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


    
SELECT ename,title,salary,title
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
-- ---------------------------------------------------------
SELECT ename,title,salary
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
SELECT e.ename,e.title,e.salary,
ROUND(salary*100/(SELECT SUM(salary)
		FROM employee
        -- WHERE deptno = e.deptno 把外面的deptno抓進來(限制deptno=100)(等同WHERE deptno=100)
        WHERE deptno = e.deptno),1)'percentage' 
FROM employee e
WHERE e.deptno = 100;

SELECT deptno,ename,salary
FROM employee e
WHERE salary IN
               (SELECT MIN(salary)
               FROM employee
               GROUP BY deptno
               HAVING deptno = e.deptno); -- 可有可無
               
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



