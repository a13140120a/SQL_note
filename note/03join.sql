-- -------------------JOIN---------------------------

-- -------------------------------------------------CROSS JOIN---------------------------------------------------
SELECT  emp.ename, dept.dname
FROM emp,dept;
-- ANSI下法------------
SELECT  emp.ename, dept.dname
FROM emp CROSS JOIN dept;

-- ------equal join------inner後面可接WHERE或者ON---------
SELECT  emp.ename, dept.dname
FROM emp,dept
WHERE emp.deptno = dept.deptno;

SELECT  emp.ename,dept.deptno, dept.dname-- ------ANSI下法
FROM emp JOIN dept
on emp.deptno = dept.deptno;
    
SELECT  emp.ename, emp.deptno ,dept.dname-- ---------使用JOIN USING
FROM emp JOIN dept
USING (deptno);

SELECT  emp.ename, dept.deptno ,dept.dname-- ---------使用NATURAL JOIN
FROM emp NATURAL JOIN dept;

-- ---------------------------------------------------------------------

SELECT ename,dname-- ------------------加入AND增加JOIN 條件
FROM emp ,dept
WHERE emp.deptno = dept.deptno
AND title = 'manager';

SELECT e.ename,d.dname-- ----------------------------增加別名
FROM emp e , dept d
WHERE e.deptno = d.deptno;

-- -----------------------------------------------------------------

SELECT e.ename, d.dname ,c.cname-- ------------join n個表格
FROM emp e, dept d ,city c
WHERE e.deptno = d.deptno
AND d.cityno = c.cityno;


SELECT e.ename, d.dname ,c.cname
FROM emp e join dept d 
on e.deptno = d.deptno 
join city c
on d.cityno = c.cityno;


-- ------non equal join--------------


SELECT e.ename,e.salary,g.level
FROM emp e, grade g
WHERE e.salary BETWEEN g.lowest AND g.highest;


SELECT e.ename,d.dname,e.salary,g.level
FROM emp e,dept d, grade g
WHERE e.deptno = d.deptno
AND e.salary BETWEEN g.lowest AND g.highest;


-- ----------------OUTER JOIN找出錯誤資料------------------------------

SELECT  e.ename,d.deptno, d.dname
FROM emp e RIGHT JOIN dept d
on e.deptno = d.deptno
UNION
SELECT  e.ename,d.deptno, d.dname
FROM emp e LEFT JOIN dept d
on e.deptno = d.deptno;

-- --------self-join 找出每個員工的主管是誰----------------

SELECT worker.ename'worker name',
       manager.ename'manager'
FROM emp worker, emp manager
WHERE worker.mgrno = manager.empno;