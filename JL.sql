SET NAMES UTF8;
DROP DATABASE IF EXISTS JL;
CREATE DATABASE JL CHARSET=UTF8;
USE JL;

#商品列表
CREATE TABLE JL_product(
  id INT PRIMARY KEY AUTO_INCREMENT, #商品id
  name VARCHAR(255),                #商品名称
  title VARCHAR(64),                #商品详情页title
  img_url VARCHAR(255),             #商品图片
  price DECIMAL(10,2),              #商品价格                    
  sale  INT                         #销量
);
INSERT INTO JL_product VALUES(1,'姜力1号洗发露','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAg5pzGugUooLK8lwIwlAM4jAU!160x160.png',128.99,13);
INSERT INTO JL_product VALUES(2,'姜力2号洗发露','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgjJ3GugUorIPL_AEwlAM4jAU!160x160.png',128.99,15);
INSERT INTO JL_product VALUES(3,'姜力3号沐浴露','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgjp3GugUohNSpvwYwlAM4jAU!160x160.png',98.99,18);
INSERT INTO JL_product VALUES(4,'姜力4号修发素','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);
INSERT INTO JL_product VALUES(5,'姜力5号生姜肥皂','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);
INSERT INTO JL_product VALUES(6,'姜力4号修发素','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);
INSERT INTO JL_product VALUES(7,'姜力6号姜护姜泡','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);
INSERT INTO JL_product VALUES(8,'姜力7号眼贴','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);
INSERT INTO JL_product VALUES(9,'姜力8号护发精华油','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.99,20);

INSERT INTO JL_product VALUES(10,'姜力8号护发精华油','正品，姜力洗发水去屑防脱发控油洗发露止痒去屑生姜洗头膏 包邮','http://127.0.0.1:3000/img/ABUIABAEGAAgvZ7GugUo8YrnowcwlAM4jAU!160x160.png',198.00,20);

#评论列表

#创建表 JL_comment 评论表
CREATE TABLE JL_comment(
  id INT PRIMARY KEY AUTO_INCREMENT, #评论id
  content VARCHAR(2000),             #评论内容
  ctime DATETIME,                    #评论时间
  nid   INT,                        #被评论商品的id
  user_name VARCHAR(32)                  #评论用户name
);
INSERT INTO JL_comment VALUES(null,'1',now(),1,'TOM1');
INSERT INTO JL_comment VALUES(null,'2',now(),1,'TOM2');
INSERT INTO JL_comment VALUES(null,'3',now(),1,'TOM3');
INSERT INTO JL_comment VALUES(null,'4',now(),1,'TOM4');
INSERT INTO JL_comment VALUES(null,'5',now(),1,'TOM5');
INSERT INTO JL_comment VALUES(null,'6',now(),1,'TOM6');
INSERT INTO JL_comment VALUES(null,'7',now(),1,'TOM7');
INSERT INTO JL_comment VALUES(null,'8',now(),1,'TOM8');
INSERT INTO JL_comment VALUES(null,'9',now(),1,'TOM9');
INSERT INTO JL_comment VALUES(null,'10',now(),1,'TOM13');
INSERT INTO JL_comment VALUES(null,'11',now(),1,'TOM41');
INSERT INTO JL_comment VALUES(null,'12',now(),1,'TOM46');
INSERT INTO JL_comment VALUES(null,'13',now(),2,'TOM54');
INSERT INTO JL_comment VALUES(null,'14',now(),2,'TOM48');
INSERT INTO JL_comment VALUES(null,'15',now(),2,'TOM565');
INSERT INTO JL_comment VALUES(null,'16',now(),2,'TOM897');
INSERT INTO JL_comment VALUES(null,'17',now(),2,'TOM79');
INSERT INTO JL_comment VALUES(null,'18',now(),2,'TOM797');
INSERT INTO JL_comment VALUES(null,'19',now(),2,'TOM7/');
INSERT INTO JL_comment VALUES(null,'20',now(),2,'TOM56');
INSERT INTO JL_comment VALUES(null,'21',now(),2,'TOM8799');
INSERT INTO JL_comment VALUES(null,'22',now(),2,'TOM231');
INSERT INTO JL_comment VALUES(null,'1',now(),1,'TOM87');
INSERT INTO JL_comment VALUES(null,'2',now(),1,'TOM98');
INSERT INTO JL_comment VALUES(null,'3',now(),1,'TOM654');
INSERT INTO JL_comment VALUES(null,'4',now(),1,'TOM98');
INSERT INTO JL_comment VALUES(null,'5',now(),1,'TOM132');
INSERT INTO JL_comment VALUES(null,'6',now(),1,'TOM8');
INSERT INTO JL_comment VALUES(null,'7',now(),1,'TOM4654');
INSERT INTO JL_comment VALUES(null,'8',now(),1,'TOM546');
INSERT INTO JL_comment VALUES(null,'9',now(),1,'TOM12');
INSERT INTO JL_comment VALUES(null,'10',now(),1,'TOM6546');
INSERT INTO JL_comment VALUES(null,'11',now(),1,'TOM849');
INSERT INTO JL_comment VALUES(null,'12',now(),1,'TOM7498');
INSERT INTO JL_comment VALUES(null,'13',now(),2,'TOM894');
INSERT INTO JL_comment VALUES(null,'14',now(),2,'TOM13');
INSERT INTO JL_comment VALUES(null,'15',now(),2,'TOM46');
INSERT INTO JL_comment VALUES(null,'16',now(),2,'TOM9879');
INSERT INTO JL_comment VALUES(null,'17',now(),2,'TOM123');
INSERT INTO JL_comment VALUES(null,'18',now(),2,'TOM798');
INSERT INTO JL_comment VALUES(null,'19',now(),2,'TOM456');
INSERT INTO JL_comment VALUES(null,'20',now(),2,'TOM132');
INSERT INTO JL_comment VALUES(null,'21',now(),2,'TOM984');
INSERT INTO JL_comment VALUES(null,'22',now(),2,'TOM1652');
INSERT INTO JL_comment VALUES(null,'1',now(),3,'UFG');
INSERT INTO JL_comment VALUES(null,'2',now(),3,'FDD');
INSERT INTO JL_comment VALUES(null,'3',now(),3,'DSS');
INSERT INTO JL_comment VALUES(null,'4',now(),3,'DSFAS');
INSERT INTO JL_comment VALUES(null,'5',now(),3,'DSAF');
INSERT INTO JL_comment VALUES(null,'6',now(),3,'DSAD');
INSERT INTO JL_comment VALUES(null,'7',now(),3,'SDAS');
INSERT INTO JL_comment VALUES(null,'8',now(),3,'SD');
INSERT INTO JL_comment VALUES(null,'9',now(),3,'YRT');
INSERT INTO JL_comment VALUES(null,'10',now(),4,'ERT');
INSERT INTO JL_comment VALUES(null,'11',now(),4,'WER');
INSERT INTO JL_comment VALUES(null,'12',now(),4,'WQE');
INSERT INTO JL_comment VALUES(null,'13',now(),4,'RWE');
INSERT INTO JL_comment VALUES(null,'14',now(),4,'RTFG');
INSERT INTO JL_comment VALUES(null,'15',now(),4,'RFGD');
INSERT INTO JL_comment VALUES(null,'16',now(),4,'RFG');
INSERT INTO JL_comment VALUES(null,'17',now(),5,'REGF');
INSERT INTO JL_comment VALUES(null,'18',now(),5,'REFG');
INSERT INTO JL_comment VALUES(null,'19',now(),5,'TGEF');
INSERT INTO JL_comment VALUES(null,'20',now(),5,'HY');
INSERT INTO JL_comment VALUES(null,'21',now(),5,'YRTHGF');
INSERT INTO JL_comment VALUES(null,'22',now(),5,'TRH');
INSERT INTO JL_comment VALUES(null,'3',now(),3,'WER');
INSERT INTO JL_comment VALUES(null,'4',now(),3,'WQE');
INSERT INTO JL_comment VALUES(null,'5',now(),3,'YH');
INSERT INTO JL_comment VALUES(null,'6',now(),3,'YH');
INSERT INTO JL_comment VALUES(null,'7',now(),3,'ERTDF');
INSERT INTO JL_comment VALUES(null,'8',now(),3,'WQEA');
INSERT INTO JL_comment VALUES(null,'9',now(),3,'REWDFS');
INSERT INTO JL_comment VALUES(null,'10',now(),6,'RFSD');
INSERT INTO JL_comment VALUES(null,'11',now(),6,'EWFD');
INSERT INTO JL_comment VALUES(null,'12',now(),6,'ERF');
INSERT INTO JL_comment VALUES(null,'13',now(),6,'ESFD');
INSERT INTO JL_comment VALUES(null,'14',now(),6,'FD');
INSERT INTO JL_comment VALUES(null,'15',now(),6,'RFSD');
INSERT INTO JL_comment VALUES(null,'16',now(),6,'RWEFS');
INSERT INTO JL_comment VALUES(null,'17',now(),7,'ERFD');
INSERT INTO JL_comment VALUES(null,'18',now(),7,'ERFG');
INSERT INTO JL_comment VALUES(null,'19',now(),7,'RFDS');
INSERT INTO JL_comment VALUES(null,'20',now(),7,'RGF');
INSERT INTO JL_comment VALUES(null,'21',now(),7,'FSD');
INSERT INTO JL_comment VALUES(null,'22',now(),7,'FSD');
INSERT INTO JL_comment VALUES(null,'3',now(),8,'FDS');
INSERT INTO JL_comment VALUES(null,'4',now(),8,'RFSD');
INSERT INTO JL_comment VALUES(null,'5',now(),8,'WE');
INSERT INTO JL_comment VALUES(null,'6',now(),8,'WESDA');
INSERT INTO JL_comment VALUES(null,'7',now(),8,'WDSA');
INSERT INTO JL_comment VALUES(null,'8',now(),8,'WADS');
INSERT INTO JL_comment VALUES(null,'9',now(),8,'EWQDSA');
INSERT INTO JL_comment VALUES(null,'10',now(),9,'DS');
INSERT INTO JL_comment VALUES(null,'11',now(),9,'REDFS');
INSERT INTO JL_comment VALUES(null,'12',now(),9,'REWSDF');
INSERT INTO JL_comment VALUES(null,'13',now(),9,'WERFSD');
INSERT INTO JL_comment VALUES(null,'14',now(),9,'ERWFDS');
INSERT INTO JL_comment VALUES(null,'15',now(),9,'FSD');
INSERT INTO JL_comment VALUES(null,'16',now(),9,'FSDA');


#用户列表
CREATE TABLE JL_user(
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  uname VARCHAR(32),#用户的ID，为用户的唯一标识，由系统自动生成
  upwd  VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),#手机号码
  wechat_name VARCHAR(128),#微信号
  user_name VARCHAR(32) #用户名，如王小明
);
/**用户信息**/
INSERT INTO JL_user VALUES
(NULL, 'dingding', md5("123456"), 'ding@qq.com', '13501234567', 'gdf', '丁伟'),
(NULL, 'dangdang', md5("123456h"), 'dang@qq.com', '13501234568', 'fsgdg', '林当'),
(NULL, 'doudou', md5("123456bn"), 'dou@qq.com', '13501234569', 'gbgfrt', '窦志强'),
(NULL, 'yaya', md5("123456fg"), 'ya@qq.com', '13501234560', 'getrgrd', '秦小雅');

#购物车:
#SELECT id,count,price,name,pid,uid
#FROM  JL_cart
#WHERE  uid = ?
CREATE TABLE JL_cart(
  id INT PRIMARY KEY AUTO_INCREMENT,#id     编号
  uid INT,                          #uid    用户编号
  pid INT,                          #pid    商品编号
  pname VARCHAR(255),               #pid    商品名称
  price DECIMAL(10,2),              #price  价格
  count INT                         #count  数量
);
INSERT INTO JL_cart VALUES(null,1,1,"姜力1号洗发露",198.99,1);
INSERT INTO JL_cart VALUES(null,1,2,"姜力2号洗发露",198.99,2);
INSERT INTO JL_cart VALUES(null,1,3,"姜力3号沐浴露",198.99,1);
INSERT INTO JL_cart VALUES(null,1,4,"姜力4号修发素",198.99,2);
INSERT INTO JL_cart VALUES(null,1,5,"姜力5号生姜肥皂",198.99,1);
INSERT INTO JL_cart VALUES(null,1,6,"姜力4号修发素",198.99,2);
INSERT INTO JL_cart VALUES(null,1,7,"姜力6号姜护姜泡",198.99,1);
INSERT INTO JL_cart VALUES(null,1,8,"姜力7号眼贴",198.99,2);
INSERT INTO JL_cart VALUES(null,1,9,"姜力8号护发精华油",198.99,1);
INSERT INTO JL_cart VALUES(null,1,10,"姜力8号护发精华油",198.99,2);


