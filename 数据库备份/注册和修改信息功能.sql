-- 注册，修改，查看信息
#注册用户信息
DELIMITER $$
CREATE PROCEDURE addCustomer(IN cusid INT(11),IN areaname VARCHAR(20),cusname VARCHAR(20),cusphone CHAR(12),cusaddress VARCHAR(256),cusidcard CHAR(18))
BEGIN
INSERT INTO customer VALUES(cusid,areaname,cusname,cusphone,cusaddress,cusidcard);
END $$
DELIMITER ;
CALL addCustomer(19,'南通','成辰就','13545788941','南通市如皋市白蒲镇','320589825402035401');

#客户信息修改
DELIMITER $$
CREATE PROCEDURE updateCustomer(IN up_cusid INT,IN up_areaname VARCHAR(10),IN up_cusname VARCHAR(10),IN up_cusphone VARCHAR(12),IN up_cusaddress VARCHAR(256),IN up_cusidcard CHAR(18))
BEGIN
	UPDATE customer SET areaname=up_areaname,cusname=up_cusname,cusPhone=up_cusphone,cusAddress=up_cusAddress,cusIdCard=up_cusIdCard WHERE cusid=up_cusid;
END $$
DELIMITER ;
CALL updateCustomer(17,'南京','王虎','15678414568','南京市江宁区江宁大学城','330252198506035263');

#查看用户信息
DELIMITER $$
CREATE PROCEDURE cus_information(IN up_cusid INT)
BEGIN
	DECLARE cus_name CHAR(10);
	DECLARE cus_phone CHAR(20);
	DECLARE cus_address VARCHAR(256);
	DECLARE cus_Idcard CHAR(20);
	SET cus_name=(SELECT cusName FROM customer WHERE cusID=up_cusid);
	SET cus_phone=(SELECT cusphone FROM customer WHERE cusID=up_cusid);
	SET cus_address=(SELECT cusaddress FROM customer WHERE cusID=up_cusid);
	SET cus_Idcard=(SELECT cusIdcard FROM customer WHERE cusID=up_cusid);
	DROP TABLE IF EXISTS cusinformation;
	CREATE TABLE cusinformation(NAME CHAR(10),phone CHAR(20),address VARCHAR(256),idcard CHAR(20));
	INSERT INTO cusinformation VALUES(cus_name,cus_phone,cus_address,cus_idcard);
	SELECT * FROM cusinformation;
	
END $$
DELIMITER ;
CALL cus_information(2);

#注册商家信息
DELIMITER $$
CREATE PROCEDURE addBusiness(IN busiid INT(11),IN areaname VARCHAR(20),businame VARCHAR(20),busiphone CHAR(12),busiaddress VARCHAR(256),busibossname VARCHAR(10),busibossidcard CHAR(18))
BEGIN
INSERT INTO business VALUES(busiid,areaname,businame,busiphone,busiaddress,busibossname,busibossidcard);
END $$
DELIMITER ;
CALL addBusiness(9,'南京','云月楼','15546462122','南京市栖霞区仙林大学城','朱时茂','521653108501035201');

#商家信息修改
DELIMITER $$
CREATE PROCEDURE updateBusiness(IN up_busiid INT,IN up_areaname VARCHAR(10),IN up_businame VARCHAR(10),IN up_busiphone VARCHAR(12),IN up_busiaddress VARCHAR(10),IN up_busibossname VARCHAR(10),IN up_bossidcard CHAR(18))
BEGIN
	UPDATE business SET areaname=up_areaname,businame=up_businame,busiPhone=up_busiphone,busiAddress=up_busiAddress,busibossname=up_busibossname,busibossidcard=up_bossidcard WHERE busiid=up_busiid;
END $$
DELIMITER ;
CALL updateBusiness(1,'南通','酒香楼','15678414564','南通市长江路32号','郭京飞','310512197704056541');

