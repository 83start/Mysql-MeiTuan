-- 创建数据库
CREATE DATABASE takeaway;
USE takeaway;


-- 建表
#地区表
CREATE TABLE `area`(
areaName VARCHAR(20) PRIMARY KEY
)ENGINE=INNODB DEFAULT CHARSET utf8;

#用户表
CREATE TABLE customer(
cusId INT PRIMARY KEY AUTO_INCREMENT,
areaName VARCHAR(20),
cusName VARCHAR(10) NOT NULL,
cusPhone CHAR(12) NOT NULL,
cusAddress VARCHAR(256) NOT NULL,
cusIdCard CHAR(18) NOT NULL,
CONSTRAINT cus_areaName_fk FOREIGN KEY(areaName) REFERENCES `area`(areaName)
)ENGINE=INNODB DEFAULT CHARSET utf8;

#创建用户的会员等级表
CREATE TABLE vip_customer(cusId INT ,
sum_price DOUBLE,
vip_name VARCHAR(6),
CONSTRAINT cus_vip_fk FOREIGN KEY(cusid) REFERENCES customer(cusid)
);

#创建配送员的送单数量表
CREATE TABLE orderNum_ridder(
ridId INT ,
sum_order DOUBLE,
good_ridder CHAR(10),
CONSTRAINT num_rider_fk FOREIGN KEY(ridId) REFERENCES rider(ridId)
);

#商家表
CREATE TABLE business(
busiId INT PRIMARY KEY AUTO_INCREMENT,
areaName VARCHAR(20),
busiName VARCHAR(10) NOT NULL,
busiPhone CHAR(12),
busiAddress VARCHAR(256) NOT NULL,
busiBossName VARCHAR(10),
busiBossIdCard CHAR(18) NOT NULL,
CONSTRAINT busi_areaName_fk FOREIGN KEY(areaName) REFERENCES `area`(areaName)
)ENGINE=INNODB DEFAULT CHARSET utf8;

#菜品类别汇总表
CREATE TABLE foodsCategory(
fooCategory VARCHAR(10) PRIMARY KEY
)ENGINE=INNODB DEFAULT CHARSET utf8;

#菜品表
CREATE TABLE foods(
fooId INT PRIMARY KEY AUTO_INCREMENT,
busiId INT,
fooCategory VARCHAR(10),
fooName VARCHAR(15) NOT NULL,
fooPrice DOUBLE NOT NULL,
CONSTRAINT foo_busiId_fk FOREIGN KEY(busiId) REFERENCES business(busiId)
)ENGINE=INNODB DEFAULT CHARSET utf8;
 
#配送员表
CREATE TABLE rider(
ridId INT PRIMARY KEY AUTO_INCREMENT,
areaName VARCHAR(20) ,
ridName VARCHAR(10) NOT NULL,
ridPhone CHAR(12) NOT NULL,
CONSTRAINT rid_areaName_fk FOREIGN KEY(areaName) REFERENCES `area`(areaName)
)ENGINE=INNODB DEFAULT CHARSET utf8;

#订单表
CREATE TABLE orders(
cusId INT,
busiId INT,
ridId INT,
totalPrice DOUBLE(10,2) DEFAULT 0,
PRIMARY KEY(cusId,busiId,ridId),
CONSTRAINT ord_cusId_fk FOREIGN KEY(cusId) REFERENCES customer(cusId),
CONSTRAINT ord_busiId_fk FOREIGN KEY(busiId) REFERENCES business(busiId),
CONSTRAINT ord_ridId_fk FOREIGN KEY(ridId) REFERENCES rider(ridId)
)ENGINE=INNODB DEFAULT CHARSET utf8;
#增加列:下单时间
ALTER TABLE orders ADD order_time TIMESTAMP DEFAULT NOW() NOT NULL;
#增加列:订单状态
ALTER TABLE orders ADD state INT DEFAULT 0 NOT NULL COMMENT '已下单0,已收货1,已退款2';


-- 索引
CREATE UNIQUE INDEX cus_cusIdCard_inx ON customer(cusIdCard);
CREATE UNIQUE INDEX cus_cusIdPhoen_inx ON customer(cusPhone);
CREATE UNIQUE INDEX busi_busiIdPhone_inx ON business(busiPhone);
CREATE UNIQUE INDEX busi_busiIdCard_inx ON business(busiBossIdCard);


