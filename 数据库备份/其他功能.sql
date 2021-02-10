-- 菜单的实现功能
# 各个商家售卖的菜品名称
CREATE VIEW menuBar
AS
SELECT busiName,fooName,fooprice 
FROM business  JOIN foods;

# 按分类来查找菜品
CREATE VIEW cate_foods
AS
SELECT busiName,fooName,fooprice 
FROM business NATURAL JOIN foods
WHERE fooCategory='小吃';


-- 统计的功能
# 计算每个月每个客户的订单数量，过滤条件：时间和订单状态
CREATE VIEW cus_buy
AS
SELECT cusId '客户id',COUNT(*) '订单数量' 
FROM orders
WHERE order_time BETWEEN '2020-05-01' AND '2020-05-31' AND state IN(0,1)
GROUP BY cusid;

# 统计每个用户在每段时间内的所有订单总价
CREATE VIEW cus_buyPrice
AS
SELECT cusId '客户id',SUM(totalPrice) '订单总价' 
FROM orders
WHERE order_time BETWEEN '2020-05-01' AND '2020-05-31' AND state=0
GROUP BY cusid;

# #通过订单向用户会员等级表中插入数据
INSERT INTO vip_customer(cusId,sum_price)
SELECT cusid,SUM(totalPrice)
FROM orders
WHERE state IN(0,1)
GROUP BY cusid;

#通过总消费来计算用户的vip等级
DELIMITER $
CREATE PROCEDURE vips_customer(IN vipcusid INT)
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
END $
DELIMITER ;
CALL vips_customer(6);

#计算每个配送员每个月的订单数，过滤条件：时间和订单状态
CREATE VIEW rider_delivery
AS
SELECT ridid '配送员',COUNT(*) '月订单数' 
FROM orders WHERE order_time BETWEEN '2020-05-01' AND '2020-05-31' AND state IN(0,1) 
GROUP BY ridid;
DROP VIEW rider_delivery;
# #通过订单想送货员数量表中插入数据
INSERT INTO orderNum_ridder(ridId,sum_order)
SELECT ridId ,COUNT(*)
FROM orders
GROUP BY ridid;

#通过送单次数来评价配送员的等级
DELIMITER $
CREATE PROCEDURE ordersNum_ridder(IN order_ridid INT)
BEGIN
	DECLARE rid_order DOUBLE;
	DECLARE rider_grade CHAR(20);
	SET rid_order=(SELECT sum_order FROM `ordernum_ridder` WHERE ridid=order_ridid);
	CASE 
	WHEN rid_order<5 THEN SET rider_grade='白银员工';
	WHEN rid_order<10 AND rid_order>=5 THEN SET rider_grade='黄金员工';
	ELSE SET rider_grade='钻石员工';
	END CASE;
	
	UPDATE `ordernum_ridder` SET good_ridder=rider_grade WHERE ridId=order_ridid;
END $
DELIMITER ;
CALL ordersNum_ridder(8);

-- 地区配送员接单排行榜
CREATE VIEW rider_worknum
AS
SELECT areaname,ridid,ridname,COUNT(*) AS 配送员送单数 FROM AREA NATURAL JOIN rider NATURAL JOIN orders GROUP BY ridid ORDER BY 配送员送单数 DESC;