#查看商家信息
DELIMITER $$
CREATE PROCEDURE busi_information(IN up_busiId INT)
BEGIN
	DECLARE busi_name CHAR(10);
	DECLARE busi_phone CHAR(20);
	DECLARE busi_address VARCHAR(256);
	DECLARE busi_bossname VARCHAR(10);
	DECLARE busi_Idcard CHAR(20);
	SET busi_name=(SELECT busiName FROM business WHERE busiID=up_busiid);
	SET busi_phone=(SELECT busiphone FROM business WHERE busiID=up_busiid);
	SET busi_address=(SELECT busiaddress FROM business WHERE busiID=up_busiid);
	SET busi_bossname=(SELECT busibossname FROM business WHERE busiID=up_busiid);
	SET busi_Idcard=(SELECT busiBossIdcard FROM business WHERE busiID=up_busiid);
	DROP TABLE IF EXISTS businformation;
	CREATE TABLE businformation(NAME CHAR(10),phone CHAR(20),address VARCHAR(256),bossname CHAR(10),idcard CHAR(20));
	INSERT INTO businformation VALUES(busi_name,busi_phone,busi_address,busi_bossname,busi_idcard);
	SELECT * FROM businformation;
	
END $$
DELIMITER ;
CALL busi_information(4);

#存储过程:菜品录入
DELIMITER $$
CREATE PROCEDURE addFoods(IN fooid INT,IN busiid INT,IN fooCategory VARCHAR(10),fooname VARCHAR(10),fooprice DOUBLE)
BEGIN
	INSERT INTO foods VALUES(fooid,busiid,foocategory,fooname,fooprice);
END $$
DELIMITER ;
CALL addFoods(21,4,'休闲食品','香瓜子',15);

#存储过程:菜品信息修改
DELIMITER $$
CREATE PROCEDURE updateFoods(IN up_fooid INT,IN up_busiid INT,IN up_fooCategory VARCHAR(10),IN up_fooname VARCHAR(10),IN up_fooprice DOUBLE)
BEGIN
	UPDATE foods SET busiid=up_busiid,fooCategory=up_fooCategory,fooName=up_fooname,fooPrice=up_fooPrice WHERE fooid=up_fooid;
END $$
DELIMITER ;
CALL updateFoods(3,1,'甜点','朱古力豆',21);

-- 历史记录
-- 触发器
#订单计算总价
DELIMITER $$
USE `takeaway`$$
CREATE TRIGGER `tri_supportProduct` BEFORE INSERT ON `orders` FOR EACH ROW
BEGIN
DECLARE tPrice DECIMAL(10,2) DEFAULT 0;
SELECT SUM(fooprice) INTO tPrice
FROM business NATURAL JOIN foods
WHERE business.busiid=new.busiid;
	SET new.totalPrice=tPrice;

IF tPrice>=10 THEN
	SET new.totalprice=tPrice-1;	
	END IF;
END $$
DELIMITER ;

#各个商家的的地区
CREATE VIEW business_area
AS
SELECT busiName,areaname
FROM business;

#各配送员的地区
CREATE VIEW rider_area
AS
SELECT ridName,areaName FROM rider;

#修改用户姓名的历史记录
DROP TABLE IF EXISTS oldCusName;
CREATE TABLE oldCusName
AS 
SELECT cusid,cusname
FROM `customer`;
TRUNCATE TABLE oldCusName;
DROP TABLE IF EXISTS newCusName;
CREATE TABLE newCusName
AS 
SELECT cusid,cusname
FROM `customer`;
TRUNCATE TABLE newCusName;
DELIMITER $
USE `takeaway`$
CREATE TRIGGER cus_modify_name
AFTER UPDATE ON `customer`
FOR EACH ROW
BEGIN
	INSERT INTO oldCusName(cusid,cusname)
	VALUES(old.cusid,old.cusname);
	INSERT INTO newCusName(cusid,cusname)
	VALUES(new.cusid,new.cusname);
END$
DELIMITER ;
UPDATE `customer`
SET cusname='孙尚香'	
WHERE cusId=7;
SELECT * FROM oldCusName;
SELECT* FROM newCusName;
