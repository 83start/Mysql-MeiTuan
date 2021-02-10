/*
用户权限
   1.用户可以有用户表的所有权限
   2.用户可以修改订单表中订单状态的权限
*/
#创建用户
CREATE USER 'mt4'@'localhost' IDENTIFIED BY'1234';
ALTER USER 'mt4'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
#创建角色并赋予权限
CREATE role cus;
GRANT ALL PRIVILEGES ON `customer`.* TO cus; 
GRANT UPDATE(state) ON takeaway.`orders` TO cus;
#将角色赋给用户
GRANT cus TO 'mt4'@'localhost' ;

/*
 配送员权限
    1.配送员可以有配送员表的所有权限
    2.配送员可以修改订单表中订单状态的权限
*/
#创建配送员
CREATE USER 'rider1'@'localhost' IDENTIFIED BY'1234';
ALTER USER 'rider1'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
#创建角色并赋予权限
CREATE role rid;
GRANT ALL PRIVILEGES ON `rider`.* TO rid; 
GRANT UPDATE(state) ON takeaway.`orders` TO rid;
#将角色赋给配送员
GRANT rid TO 'rider1'@'localhost';

/*
 商家权限
    1.商家可以有商家表的所有权限
    2.商家可以有菜品表的所有权限
*/
#创建商家
CREATE USER 'bus1'@'localhost' IDENTIFIED BY'1234';
ALTER USER 'bus1'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
#创建角色并赋予权限
CREATE role bus;
GRANT ALL PRIVILEGES ON foods.* TO bus; 
GRANT ALL PRIVILEGES ON business.* TO bus; 
#将角色赋给商家
GRANT bus TO 'bus1'@'localhost';



