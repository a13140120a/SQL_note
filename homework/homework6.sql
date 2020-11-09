-- // Select練習
USE db02;
-- 1.	建立一個查詢來顯示部門(dept)資料表中的所有資料。
SELECT * FROM dept;
-- 2.	建立一個查詢來顯示每一位員工的姓名(name)、職稱(job)、進公司日期(hire date)及員工編號(employee number )，並將且員工編號顯示在最前面。
SELECT EMPNO,ENAME,JOB,HIREDATE FROM emp;
select * FROM emp;
-- 3.	建立一個查詢來顯示所有員工所擔任的職稱有哪些? (重複的資料只顯示一次)
SELECT JOB FROM emp group by JOB;
-- 4.	建立一個查詢來顯示每一位員工的姓名(name)、職稱(job)、進公司日期(hire date)及員工編號(employee number )，
-- 並將且員工編號顯示在最前面。並將資料表頭重新命名為：Emp#, Employee, Job, Hire Date。
SELECT EMPNO'Emp#',ENAME'Employee',JOB'Job',HIREDATE'Hire Date' FROM emp;
-- 5.	建立一個查詢將姓名(name)及職稱(job)串接為依個資料項(資料中間利用一個空白和一個逗號做區隔)，並將表頭重新命名為 Employee and Title。
SELECT CONCAT(ename,',',JOB)'Employee and Title' FROM emp;
-- // where練習
-- 6.	顯示出所有員工薪資超過2850元的員工之姓名和薪資。
SELECT ename,sal FROM emp WHERE SAL > 2850;
-- 7.	顯示員工編號為7566員工的姓名和他所屬的部門編號。
SELECT ENAME,DEPTNO FROM emp WHERE EMPNO = '7566';
-- 8.	顯示薪資不介於1500~2850元之間的所有員工之姓名和薪資。
select ENAME,SAL FROM emp WHERE SAL NOT BETWEEN 1500 AND 2850;
-- 9.	顯示於1981年2月20日和1981年5月1日間進入公司的員工之姓名,職稱和進公司日期，
-- 並依進公司日期由小到大排序。
SELECT ENAME,JOB,HIREDATE FROM emp WHERE HIREDATE BETWEEN "1981-02-20" AND "1981-05-01" ORDER BY HIREDATE;
-- 10.	顯示部門10和30所有員工之姓名和他所屬的部門編號，並依名字依英文字母順序排序。
SELECT ENAME,DEPTNO FROM emp WHERE DEPTNO IN ('10','30') ORDER BY ENAME;
-- 11.	顯示薪資超過1500“且”在10“或”30部門工作員工之姓名和薪資，把分別把表頭命名為Employee和 Monthly Salary。
SELECT ENAME'Employee',SAL'Monthly Salary' FROM emp WHERE SAL >1500 AND DEPTNO IN ('10','30');
-- 12.	顯示於1982年進公司的所有員工之姓名,職稱和進公司日期。
SELECT ENAME,JOB,HIREDATE FROM emp WHERE HIREDATE < "1982--01-01";
-- 13.	顯示沒有主管的員工之姓名和職稱。
SELECT ENAME,JOB FROM emp WHERE MGR IS NULL;
-- 14.	顯示所有有賺取佣金的員工之姓名,薪資和佣金，並以薪資和佣金作降冪排列。
SELECT ENAME,SAL,COMM FROM emp WHERE COMM IS NOT NULL ORDER BY SAL DESC, COMM DESC;
-- 15.	顯示所有名字裡第三個英文字母為A的員工之姓名與職稱。
SELECT ENAME,JOB FROM emp WHERE ENAME LIKE "__A%";
-- 16.	顯示名字裡有兩個“L”且在30部門工作或經理是7782的員工之姓名,經理員工編號及所屬的部門編號。
SELECT ENAME,MGR,DEPTNO FROM emp WHERE ENAME LIKE "%L%L%" AND DEPTNO = '30' OR MGR = '7782';
-- 17.	顯示職稱為Clerk或Analyst且薪水不等於1000,3000,5000的員工之姓名,職稱和薪資。
SELECT ENAME,JOB,SAL FROM emp WHERE JOB IN ('Clerk','Analyst') AND SAL NOT IN ('1000','3000','5000');
-- 18.	顯示佣金比薪水的1.1倍還多的員工之姓名,薪資和佣金。
SELECT ENAME,SAL COMM FROM emp WHERE SAL*1.1 > COMM;
-- // function練習
-- 19.	顯示系統目前的日期並將表頭命名為”系統日期”。
SELECT SYSDATE()'系統日期';
-- 20.	顯示所有員工之員工編號,姓名,薪資及將薪資增加15%並且以整數表示，並將表頭命名為”New Salary”。
SELECT EMPNO,ENAME,SAL,ROUND(SAL*1.15,0)'New Salary' FROM emp;
-- 21.	接續第二題，增加一個資料項表頭命名為Increase (將New Salary 減掉 salary 的值)。
SELECT EMPNO,ENAME,SAL,ROUND(SAL*1.15,0)'New Salary',ROUND(SAL*1.15,0)-SAL'Increase' FROM emp;
-- 22.	顯示員工的姓名,進公司日期,檢討薪資的日期(指在進公司工作六個月後的第一個星期一)，將該欄命名為 REVIEW，
-- 並自訂日期格式為：Sunday, the Seventh of September。(星期幾， 幾月幾日)。
SELECT ename, hiredate,date_format(
 CASE
  WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 3 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 6 DAY
        WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 4 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 5 DAY
        WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 5 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 4 DAY
        WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 6 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 3 DAY
        WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 7 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 2 DAY
        WHEN DAYOFWEEK(hiredate + INTERVAL 6 MONTH) = 1 THEN hiredate + INTERVAL 6 MONTH + INTERVAL 1 DAY
        ELSE hiredate + INTERVAL 6 MONTH END,"%W,the %D of %M" 
 ) 'REVIEW'
