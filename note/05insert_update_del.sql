-- -----------------------INSERT------------------------------------
INSERT INTO department(deptno,dname,mgrno)
VALUES (400,'Research',1001);

INSERT INTO department
VALUES (500,'Research',1001);

INSERT INTO department(deptno,dname)-- 若insert value數量與欄位數量不一樣需要指定欄位
VALUES (601,'IT');

INSERT INTO department
VALUES (602,'IT',NULL);

INSERT INTO department(deptno,dname,mgrno)
VALUES (603,'HRD',1003),(604,'STK',NULL);

INSERT INTO employee
VALUES (1009,'孫悟空','2013/11/10',56000,100,'senior engineer');
INSERT INTO employee
VALUES (1010,'李大文',CURDATE(),89000,200,'manager');



CREATE TABLE emp_copy LIKE 	employee;
INSERT INTO emp_copy SELECT * FROM employee;

CREATE TABLE emp_copy1 LIKE employee;
ALTER TABLE emp_copy1 DROP title;
ALTER TABLE emp_copy1 CHANGE empno empid DECIMAL(4);
INSERT INTO emp_copy1 (empid,ename,deptno,hiredate,salary)
SELECT empno,ename,deptno,hiredate,salary
FROM employee
WHERE title NOT LIKE '%SA%';

-- ------------------UPDATE-----------------------------------------


UPDATE emp_copy
SET salary = 45000
WHERE empno = 1008;

SET SQL_SAFE_UPDATES = 0;

UPDATE emp_copy1
SET hiredate = CURDATE();

UPDATE emp_copy
SET salary = (SELECT salary
              FROM emp_copy
              WHERE empno = 1006)
WHERE empno = 1007;-- ----------------錯誤


UPDATE emp_copy
SET salary = (SELECT salary
              FROM (SELECT * FROM emp_copy)e
              WHERE e.empno = 1006)
WHERE empno = 1007;-- ------------------正確


UPDATE emp_copy
SET deptno = (SELECT deptno
              FROM employee
              WHERE empno = 1003)
WHERE salary = (SELECT salary
              FROM employee
              WHERE empno = 1001);
              
SELECT * FROM db01.emp_copy;



-- ---------------DELETE-----------------------------
              
DELETE FROM emp_copy WHERE empno = 1007;

SET SQL_SAFE_UPDATES = 0;-- -------關閉safe mode

DELETE FROM department 
WHERE deptno BETWEEN 601 AND 604;

DELETE FROM emp_copy; -- ------刪除所有資料

TRUNCATE TABLE emp_copy;-- -------連同auto_increment 的數值也會重設

DROP TABLE emp_copy;-- -------丟掉整個table

