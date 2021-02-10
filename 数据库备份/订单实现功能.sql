-- 外卖流程:
#用户根据地区来选择商家
DELIMITER $
USE `takeaway`$
CREATE PROCEDURE area_select_busid(IN `area` VARCHAR(20))
	BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE busi_id INT;
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
        END$
DELIMITER ;
CALL area_select_busid('南通');

#用户根据商家id来查询这个商家的菜单
DELIMITER $
USE `takeaway`$
CREATE PROCEDURE busiid_select_foods(IN bus_id INT)
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
        END$
DELIMITER ;
CALL busiid_select_foods(1);

#或者用户根据菜的类别来选择菜名
DELIMITER $
USE `takeaway`$
CREATE PROCEDURE fc_select_foods(IN foo_cate VARCHAR(20))
	BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE food_id INT;
		DECLARE food_name VARCHAR(20);
		DECLARE food_price DOUBLE;
		DECLARE food_all CURSOR FOR
			SELECT fooId,fooName,fooprice
			FROM foods
			WHERE fooCategory=foo_cate;
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
        END$
DELIMITER ;
CALL fc_select_foods('小吃');

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

#客户下单：客户通过添加订单信息到数据库来提交订单
DELIMITER $$
CREATE PROCEDURE cus_order(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT,IN p_state INT)
BEGIN
	 INSERT INTO orders(cusid,busiid,ridid,state)VALUES (p_cusid,p_busiid,p_ridid,p_state);
END $$
DELIMITER ;
CALL cus_order(1,2,5,0);

#根据地区查询配送员号（派遣订单）
DELIMITER $$
USE `takeaway` $$
CREATE PROCEDURE area_select_riderid(IN riderArea VARCHAR(20))
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
        END $$
DELIMITER ;
CALL area_select_riderid('南通');

#存储函数:查询用户在某店下的订单由谁配送
SET GLOBAL log_bin_trust_function_creators=TRUE;
DELIMITER $$
CREATE FUNCTION find_ridid_by_cusid_busiid(pcusid INT,pbusiid INT) RETURNS INT
BEGIN
	RETURN(SELECT ridid FROM orders WHERE cusid=pcusid AND busiid=pbusiid);
END $$
DELIMITER ;
SELECT find_ridid_by_cusid_busiid(3,7);

#存储函数:根据订单id查询订单状态(0下单,1收货,2退款)
DELIMITER $$
USE takeaway $$
CREATE FUNCTION find_state_by_id (cid INT,bid INT,rid INT) RETURNS INT
BEGIN
	DECLARE v_state INT;
	SELECT state INTO v_state FROM orders WHERE cusid=cid AND busiid=bid AND ridid=rid;
	RETURN v_state;
END $$
DELIMITER ;

SELECT find_state_by_id(1,1,1);

#客户确认收货：客户通过修改订单状态来确认收货
DELIMITER $$
CREATE PROCEDURE confirmReceipt(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT)
BEGIN
	UPDATE orders SET state=1 WHERE cusid=p_cusid AND busiid=p_busiid AND ridid=p_ridid;
END $$
DELIMITER ;

CALL confirmReceipt(1,2,5);

#取消订单：客户通过修改订单状态来退款
DELIMITER $$
CREATE PROCEDURE cancellationOfOrder(IN p_cusid INT,IN p_busiid INT,IN p_ridid INT)
BEGIN
	UPDATE orders SET state=2 WHERE cusid=p_cusid AND busiid=p_busiid AND ridid=p_ridid;
END $$
DELIMITER ;

CALL cancellationOfOrder(1,2,5);

#存储函数:根据配送员编号查询配送员姓名
DELIMITER $$
USE takeaway $$
CREATE FUNCTION find_ridname_by_ridid(riderid INT) RETURNS CHAR(10)
BEGIN
	DECLARE v_ridname CHAR(10);
	SELECT ridname INTO v_ridname FROM rider WHERE ridid=riderid;
	RETURN v_ridname;
END $$
DELIMITER ;
SELECT find_ridname_by_ridid(1);

#存储函数:根据商家id查询商家名称
DELIMITER $$
USE takeaway $$
CREATE FUNCTION find_businame_by_busiid(busid INT) RETURNS VARCHAR(20)
BEGIN
	DECLARE v_name CHAR(20);
	SELECT businame INTO v_name FROM business WHERE busiid=busid;
	RETURN v_name;
END $$
DELIMITER ;
SELECT find_businame_by_busiid(1); 


#vip_customer表累加总消费
DELIMITER $$
USE takeaway $$
CREATE TRIGGER calculate_sumprice AFTER INSERT ON orders FOR EACH ROW
BEGIN
	UPDATE vip_customer SET sum_price=sum_price+new.totalPrice WHERE vip_customer.`cusId`=new.cusid;
END $$
DELIMITER ;

SELECT * FROM vip_customer;

INSERT INTO orders(cusid,busiid,ridid) VALUES(2,5,7);
DELETE FROM orders WHERE cusid=1 AND busiid=1 AND ridid=10;
SELECT * FROM orders;
SELECT * FROM vip_customer;

#ordernum_ridder表累加总订单
DELIMITER $$
USE takeaway $$
CREATE TRIGGER calculate_sumorder AFTER INSERT ON orders FOR EACH ROW
BEGIN
	DECLARE tOrder INT DEFAULT 0;
	SELECT COUNT(*) INTO tOrder FROM orders GROUP BY ridid;
	UPDATE ordernum_ridder SET sum_order=sum_order+tOrder WHERE ordernum_ridder.`ridId`=new.ridid;
END $$
DELIMITER ;

SELECT * FROM orders;
SELECT * FROM ordernum_ridder;

INSERT INTO orders(cusid,busiid,ridid) VALUES(3,4,10);
DELETE FROM orders WHERE cusid=3 AND busiid=4 AND ridid=10;