FROM emp;
-- 23.	顯示每位員工的姓名，資料項(MONTHS_WORKED):計算到今天為止工作了幾個月(將月數四捨五入到整數)
SELECT ename,ROUND(DATEDIFF(NOW(),hiredate)/30,0)'MONTHS_WORKED' FROM emp;
-- 24.	顯示如下格式：<員工姓名> earns <薪水> monthly but wants <3倍的薪水>.並將表頭顯示為Dream Salaries。
SELECT CONCAT(ENAME,' earns ',SAL,' monthly but wants ',SAL*3)'Dream Salaries'FROM emp;
-- 25.	顯示所有員工之姓名和薪資，設定薪資長度為15個字元並且在左邊加上$符號，將表頭命名為SALARY。
SELECT ENAME,RPAD(CONCAT('$',SAL),15,0) FROM emp; #----RPAD/LPAD(欄位,字串長度,補上字元)
-- 26.	顯示員工之姓名,進公司日期，資料項(DAY):顯示員工被雇用的那天為星期幾，並以星期一作為一週的起始日,依星期排序。
SELECT ENAME,HIREDATE,date_format(HIREDATE,"%W")'DAY' FROM emp ORDER BY  CASE
  WHEN DAYOFWEEK(hiredate) = 2 THEN 1
        WHEN DAYOFWEEK(hiredate) = 3 THEN 2
        WHEN DAYOFWEEK(hiredate) = 4 THEN 3
        WHEN DAYOFWEEK(hiredate) = 5 THEN 4
        WHEN DAYOFWEEK(hiredate) = 6 THEN 5
		WHEN DAYOFWEEK(hiredate) = 7 THEN 6
        WHEN DAYOFWEEK(hiredate) = 1 THEN 7
        END;
