# SQL

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
|型態|大小|範圍（有符號）|範圍（無符號）|用途|
| --- | --- | --- | --- |
TINYINT	1 位元組	(-128，127)	(0，255)	小整數值
SMALLINT	2 位元組	(-32 768，32 767)	(0，65 535)	大整數值
MEDIUMINT	3 位元組	(-8 388 608，8 388 607)	(0，16 777 215)	大整數值
INT或INTEGER	4 位元組	(-2 147 483 648，2 147 483 647)	(0，4 294 967 295)	大整數值
BIGINT	8 位元組	(-9 233 372 036 854 775 808，9 223 372 036 854 775 807)	(0，18 446 744 073 709 551 615)	極大整數值