-- 插入数据
#向地区表插入数据
INSERT INTO AREA VALUES
('南通'),('南京'),('徐州'),('无锡');

#向商家表中插入数据
INSERT INTO business VALUES
(1,'南通','阿宝海鲜排档','15175461131','南通 崇川区 江苏省环城南路1号西北方向158米','王铁根','320124190702035011'),
(2,'南通','阿福砂锅','15175461138','南通 崇川区 南大街八仙城西门包福记隔壁','仇铁牛','320124190002033018'),
(3,'南京','阿辉好宴世家','15175461132','鼓楼区湖南路狮子桥2号湖南路步行街内(近湖北路)','周大树','360124190002035012'),
(4,'南京','南京大排档','15175461136','鼓楼区湖南路狮子桥2号(湖北路口)','谢大海','320124190502035016'),
(5,'徐州','徐州饭店','15175461134','江苏省徐州市淮海东路201-43','程孝先','320124190002035014'),
(6,'无锡','好家快捷酒店','15175461133','无锡市太湖大道旁塘南路98号','曹好看','320124190002035093'),
(7,'无锡','莫泰连锁旅店','15175461135','无锡崇安区北大街1号A座','刘法','320124190002035055'),
(8,'无锡','如家快捷酒店','15175461137','无锡市五爱路81号','马连良','320124190002035057');

#向用户信息表中插入数据
INSERT INTO customer VALUES
(1,'南京','赵大华','13378446985','秦淮区 大行宫新世纪广场东门对面科巷新寓二栋103室','320646199901025012'),
(2,'南京','张石山','13378446989','秦淮区 大行宫科巷菜场西门','320646199901025015'),
(3,'南通','王子久','13378446981','南通市 如皋市 中山南路','320646199901025011'),
(4,'无锡','张成基','13378446983','无锡市环湖蠡园','320646199901025013'),
(5,'无锡','孙天民','13378446986','无锡市站北路98号','320646199901025016'),
(6,'徐州','张小龙','13378446987','徐州市新城区昆仑大道1号','320646199901025014'),
(7,'徐州','蔡德霖','13378446973','徐州新城区大龙湖附近','320646199901025017');

#向菜品表中插入数据
INSERT INTO foods VALUES
(1,1,'小吃','牛肉锅贴',18),
(2,1,'主食','鸭血粉丝',20),
(3,1,'甜点','桂花糕',12),
(4,1,'饮料','酸梅汤',5),

(5,2,'小吃','煮干丝',12),
(6,2,'主食','小笼包',10),
(7,2,'甜点','豆腐脑',6),
(8,2,'饮料','可乐',5),

(9,3,'小吃','状元豆',19),
(10,3,'主食','葱油饼',20),
(11,3,'甜点','草莓果仁酸奶',12),
(12,3,'饮料','桂花糖芋苗',15),

(13,4,'小吃','姜母鸭',38),
(14,4,'主食','花卷',10),
(15,4,'甜点','冰冻葡萄',12),
(16,4,'饮料','番茄芒果汁',9),

(17,5,'小吃','五香卷',8),
(18,5,'主食','肉三鲜馄饨',20),
(19,5,'甜点','巧克力蛋糕',19),
(20,5,'饮料','鲜榨粒粒橙',10);

#菜品类别表中插入数据
INSERT INTO `foodscategory` VALUES
('小吃'),('主食'),('甜品'),('饮料'),('休闲食品');

#向配送员表中插入数据
INSERT INTO rider VALUES
(1,'南通','章汉夫','1512477461'),
(2,'南通','宗敬先','13812577476'),
(3,'南通','高尚德','13812457466'),
(4,'南京','赵进喜','13885477462'),
(5,'南京','谭平山','13212477467'),
(6,'南京','汤绍箕','13812477463'),
(7,'徐州','胡宝善','13852477465'),
(8,'徐州','王子久','13852477467'),
(9,'徐州','孙红雷','13817487467'),
(10,'无锡','黄磊','13812459569'),
(11,'无锡','黄渤','13812457411'),
(12,'无锡','王迅','13816477411');

#向订单表中插入数据
INSERT INTO orders(cusId,busiId,ridId) VALUES
(1,1,1),
(2,1,9),
(2,2,2),
(2,3,1),
(2,5,1),
(3,2,10),
(3,3,3),
(4,3,1),
(4,4,4),
(5,3,1),
(5,4,2),
(5,5,5),
(6,5,3);