-- 27.	顯示員工的姓名和名為COMM的欄位:顯示佣金額，如果該員工沒有賺取佣金則顯示"No Commission."
SELECT ENAME, IF (IF (COMM IS NULL,"No Commission.",COMM) = 0 , "No Commission.",COMM) FROM emp;
-- 28.	顯示資料項命名為 EMPLOYEE_AND_THEIR_SALARIES 的資料來顯示所有員工之名字和薪資，且用星號來表示他們的薪資，
-- 每一個星號表示100元，並以薪資由高到低來顯示。
SELECT CONCAT(ENAME,REPEAT('*', ROUND(SAL/100)))'EMPLOYEE_AND_THEIR_SALARIES' FROM emp;
-- // group練習
-- 29.	顯示所有員工的最高、最低、總和及平均薪資，依序將表頭命名為 Maximum, Minimum, Sum 和 Average，請將結果顯示為四捨五入的整數。
SELECT ROUND(MAX(SAL))'Maximum',ROUND(MIN(SAL))'Minimum',ROUND(SUM(SAL))'Sum',ROUND(AVG(SAL))'Average' FROM emp;
-- 30.	顯示每種職稱的最低、最高、總和及平均薪水。
SELECT JOB,ROUND(MAX(SAL))'Maximum',ROUND(MIN(SAL))'Minimum',ROUND(SUM(SAL))'Sum',ROUND(AVG(SAL))'Average' FROM emp GROUP BY JOB;
-- 31.	顯示每種職稱的人數。
SELECT JOB,COUNT(JOB) FROM emp GROUP BY JOB;
-- 32.	顯示資料項命名為Number of Managers來表示擔任主管的人數。
SELECT COUNT(DISTINCT MGR)'Number of Managers' FROM emp; 
-- 33.	顯示資料項命名為DIFFERENCE的資料來表示公司中最高和最低薪水間的差額。
SELECT MAX(SAL)-MIN(SAL)'DIFFERENCE' FROM emp;
-- 34.	顯示每位主管的員工編號及該主管下屬員工最低的薪資，排除沒有主管和下屬員工最低薪資少於1000的主管，
-- 並以下屬員工最低薪資作降冪排列。
SELECT MGR,MIN(SAL) FROM emp WHERE SAL > 1000 AND MGR IS NOT NULL GROUP BY MGR;

