/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 8.0.17 : Database - takeaway
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`takeaway` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `takeaway`;

/*Table structure for table `area` */

DROP TABLE IF EXISTS `area`;

CREATE TABLE `area` (
  `areaName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区',
  PRIMARY KEY (`areaName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `area` */

insert  into `area`(`areaName`) values ('南京'),('南通'),('徐州'),('无锡');

/*Table structure for table `business` */

DROP TABLE IF EXISTS `business`;

CREATE TABLE `business` (
  `busiId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商家ID',
  `areaName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地区',
  `busiName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店名',
  `busiPhone` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `busiAddress` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `busiBossName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '老板姓名',
  `busiBossIdCard` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '老板身份证',
  PRIMARY KEY (`busiId`),
  UNIQUE KEY `busi_busiIdCard_inx` (`busiBossIdCard`),
  UNIQUE KEY `busi_busiIdPhone_inx` (`busiPhone`),
  KEY `busi_areaName_fk` (`areaName`),
  CONSTRAINT `busi_areaName_fk` FOREIGN KEY (`areaName`) REFERENCES `area` (`areaName`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `business` */

insert  into `business`(`busiId`,`areaName`,`busiName`,`busiPhone`,`busiAddress`,`busiBossName`,`busiBossIdCard`) values (1,'南通','酒香楼','15678414564','南通市长江路32号','郭京飞','310512197704056541'),(2,'南通','阿福砂锅','15175461138','南通 崇川区 南大街八仙城西门包福记隔壁','仇铁牛','320124190002033018'),(3,'南京','阿辉好宴世家','15175461132','鼓楼区湖南路狮子桥2号湖南路步行街内(近湖北路)','周大树','360124190002035012'),(4,'南京','南京大排档','15175461136','鼓楼区湖南路狮子桥2号(湖北路口)','谢大海','320124190502035016'),(5,'徐州','徐州饭店','15175461134','江苏省徐州市淮海东路201-43','程孝先','320124190002035014'),(6,'无锡','好家快捷酒店','15175461133','无锡市太湖大道旁塘南路98号','曹好看','320124190002035093'),(7,'无锡','莫泰连锁旅店','15175461135','无锡崇安区北大街1号A座','刘法','320124190002035055'),(8,'无锡','如家快捷酒店','15175461137','无锡市五爱路81号','马连良','320124190002035057'),(9,'南京','云月楼','15546462122','南京市栖霞区仙林大学城','朱时茂','521653108501035201');

/*Table structure for table `businformation` */

DROP TABLE IF EXISTS `businformation`;

CREATE TABLE `businformation` (
  `NAME` char(10) DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `bossname` char(10) DEFAULT NULL,
  `idcard` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `businformation` */

insert  into `businformation`(`NAME`,`phone`,`address`,`bossname`,`idcard`) values ('南京大排档','15175461136','鼓楼区湖南路狮子桥2号(湖北路口)','谢大海','320124190502035016');

/*Table structure for table `cusinformation` */

DROP TABLE IF EXISTS `cusinformation`;

CREATE TABLE `cusinformation` (
  `NAME` char(10) DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `idcard` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `cusinformation` */

insert  into `cusinformation`(`NAME`,`phone`,`address`,`idcard`) values ('张石山','13378446989','秦淮区 大行宫科巷菜场西门','320646199901025015');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `cusId` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `areaName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地区',
  `cusName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  `cusPhone` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户电话',
  `cusAddress` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户住址',
  `cusIdCard` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号码',
  PRIMARY KEY (`cusId`),
  UNIQUE KEY `cus_cusIdCard_inx` (`cusIdCard`),
  UNIQUE KEY `cus_cusIdPhoen_inx` (`cusPhone`),
  KEY `cus_areaName_fk` (`areaName`),
  CONSTRAINT `cus_areaName_fk` FOREIGN KEY (`areaName`) REFERENCES `area` (`areaName`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`cusId`,`areaName`,`cusName`,`cusPhone`,`cusAddress`,`cusIdCard`) values (1,'南京','赵大华','13378446985','秦淮区 大行宫新世纪广场东门对面科巷新寓二栋103室','320646199901025012'),(2,'南京','张石山','13378446989','秦淮区 大行宫科巷菜场西门','320646199901025015'),(3,'南通','王子久','13378446981','南通市 如皋市 中山南路','320646199901025011'),(4,'无锡','张成基','13378446983','无锡市环湖蠡园','320646199901025013'),(5,'无锡','孙天民','13378446986','无锡市站北路98号','320646199901025016'),(6,'徐州','国庆','13378446987','徐州市新城区昆仑大道1号','320646199901025014'),(7,'徐州','蔡德霖','13378446973','徐州新城区大龙湖附近','320646199901025017'),(19,'南通','成辰就','13545788941','南通市如皋市白蒲镇','320589825402035401');

/*Table structure for table `foods` */

DROP TABLE IF EXISTS `foods`;

CREATE TABLE `foods` (
  `fooId` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
  `busiId` int(11) DEFAULT NULL COMMENT '商家ID（商家表外键）',
  `fooCategory` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品类别（类别表外键）',
  `fooName` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品名称',
  `fooPrice` double NOT NULL COMMENT '菜品价格',
  PRIMARY KEY (`fooId`),
  KEY `foo_busiId_fk` (`busiId`),
  CONSTRAINT `foo_busiId_fk` FOREIGN KEY (`busiId`) REFERENCES `business` (`busiId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `foods` */

insert  into `foods`(`fooId`,`busiId`,`fooCategory`,`fooName`,`fooPrice`) values (1,1,'小吃','牛肉锅贴',18),(2,1,'主食','鸭血粉丝',20),(3,1,'甜点','朱古力豆',21),(4,1,'饮料','酸梅汤',5),(5,2,'小吃','煮干丝',12),(6,2,'主食','小笼包',10),(7,2,'甜点','豆腐脑',6),(8,2,'饮料','可乐',5),(9,3,'小吃','状元豆',19),(10,3,'主食','葱油饼',20),(11,3,'甜点','草莓果仁酸奶',12),(12,3,'饮料','桂花糖芋苗',15),(13,4,'小吃','姜母鸭',38),(14,4,'主食','花卷',10),(15,4,'甜点','冰冻葡萄',12),(16,4,'饮料','番茄芒果汁',9),(17,5,'小吃','五香卷',8),(18,5,'主食','肉三鲜馄饨',20),(19,5,'甜点','巧克力蛋糕',19),(20,5,'饮料','鲜榨粒粒橙',10),(21,4,'休闲食品','香瓜子',15);

/*Table structure for table `foodscategory` */

DROP TABLE IF EXISTS `foodscategory`;

CREATE TABLE `foodscategory` (
  `fooCategory` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品类型',
  PRIMARY KEY (`fooCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `foodscategory` */

insert  into `foodscategory`(`fooCategory`) values ('主食'),('休闲食品'),('小吃'),('甜品'),('饮料');

/*Table structure for table `newcusname` */

DROP TABLE IF EXISTS `newcusname`;

CREATE TABLE `newcusname` (
  `cusid` int(11) NOT NULL DEFAULT '0',
  `cusname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `newcusname` */

insert  into `newcusname`(`cusid`,`cusname`) values (6,'国庆');

/*Table structure for table `oldcusname` */

DROP TABLE IF EXISTS `oldcusname`;

CREATE TABLE `oldcusname` (
  `cusid` int(11) NOT NULL DEFAULT '0',
  `cusname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `oldcusname` */

insert  into `oldcusname`(`cusid`,`cusname`) values (6,'韩家伟');

/*Table structure for table `ordernum_ridder` */

DROP TABLE IF EXISTS `ordernum_ridder`;

CREATE TABLE `ordernum_ridder` (
  `ridId` int(11) DEFAULT NULL COMMENT '配送管员ID（配送员表外键）',
  `sum_order` double DEFAULT NULL COMMENT '订单数',
  `good_ridder` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '员工等级',
  KEY `num_rider_fk` (`ridId`),
  CONSTRAINT `num_rider_fk` FOREIGN KEY (`ridId`) REFERENCES `rider` (`ridId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `ordernum_ridder` */

insert  into `ordernum_ridder`(`ridId`,`sum_order`,`good_ridder`) values (1,5,NULL),(2,2,NULL),(3,2,NULL),(4,1,NULL),(5,1,NULL),(9,1,NULL),(10,1,NULL);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `cusId` int(11) NOT NULL COMMENT '用户ID(用户表外键)',
  `busiId` int(11) NOT NULL COMMENT '商家ID(商家表外键)',
  `ridId` int(11) NOT NULL COMMENT '配送员（配送员外键）',
  `totalPrice` double(10,2) DEFAULT '0.00' COMMENT '总价格',
  `order_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单时间',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '已下单0,已收货1,已退款2',
  PRIMARY KEY (`cusId`,`busiId`,`ridId`),
  KEY `ord_busiId_fk` (`busiId`),
  KEY `ord_ridId_fk` (`ridId`),
  CONSTRAINT `ord_busiId_fk` FOREIGN KEY (`busiId`) REFERENCES `business` (`busiId`),
  CONSTRAINT `ord_cusId_fk` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`),
  CONSTRAINT `ord_ridId_fk` FOREIGN KEY (`ridId`) REFERENCES `rider` (`ridId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`cusId`,`busiId`,`ridId`,`totalPrice`,`order_time`,`state`) values (1,1,1,63.00,'2020-05-30 22:43:34',0),(1,1,9,63.00,'2020-05-30 23:21:59',0),(1,1,10,63.00,'2020-05-30 23:22:52',0),(2,1,9,63.00,'2020-05-30 22:43:34',0),(2,2,2,32.00,'2020-05-30 22:43:34',0),(2,3,1,65.00,'2020-05-30 22:43:34',0),(2,5,1,56.00,'2020-05-30 23:20:36',0),(3,2,10,32.00,'2020-05-30 22:43:34',0),(3,3,3,65.00,'2020-05-30 22:43:34',0),(4,3,1,65.00,'2020-05-30 22:43:34',0),(4,4,4,83.00,'2020-05-30 22:43:34',0),(5,3,1,65.00,'2020-05-30 22:43:34',0),(5,4,2,83.00,'2020-05-30 22:43:34',0),(5,5,5,56.00,'2020-05-30 22:43:34',0),(6,5,3,56.00,'2020-05-30 22:43:34',0);

/*Table structure for table `rider` */

DROP TABLE IF EXISTS `rider`;

CREATE TABLE `rider` (
  `ridId` int(11) NOT NULL AUTO_INCREMENT COMMENT '配送员ID',
  `areaName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地区',
  `ridName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配送员姓名',
  `ridPhone` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`ridId`),
  KEY `rid_areaName_fk` (`areaName`),
  CONSTRAINT `rid_areaName_fk` FOREIGN KEY (`areaName`) REFERENCES `area` (`areaName`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `rider` */

insert  into `rider`(`ridId`,`areaName`,`ridName`,`ridPhone`) values (1,'南通','章汉夫','15124774615'),(2,'南通','宗敬先','13812577476'),(3,'南通','高尚德','13812457466'),(4,'南京','赵进喜','13885477462'),(5,'南京','谭平山','13212477467'),(6,'南京','汤绍箕','13812477463'),(7,'徐州','胡宝善','13852477465'),(8,'徐州','王子久','13852477467'),(9,'徐州','孙红雷','13817487467'),(10,'无锡','黄磊','13812459569'),(11,'无锡','黄渤','13812457411'),(12,'无锡','王迅','13816477411');

/*Table structure for table `vip_customer` */

DROP TABLE IF EXISTS `vip_customer`;

CREATE TABLE `vip_customer` (
  `cusId` int(11) DEFAULT NULL COMMENT '顾客ID（顾客表外键）',
  `sum_price` double DEFAULT NULL COMMENT '总消费额',
  `vip_name` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '会员等级',
  KEY `cus_vip_fk` (`cusId`),
  CONSTRAINT `cus_vip_fk` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `vip_customer` */

insert  into `vip_customer`(`cusId`,`sum_price`,`vip_name`) values (1,252,NULL),(2,272,NULL),(3,97,NULL),(4,148,NULL),(5,204,NULL),(6,56,'白银会员');

/* Trigger structure for table `customer` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `cus_modify_name` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `cus_modify_name` AFTER UPDATE ON `customer` FOR EACH ROW BEGIN
	INSERT INTO oldCusName(cusid,cusname)
	VALUES(old.cusid,old.cusname);
	
	INSERT INTO newCusName(cusid,cusname)
	VALUES(new.cusid,new.cusname);
	
END */$$


DELIMITER ;

/* Trigger structure for table `orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tri_supportProduct` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tri_supportProduct` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
DECLARE tPrice DECIMAL(10,2) DEFAULT 0;
SELECT SUM(fooprice) INTO tPrice
FROM business natural join foods
WHERE business.busiid=new.busiid;
	SET new.totalPrice=tPrice;
IF tPrice>=10 THEN
	SET new.totalprice=tPrice-1;	
	END IF;
END */$$


DELIMITER ;

/* Trigger structure for table `orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `calculate_sumprice` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `calculate_sumprice` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
	UPDATE vip_customer SET sum_price=sum_price+new.totalPrice where vip_customer.`cusId`=new.cusid;
END */$$


DELIMITER ;

/* Trigger structure for table `orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `calculate_sumorder` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `calculate_sumorder` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
	DECLARE tOrder INT DEFAULT 0;
	SELECT COUNT(*) INTO tOrder FROM orders GROUP BY ridid;
	UPDATE ordernum_ridder SET sum_order=sum_order+tOrder WHERE ordernum_ridder.`ridId`=new.ridid;
END */$$


DELIMITER ;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `cus_tOrders` */

/*!50106 DROP EVENT IF EXISTS `cus_tOrders`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `cus_tOrders` ON SCHEDULE EVERY 1 DAY STARTS '2020-05-29 17:09:17' ENDS '2021-01-01 00:00:00' ON COMPLETION PRESERVE DISABLE DO call insert_cus_tOrders */$$
DELIMITER ;

/* Event structure for event `rid_tOrders` */

/*!50106 DROP EVENT IF EXISTS `rid_tOrders`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `rid_tOrders` ON SCHEDULE EVERY 1 DAY STARTS '2020-05-30 23:16:32' ENDS '2021-01-01 00:00:00' ON COMPLETION PRESERVE DISABLE DO CALL insert_rid_tOrders */$$
DELIMITER ;

/* Function  structure for function  `find_businame_by_busiid` */

/*!50003 DROP FUNCTION IF EXISTS `find_businame_by_busiid` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `find_businame_by_busiid`(busid int) RETURNS varchar(20) CHARSET utf8mb4
begin
	declare v_name char(20);
	select businame into v_name from business where busiid=busid;
	return v_name;
end */$$
DELIMITER ;

/* Function  structure for function  `find_ridid_by_cusid_busiid` */

/*!50003 DROP FUNCTION IF EXISTS `find_ridid_by_cusid_busiid` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `find_ridid_by_cusid_busiid`(pcusid INT,pbusiid INT) RETURNS int(11)
BEGIN
	RETURN(SELECT ridid FROM orders WHERE cusid=pcusid AND busiid=pbusiid);
END */$$
DELIMITER ;

/* Function  structure for function  `find_ridname_by_ridid` */

/*!50003 DROP FUNCTION IF EXISTS `find_ridname_by_ridid` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `find_ridname_by_ridid`(riderid int) RETURNS char(10) CHARSET utf8mb4
begin
	declare v_ridname char(10);
	select ridname into v_ridname from rider where ridid=riderid;
	return v_ridname;
end */$$
DELIMITER ;

/* Function  structure for function  `find_state_by_id` */

/*!50003 DROP FUNCTION IF EXISTS `find_state_by_id` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `find_state_by_id`(cid int,bid int,rid int) RETURNS int(11)
begin
	declare v_state int;
	select state into v_state from orders where cusid=cid and busiid=bid and ridid=rid;
	return v_state;
end */$$
DELIMITER ;

/* Procedure structure for procedure `addBusiness` */

/*!50003 DROP PROCEDURE IF EXISTS  `addBusiness` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addBusiness`(IN busiid INT(11),IN areaname VARCHAR(20),businame VARCHAR(20),busiphone CHAR(12),busiaddress VARCHAR(256),busibossname VARCHAR(10),busibossidcard CHAR(18))
BEGIN
INSERT INTO business VALUES(busiid,areaname,businame,busiphone,busiaddress,busibossname,busibossidcard);
END */$$
DELIMITER ;

/* Procedure structure for procedure `addCustomer` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCustomer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addCustomer`(IN cusid INT(11),IN areaname VARCHAR(20),cusname VARCHAR(20),cusphone CHAR(12),cusaddress VARCHAR(256),cusidcard CHAR(18))
BEGIN
INSERT INTO customer VALUES(cusid,areaname,cusname,cusphone,cusaddress,cusidcard);
END */$$
DELIMITER ;

/* Procedure structure for procedure `addFoods` */

/*!50003 DROP PROCEDURE IF EXISTS  `addFoods` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addFoods`(IN fooid INT,IN busiid INT,IN fooCategory VARCHAR(10),fooname VARCHAR(10),fooprice DOUBLE)
BEGIN
	INSERT INTO foods VALUES(fooid,busiid,foocategory,fooname,fooprice);
END */$$
DELIMITER ;

/* Procedure structure for procedure `area_select_busid` */

/*!50003 DROP PROCEDURE IF EXISTS  `area_select_busid` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `area_select_busid`(IN `area` varCHAR(20))
BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE busi_id int;
		DECLARE bus_all CURSOR FOR
			SELECT busiid
			FROM business
			WHERE areaName=`area`;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		DROP TABLE IF EXISTS testcur;
		CREATE TABLE testcur(busId INT);
		OPEN bus_all;
		loopbusiness:LOOP
		FETCH bus_all INTO busi_id;
		IF done THEN 
			LEAVE loopbusiness;
		END IF;
		
		INSERT INTO testcur VALUES(busi_id);
		END LOOP;
		CLOSE bus_all;
		SELECT * FROM testcur;
        END */$$
DELIMITER ;

/* Procedure structure for procedure `area_select_riderid` */

/*!50003 DROP PROCEDURE IF EXISTS  `area_select_riderid` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `area_select_riderid`(IN riderArea VARCHAR(20))
BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE rider_id VARCHAR(20);
		DECLARE rider_all CURSOR FOR
			SELECT ridid
			FROM rider
			WHERE areaname=riderArea;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		DROP TABLE IF EXISTS testcur;
		CREATE TABLE testcur(riderId INT);
		OPEN rider_all;
		looprider:LOOP
		FETCH rider_all INTO rider_id;
		IF done THEN 
			LEAVE looprider;
		END IF;
		
		INSERT INTO testcur VALUES(rider_id);
		END LOOP;
		CLOSE rider_all;
		SELECT * FROM testcur;
        END */$$
DELIMITER ;

/* Procedure structure for procedure `busiid_select_foods` */

/*!50003 DROP PROCEDURE IF EXISTS  `busiid_select_foods` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `busiid_select_foods`(IN bus_id INT)
BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE food_id INT;
		DECLARE food_category VARCHAR(11);
		DECLARE food_name VARCHAR(20);
		DECLARE food_price DOUBLE;
		DECLARE food_all CURSOR FOR
			SELECT fooId,fooCategory,fooName,fooprice
			FROM foods
			WHERE busiId=bus_id;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		DROP TABLE IF EXISTS testcur;
		CREATE TABLE testcur(foodId INT,foodCategory VARCHAR(11),foodName VARCHAR(20),foodPrice DOUBLE);
		OPEN food_all;
		loopfood:LOOP
		FETCH food_all INTO food_id,food_category,food_name,food_price;
		IF done THEN 
			LEAVE loopfood;
		END IF;
		
		INSERT INTO testcur VALUES(food_id,food_category,food_name,food_price);
		END LOOP;
		CLOSE food_all;
		SELECT * FROM testcur;
        END */$$
DELIMITER ;

/* Procedure structure for procedure `busi_information` */

/*!50003 DROP PROCEDURE IF EXISTS  `busi_information` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `busi_information`(IN up_busiId INT)
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
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `cancellationOfOrder` */

/*!50003 DROP PROCEDURE IF EXISTS  `cancellationOfOrder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cancellationOfOrder`(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT)
BEGIN
	UPDATE orders SET state=2 WHERE cusid=p_cusid AND busiid=p_busiid AND ridid=p_ridid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `confirmReceipt` */

/*!50003 DROP PROCEDURE IF EXISTS  `confirmReceipt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmReceipt`(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT)
BEGIN
	UPDATE orders SET state=1 WHERE cusid=p_cusid AND busiid=p_busiid AND ridid=p_ridid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `cus_information` */

/*!50003 DROP PROCEDURE IF EXISTS  `cus_information` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cus_information`(IN up_cusid INT)
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
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `cus_order` */

/*!50003 DROP PROCEDURE IF EXISTS  `cus_order` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cus_order`(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT,IN p_state INT)
BEGIN
	 INSERT INTO orders(cusid,busiid,ridid,state)VALUES (p_cusid,p_busiid,p_ridid,p_state);
END */$$
DELIMITER ;

/* Procedure structure for procedure `fc_select_foods` */

/*!50003 DROP PROCEDURE IF EXISTS  `fc_select_foods` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `fc_select_foods`(IN foo_cate varchar(20))
BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE food_id INT;
		DECLARE food_name VARCHAR(20);
		DECLARE food_price DOUBLE;
		DECLARE food_all CURSOR FOR
			SELECT fooId,fooName,fooprice
			FROM foods
			where fooCategory=foo_cate;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		DROP TABLE IF EXISTS testcur;
		CREATE TABLE testcur(foodId INT,foodName VARCHAR(20),foodPrice DOUBLE);
		OPEN food_all;
		loopfood:LOOP
		FETCH food_all INTO food_id,food_name,food_price;
		IF done THEN 
			LEAVE loopfood;
		END IF;
		
		INSERT INTO testcur VALUES(food_id,food_name,food_price);
		END LOOP;
		CLOSE food_all;
		SELECT * FROM testcur;
        END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_cus_tOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_cus_tOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_cus_tOrders`()
begin
	insert into vip_customer(cusid,total_orders)
	select cusid,count(*) from orders group by cusid;
end */$$
DELIMITER ;

/* Procedure structure for procedure `insert_rid_tOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_rid_tOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_rid_tOrders`()
BEGIN
	INSERT INTO ordernum_ridder(ridid,sum_order)
	SELECT ridid,COUNT(*) FROM orders GROUP BY ridid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ordersNum_ridder` */

/*!50003 DROP PROCEDURE IF EXISTS  `ordersNum_ridder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ordersNum_ridder`(IN order_ridid INT)
BEGIN
	DECLARE rid_order DOUBLE;
	DECLARE rider_grade CHAR(20);
	SET rid_order=(SELECT sum_order FROM `ordernum_ridder` WHERE ridid=order_ridid);
	CASE 
	WHEN rid_order<5 THEN SET rider_grade='白银员工';
	WHEN rid_order<10 AND rid_order>=5 THEN SET rider_grade='黄金员工';
	WHEN rid_order>=10 THEN SET rider_grade='钻石员工';
	ELSE SET rider_grade='至尊员工';
	END CASE;
	
	UPDATE `ordernum_ridder` SET good_ridder=rider_grade WHERE ridId=order_ridid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `updateBusiness` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateBusiness` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBusiness`(IN up_busiid INT,IN up_areaname VARCHAR(10),IN up_businame VARCHAR(10),IN up_busiphone VARCHAR(12),IN up_busiaddress VARCHAR(10),IN up_busibossname VARCHAR(10),IN up_bossidcard CHAR(18))
BEGIN
	UPDATE business SET areaname=up_areaname,businame=up_businame,busiPhone=up_busiphone,busiAddress=up_busiAddress,busibossname=up_busibossname,busibossidcard=up_bossidcard WHERE busiid=up_busiid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `updateCustomer` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateCustomer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCustomer`(IN up_cusid INT,IN up_areaname VARCHAR(10),IN up_cusname VARCHAR(10),IN up_cusphone VARCHAR(12),IN up_cusaddress VARCHAR(256),IN up_cusidcard CHAR(18))
BEGIN
	UPDATE customer SET areaname=up_areaname,cusname=up_cusname,cusPhone=up_cusphone,cusAddress=up_cusAddress,cusIdCard=up_cusIdCard WHERE cusid=up_cusid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `updateFoods` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateFoods` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFoods`(IN up_fooid INT,IN up_busiid INT,IN up_fooCategory VARCHAR(10),IN up_fooname VARCHAR(10),IN up_fooprice DOUBLE)
BEGIN
	UPDATE foods SET busiid=up_busiid,fooCategory=up_fooCategory,fooName=up_fooname,fooPrice=up_fooPrice WHERE fooid=up_fooid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `vips_customer` */

/*!50003 DROP PROCEDURE IF EXISTS  `vips_customer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `vips_customer`(IN vipcusid INT)
BEGIN
	DECLARE cus_price DOUBLE;
	DECLARE vip_grade CHAR(20);
	SET cus_price=(SELECT sum_price FROM `vip_customer` WHERE cusid=vipcusid);
	CASE 
	WHEN cus_price<500 THEN SET vip_grade='白银会员';
	WHEN cus_price<1000 AND cus_price>=500 THEN SET vip_grade='黄金会员';
	ELSE SET vip_grade='钻石会员';
	END CASE;
	
	UPDATE vip_customer SET vip_name=vip_grade WHERE cusid=vipcusid;
END */$$
DELIMITER ;

/*Table structure for table `business_area` */

DROP TABLE IF EXISTS `business_area`;

/*!50001 DROP VIEW IF EXISTS `business_area` */;
/*!50001 DROP TABLE IF EXISTS `business_area` */;

/*!50001 CREATE TABLE  `business_area`(
 `busiName` varchar(10) ,
 `areaname` varchar(20) 
)*/;

/*Table structure for table `cate_foods` */

DROP TABLE IF EXISTS `cate_foods`;

/*!50001 DROP VIEW IF EXISTS `cate_foods` */;
/*!50001 DROP TABLE IF EXISTS `cate_foods` */;

/*!50001 CREATE TABLE  `cate_foods`(
 `busiName` varchar(10) ,
 `fooName` varchar(15) ,
 `fooprice` double 
)*/;

/*Table structure for table `cus_buy` */

DROP TABLE IF EXISTS `cus_buy`;

/*!50001 DROP VIEW IF EXISTS `cus_buy` */;
/*!50001 DROP TABLE IF EXISTS `cus_buy` */;

/*!50001 CREATE TABLE  `cus_buy`(
 `客户id` int(11) ,
 `订单数量` bigint(21) 
)*/;

/*Table structure for table `cus_buyprice` */

DROP TABLE IF EXISTS `cus_buyprice`;

/*!50001 DROP VIEW IF EXISTS `cus_buyprice` */;
/*!50001 DROP TABLE IF EXISTS `cus_buyprice` */;

/*!50001 CREATE TABLE  `cus_buyprice`(
 `客户id` int(11) ,
 `订单总价` double(19,2) 
)*/;

/*Table structure for table `menubar` */

DROP TABLE IF EXISTS `menubar`;

/*!50001 DROP VIEW IF EXISTS `menubar` */;
/*!50001 DROP TABLE IF EXISTS `menubar` */;

/*!50001 CREATE TABLE  `menubar`(
 `busiName` varchar(10) ,
 `fooName` varchar(15) ,
 `fooprice` double 
)*/;

/*Table structure for table `rider_area` */

DROP TABLE IF EXISTS `rider_area`;

/*!50001 DROP VIEW IF EXISTS `rider_area` */;
/*!50001 DROP TABLE IF EXISTS `rider_area` */;

/*!50001 CREATE TABLE  `rider_area`(
 `ridName` varchar(10) ,
 `areaName` varchar(20) 
)*/;

/*Table structure for table `rider_delivery` */

DROP TABLE IF EXISTS `rider_delivery`;

/*!50001 DROP VIEW IF EXISTS `rider_delivery` */;
/*!50001 DROP TABLE IF EXISTS `rider_delivery` */;

/*!50001 CREATE TABLE  `rider_delivery`(
 `配送员` int(11) ,
 `月订单数` bigint(21) 
)*/;

/*Table structure for table `rider_worknum` */

DROP TABLE IF EXISTS `rider_worknum`;

/*!50001 DROP VIEW IF EXISTS `rider_worknum` */;
/*!50001 DROP TABLE IF EXISTS `rider_worknum` */;

/*!50001 CREATE TABLE  `rider_worknum`(
 `areaname` varchar(20) ,
 `ridid` int(11) ,
 `ridname` varchar(10) ,
 `配送员送单数` bigint(21) 
)*/;

/*View structure for view business_area */

/*!50001 DROP TABLE IF EXISTS `business_area` */;
/*!50001 DROP VIEW IF EXISTS `business_area` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `business_area` AS select `business`.`busiName` AS `busiName`,`business`.`areaName` AS `areaname` from `business` */;

/*View structure for view cate_foods */

/*!50001 DROP TABLE IF EXISTS `cate_foods` */;
/*!50001 DROP VIEW IF EXISTS `cate_foods` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cate_foods` AS select `business`.`busiName` AS `busiName`,`foods`.`fooName` AS `fooName`,`foods`.`fooPrice` AS `fooprice` from (`business` join `foods` on((`business`.`busiId` = `foods`.`busiId`))) where (`foods`.`fooCategory` = '小吃') */;

/*View structure for view cus_buy */

/*!50001 DROP TABLE IF EXISTS `cus_buy` */;
/*!50001 DROP VIEW IF EXISTS `cus_buy` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cus_buy` AS select `orders`.`cusId` AS `客户id`,count(0) AS `订单数量` from `orders` where ((`orders`.`order_time` between '2020-05-01' and '2020-05-31') and (`orders`.`state` in (0,1))) group by `orders`.`cusId` */;

/*View structure for view cus_buyprice */

/*!50001 DROP TABLE IF EXISTS `cus_buyprice` */;
/*!50001 DROP VIEW IF EXISTS `cus_buyprice` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cus_buyprice` AS select `orders`.`cusId` AS `客户id`,sum(`orders`.`totalPrice`) AS `订单总价` from `orders` where ((`orders`.`order_time` between '2020-05-01' and '2020-05-31') and (`orders`.`state` = 0)) group by `orders`.`cusId` */;

/*View structure for view menubar */

/*!50001 DROP TABLE IF EXISTS `menubar` */;
/*!50001 DROP VIEW IF EXISTS `menubar` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menubar` AS select `business`.`busiName` AS `busiName`,`foods`.`fooName` AS `fooName`,`foods`.`fooPrice` AS `fooprice` from (`business` join `foods` on((`business`.`busiId` = `foods`.`busiId`))) */;

/*View structure for view rider_area */

/*!50001 DROP TABLE IF EXISTS `rider_area` */;
/*!50001 DROP VIEW IF EXISTS `rider_area` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rider_area` AS select `rider`.`ridName` AS `ridName`,`rider`.`areaName` AS `areaName` from `rider` */;

/*View structure for view rider_delivery */

/*!50001 DROP TABLE IF EXISTS `rider_delivery` */;
/*!50001 DROP VIEW IF EXISTS `rider_delivery` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rider_delivery` AS select `orders`.`ridId` AS `配送员`,count(0) AS `月订单数` from `orders` where ((`orders`.`order_time` between '2020-05-01' and '2020-05-31') and (`orders`.`state` in (0,1))) group by `orders`.`ridId` */;

/*View structure for view rider_worknum */

/*!50001 DROP TABLE IF EXISTS `rider_worknum` */;
/*!50001 DROP VIEW IF EXISTS `rider_worknum` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rider_worknum` AS select `area`.`areaName` AS `areaname`,`rider`.`ridId` AS `ridid`,`rider`.`ridName` AS `ridname`,count(0) AS `配送员送单数` from ((`area` join `rider` on((`area`.`areaName` = `rider`.`areaName`))) join `orders` on((`rider`.`ridId` = `orders`.`ridId`))) group by `rider`.`ridId` order by `配送员送单数` desc */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
