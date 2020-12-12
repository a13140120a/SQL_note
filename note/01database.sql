CREATE DATABASE db01;
CREATE SCHEMA `db02`;
CREATE DATABASE IF NOT EXISTS db01;
SHOW DATABASES;
USE db01; -- ---------------------------SWITCH
SHOW CHARSET;
SHOW COLLATION;
CREATE SCHEMA `db03` DEFAULT CHARACTER SET big5;

SHOW COLLATION LIKE 'big5%';

ALTER DATABASE db02
CHARACTER SET big5
COLLATE big5_chinese_ci ;
SELECT @@character_set_database,@@collation_database;
SHOW COLUMNS FROM tbl_name;
SHOW FULL COLUMNS FROM tbl_name;

SHOW VARIABLES LIKE "collation_%"; -- 查看編碼

--     -----------------建立表格-----------
CREATE TABLE employee(
	empno	  decimal(4)	  PRIMARY KEY,
    ename	  varchar(30)  	  NOT NULL,
    hiredate  date       	  NOT NULL,
    salary    int             NOT NULL,
    deptno    decimal(3)      NOT NULL,
    title     varchar(20)	  NOT NULL
);

CREATE TABLE `db01`.`department` (
  `deptno` DECIMAL(3) NOT NULL,
  `dname` VARCHAR(30) NOT NULL,
  `mgrno` DECIMAL(4) NULL,
  PRIMARY KEY (`deptno`));

-- ---------顯示table--------------------
SHOW TABLES; -- ---顯示table
SHOW TABLE STATUS;-- ----顯示較詳細的table
SHOW TABLE STATUS IN sakila;-- ----看sakila

-- -------------操作table------------------

desc t; 
CREATE TABLE t(a int, b char(10), c double);
ALTER TABLE t add d varchar(20) first ;
ALTER TABLE t modify c decimal(10,2);
ALTER TABLE t change d e varchar(30);
ALTER TABLE t drop b;
ALTER TABLE t rename tt1;
drop table tt1;

CREATE TABLE emp LIKE employee;

-- -----------------作業--------------------

 CREATE TABLE db01.food (
		id 				char(5) 		PRIMARY KEY,
		`name`  			varchar(30)  	NOT NULL,
		expiredate 		datetime 		NOT NULL,
		placeid 		char(2) 		NOT NULL,
		price 			int unsigned 	NOT NULL,
		catelog 		varchar(20) 	NOT NULL);

drop table food;

CREATE TABLE `place`(
	`id` CHAR(2) NOT NULL,
    `name` VARCHAR(20) NULL,
    PRIMARY KEY(`id`));
    
CREATE TABLE food1 LIKE food;

