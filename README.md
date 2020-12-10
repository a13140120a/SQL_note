# SQL

* Ubuntu MySQL設置:
  ```js
  sudo apt update  #更新apt套件
  sudo apt install mysql-server  #下載
  sudo systemctl status mysql    #啟動wserver
  sudo mysql       # 進入mysql
  ```
  * 設定root密碼
  ```js
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_passwd';
  FLUSH PRIVILEGES;
  ```
  * 更改root密碼
  ```js
  mysql> SET PASSWORD = '123456';
  ```
  * 新增用戶並賦予所有權限
  ```js
  #新增用戶
  CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'newpassword';
  
  #賦予權限(grant 權限 on 資料庫對象.* to '用戶'@'ip地址' identified by '密碼'



原文網址：https://kknews.cc/code/9ngvaz8.html)
  GRANT ALL PRIVILEGES ON *.* TO 'administrator'@'localhost' IDENTIFIED BY 'your_passwd';
  ```
  

1. Primary Key & Foreign Key
  * Primary Key: 
    * 唯一且不重複
    * 不一定每個表格都要有
    * 資料量大時透過Primary Key 查詢會較快
  * Foreign Key:  
    * 參考另一個表格的Primary Key
    * 定義Foreign Key的表格稱為Depent 或Child表格 
    * 被參考(定義Primary Key)的表格則稱為Referenced 或Parent表格
    
2. Character Set & Collation
  * Character Set:字元集(編碼)(ex:utf-8、big5...)
  * Collation: 一個字元集，所有大小排序規則謂之Collation
    * case sensitive(cs,大小寫區分)
    * case insensitive(ci,大小寫不區分)
    * 中文無法排序  
3. 資料型態:  
  * 整數:
    * UNSIGNED:無負數
    * ZEROFILL:位數不足以0補足

    |型態|大小|length|unsigned|
    | --- | --- | --- | --- |
    |TINYINT|1位元組|(-128~127)|(0，255)|
    |SMALLINT|2位元組|(-32,768~32,767)|(0~65,535)|
    |MEDIUMINT|3位元組|(-8,388,608~8,388,607)|(0~16,777,215)|
    |INT或INTEGER|4位元組|(-2,147,483,648~2,147,483,647)|(0~4,294,967,295)|
    |BIGINT|8位元組|(-9,233,372,036,854,775,808~9,223,372,036,854,775,807)|(0~18,446,744,073,709,551,615)|

  * 浮點數: 
  
    |型態|大小|length|
    | --- | --- | --- |
    |FLOAT|4 BYTES| -3.4E+38~3.4E+38 |
    |DOUBLE|8 BYTES| -1.79E+308~1.79E+308 |  
    * DECIMAL(length,scale) :固定小數位數，length為總長度，整數+小數位數，不含小數點，預設長度為10 ;scale為小數位數，預設長度為0。

  *  字串型態: 
  
   | 型態|大小 | 用途|
   | --- | --- | --- |
   |CHAR	|0-255位元組	|固定長字串(較快)|
   |VARCHAR	|0-65535 位元組	|變長字串|
   |TINYBLOB	|0-255位元組|	不超過 255 個字元的二進位制字串|
   |TINYTEXT	|0-255位元組	|短文字字串|
   |BLOB	|0-65 535位元組	|二進位制形式的長文字資料|
   |TEXT	|0-65 535位元組	|長文字資料|
   |MEDIUMBLOB|	0-16,777,215位元組	|二進位制形式的中等長度文字資料|
   |MEDIUMTEXT|	0-16,777,215位元組	|中等長度文字資料|
   |LONGBLOB	|0-4 294,967,295位元組	|二進位制形式的極大文字資料|
   |LONGTEXT	|0-4 294,967,295位元組	|極大文字資料|

  * 日期與時間型態: 
  
  |型態|大小(位元組)|範圍|格式|用途|
  | --- | --- | --- | --- | --- |
  |DATE|	3|	1000-01-01/9999-12-31|YYYY-MM-DD|日期值|
  |TIME|	3	|'-838:59:59'/'838:59:59'|HH:MM:SS|	時間值或持續時間|
  |YEAR|	1	|1901/2155|YYYY|	年份值|
  |DATETIME|	8	|1000-01-01 00:00:00/9999-12-31 23:59:59	|YYYY-MM-DD HH:MM:SS|	混合日期和時間值|
  |TIMESTAMP|	4	|1970-01-01 00:00:00/2038-1-19 11:14:07|YYYY-MM-DD HH:MM:SS|混合日期和時間值，時間戳|

  * 語法順序:  
    * SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY




