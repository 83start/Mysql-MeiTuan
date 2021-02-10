-- 事件
-- 每隔一天向vip_customer表插入总订单数
DELIMITER $$
USE takeaway $$
CREATE PROCEDURE insert_cus_tOrders()
BEGIN
	INSERT INTO vip_customer(cusid,total_orders)
	SELECT cusid,COUNT(*) FROM orders GROUP BY cusid;
END $$
DELIMITER ;


CREATE EVENT cus_tOrders
ON SCHEDULE EVERY 1 DAY
STARTS NOW()
ENDS MAKEDATE(YEAR(NOW())+1,1)
ON COMPLETION PRESERVE
DO CALL insert_cus_tOrders;

SELECT * FROM vip_customer;

ALTER EVENT cus_tOrders DISABLE;

ALTER EVENT cus_tOrders ENABLE;

-- 每隔一天向ordernum_ridder表插入总订单数
DELIMITER $$
USE takeaway $$
CREATE PROCEDURE insert_rid_tOrders()
BEGIN
	INSERT INTO ordernum_ridder(ridid,sum_order)
	SELECT ridid,COUNT(*) FROM orders GROUP BY ridid;
END $$
DELIMITER ;


CREATE EVENT rid_tOrders
ON SCHEDULE EVERY 1 DAY
STARTS NOW()
ENDS MAKEDATE(YEAR(NOW())+1,1)
ON COMPLETION PRESERVE
DO CALL insert_rid_tOrders;

SELECT * FROM ordernum_ridder;

ALTER EVENT rid_tOrders DISABLE;

ALTER EVENT rid_tOrders ENABLE;