-- 35.	顯示在1980,1981,1982,1983年進公司的員工數量，並給該資料項一個合適的名稱。
SELECT COUNT(HIREDATE) FROM emp WHERE hiredate BETWEEN "1980-01-01" AND "1983-12-31";
-- // join練習
-- 36.	顯示所有員工之姓名,所屬部門編號,部門名稱及部門所在地點。
SELECT e.ename,e.deptno,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno = d.deptno;
SELECT e.ename,e.deptno,d.dname,d.loc FROM emp e, dept d WHERE e.deptno = d.deptno; 
-- 37.	顯示所有有賺取佣金的員工之姓名,佣金金額,部門名稱及部門所在地點。
SELECT e.ename, e.comm, d.dname, d.loc FROM emp e, dept d WHERE e.deptno = d.deptno AND e.comm IS NOT NULL AND e.comm != 0; 
-- 38.	顯示姓名中包含有”A”的員工之姓名及部門名稱。
SELECT e.ename,d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE ename LIKE "%A%";
-- 39.	顯示所有在”DALLAS”工作的員工之姓名,職稱,部門編號及部門名稱
SELECT e.ename,e.job,d.deptno,d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE d.loc = "DALLAS" ;
-- 40.	顯示出表頭名為: Employee, Emp#, Manager, Mgr#，分別表示所有員工之姓名,員工編號,主管姓字, 主管的員工編號。
SELECT e.ename'Employee',e.empno'Emp#',m.ename'Manager',m.empno'Mgr#' FROM emp e,emp m WHERE e.MGR = m.empno;
-- 41.	顯示出SALGRADE資料表的結構，並建立一查詢顯示所有員工之姓名,職稱,部門名稱,薪資及薪資等級。
SELECT e.ename,e.job,d.dname,e.salary,s.grade FROM emp e ,dept d ,salgrade s WHERE e.deptno = d.dpptno;
-- 42.	顯示出表頭名為: Employee, Emp Hiredate, Manager, Mgr Hiredate的資料項，
-- 來顯示所有比他的主管還要早進公司的員工之姓名,進公司日期和主管之姓名及進公司日期。
SELECT e.ename'Employee',e.hiredate'Emp Hiredate',m.ename'Manager',m.hiredate'Mgr Hiredate' FROM emp e JOIN emp m ON e.MGR = m.empno 
WHERE e.hiredate < m.hiredate;
-- 43.	顯示出表頭名為: dname, loc, Number of People, Salary的資料來顯示所有部門之部門名稱,
-- 部門所在地點,部門員工數量及部門員工的平均薪資，平均薪資四捨五入取到小數第二位。
SELECT d.dname'dname',d.loc'loc',COUNT(e.empno)'Number of People',ROUND(AVG(e.sal))'Salary' FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno GROUP BY d.deptno; 
-- // subquery練習
-- 44.	顯示和Blake同部門的所有員工之姓名和進公司日期。
SELECT ename,hiredate FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'Blake');
-- 45.	顯示所有在Blake之後進公司的員工之姓名及進公司日期。
SELECT ename,hiredate FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'Blake');
-- 46.	顯示薪資比公司平均薪資高的所有員工之員工編號,姓名和薪資，並依薪資由高到低排列。
SELECT empno,ename,sal FROM emp WHERE sal > (SELECT AVG(sal) FROM EMP) ORDER BY SAL DESC;
-- 47.	顯示和姓名中包含 T 的人再相同部門工作的所有員工之員工編號和姓名。
SELECT empno,ename FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE "%T%" );
-- 48.	顯示在Dallas工作的所有員工之姓名, 部門編號和職稱。
SELECT e.ename, d.deptno, e.job FROM emp e,dept d where e.deptno = d.deptno AND d.loc = 'Dallas'; 
-- 49.	顯示直屬於”King”的員工之姓名和薪資。
SELECT ename, sal FROM emp WHERE mgr = (SELECT empno FROM emp WHERE ename = 'King');
-- 50.	顯示銷售部門”Sales” 所有員工之部門編號,姓名和職稱。
SELECT e.deptno, e.ename, e.job FROM emp e, dept d WHERE e.deptno = d.deptno AND d.dname='Sales';
-- 51.	顯示薪資比公司平均薪資還要高且和名字中有 T 的人在相同部門上班的所有員工之員工編號,姓名和薪資。
SELECT empno, ename, sal FROM emp WHERE deptno in (SELECT deptno FROM emp 
													WHERE ename LIKE "%T%")
								  AND sal > (SELECT AVG(sal) FROM emp);
-- 52.	顯示和有賺取佣金的員工之部門編號和薪資都相同的員工之姓名,部門編號和薪資。
SELECT ename, deptno, sal FROM emp WHERE deptno IN (SELECT deptno FROM emp 
													WHERE comm IS NOT NULL
													AND comm != 0)
								   AND sal IN (SELECT sal FROM emp 
													WHERE comm IS NOT NULL
													AND comm != 0);
-- 53.	顯示和在Dallas工作的員工之薪資和佣金都相同的員工之姓名,部門編號和薪資。
SELECT e.ename, e.deptno,e.sal FROM emp e
                                 WHERE e.sal IN (SELECT e.sal FROM emp e JOIN dept d 
								                 ON e.deptno = d.deptno  
												 WHERE d.loc = 'Dallas')
								   AND IFNULL(e.comm,0) IN (SELECT IFNULL(e.comm,0) FROM emp e JOIN dept d 
												  ON e.deptno = d.deptno  
												  WHERE d.loc = 'Dallas');
-- 54.	顯示薪資和佣金都和Scott相同的所有員工之姓名,進公司日期和薪資。(不要在結果中顯示Scott的資料)
SELECT ename, hiredate, sal FROM emp WHERE sal = (SELECT sal FROM emp WHERE ename = 'Scott')
                                     AND IFNULL(comm,0) IN (SELECT IFNULL(comm,0) FROM emp);
-- 55.	顯示薪資比所有職稱是”Clerk”還高的員工之姓名,進公司日期和薪資，並將結果依薪資由高至低顯示。
SELECT ename, hiredate, sal FROM emp WHERE sal < ANY(SELECT sal FROM emp WHERE job = "Clerk")
ORDER BY sal DESC;