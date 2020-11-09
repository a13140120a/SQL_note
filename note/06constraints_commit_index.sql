CREATE TABLE emp1(
	-- Column Level Constraints
	empno	  decimal(4)	  PRIMARY KEY,
    ename	  varchar(30)  	  NOT NULL,
    hiredate  date       	  NOT NULL,
    email     varchar(30)     UNIQUE,
    salary    int,
    deptno    decimal(3)      NOT NULL,
    title     varchar(20)	  NOT NULL DEFAULT 'engineer',
    -- Table Level Constraints
    CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno)
    REFERENCES department (deptno));
    
    
    INSERT INTO dept
    VALUES (600,'Public Relations',DEFAULT);
    
    UPDATE dept
    SET cityno = default
    WHERE deptno = 500;
-- ----------------------設定FOREIGN KEY-----------------
    ALTER TABLE `db01`.`emp1` 
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- 可以下的參數有：
-- [ON DELETE {CASCADE | SET NULL | NO ACTION | RESTRICT}]
-- [ON UPDATE {CASCADE | SET NULL | NO ACTION | RESTRICT}]

-- CASCADE - 會將有所關聯的紀錄行也會進行刪除或修改。
-- SET NULL - 會將有所關聯的紀錄行設定成 NULL。
-- NO ACTION - 有存在的關聯紀錄行時，會禁止父資料表的刪除或修改動作。
-- RESTRICT - 與 NO ACTION 相同。

-- ------------------------------------------------------------
CREATE TABLE mem(
memo INT PRIMARY KEY AUTO_INCREMENT,
mname VARCHAR(30) NOT NULL
);
DROP TABLE mem;
CREATE TABLE mem(
memo INT PRIMARY KEY AUTO_INCREMENT,
mname VARCHAR(30) NOT NULL
)AUTO_INCREMENT = 100;


INSERT INTO mem (mname) 
VALUES ('David Ho'),('Maria Wang'),('Pam Pan'),('Tina Lee'),
('Jeam Tsao');

SELECT LAST_INSERT_ID();

-- -------------交易-------------------------------------------

-- ------------外顯示ROLLBACK------------------------
START TRANSACTION;
INSERT INTO department VALUES(601,'RD',1001);
INSERT INTO department VALUES(602,'IT',NULL);
SELECT * FROM department ;
ROLLBACK;
SELECT * FROM department ;
-- -----------------外顯示COMMIT------------------

START TRANSACTION;
INSERT INTO department VALUES(601,'RD',1001);
INSERT INTO department VALUES(602,'IT',NULL);
SELECT * FROM department ;
COMMIT;
SELECT * FROM department ;


-- -----------內顯範例------------------------------
SET AUTOCOMMIT = 0;
INSERT INTO department VALUES(603,'RD',1001);
INSERT INTO department VALUES(604,'IT',NULL);
SELECT * FROM department ;
ROLLBACK;
SELECT * FROM department ;
INSERT INTO department VALUES(605,'RD',1001);
INSERT INTO department VALUES(606,'IT',NULL);
SELECT * FROM department ;
COMMIT;
SELECT * FROM department ;
SET AUTOCOMMIT = 1;

-- -------------------save point------------------------------


BEGIN;
SELECT empno,ename,salary
FROM employee 
WHERE 	empno IN (1001,1002,1003);
UPDATE employee SET salary = 60000 WHERE empno = 1001;
SAVEPOINT A;
UPDATE employee SET salary = 40000 WHERE empno = 100;
SAVEPOINT B;
UPDATE employee SET salary = 80000 WHERE empno = 1003;
ROLLBACK TO A;
COMMIT;
SELECT empno,ename,salary
FROM employee 
WHERE 	empno IN (1001,1002,1003);

-- ------------------------------------------------------


CREATE VIEW empvu100
AS SELECT empno,ename,salary
FROM employee
WHERE deptno = 100;

SELECT * FROM empvu100;

CREATE VIEW salvu100
AS SELECT empno id,ename name,salary*12'annual_salary'
FROM employee
WHERE deptno = 100;

SELECT * FROM salvu100;


CREATE VIEW salvu1001 (id,name,annual)
AS SELECT empno,ename,salary*12
FROM employee
WHERE deptno = 100;

SELECT * FROM salvu1001;


CREATE VIEW dept_sum_vw (name,minsal,maxsal,avgsal)
AS SELECT d.dname,MIN(e.salary),MAX(e.salary),AVG(e.salary)
FROM employee e,department d
WHERE e.deptno = d.deptno
GROUP BY d.dname;

SELECT * FROM dept_sum_vw;


UPDATE empvu100
SET ename = '孫悟' WHERE empno = 1009;

UPDATE empvu100
SET ename = '孫大為' WHERE empno = 1003;


CREATE VIEW emp_sal_vw
AS SELECT empno,ename,salary
FROM employee
WHERE salary <= 40000
WITH CHECK OPTION;

UPDATE emp_sal_vw
SET salary = 40001 WHERE empno = 1002;

-- -----------建立index-------------


CREATE INDEX ename_idx ON employee(ename); -- ---為employee的ename欄位建立一個非唯一的索引

SHOW INDEX FROM employee;-- ----查看employee的index狀況




