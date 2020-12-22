/*
SQLyog Ultimate v9.62 
MySQL - 5.5.49 : Database - hospitalnew
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hospitalnew` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hospitalnew`;

/*Table structure for table `dep` */

DROP TABLE IF EXISTS `dep`;

CREATE TABLE `dep` (
  `depId` int(11) NOT NULL AUTO_INCREMENT,
  `depCode` varchar(100) DEFAULT NULL,
  `depName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`depId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=gbk;

/*Data for the table `dep` */

insert  into `dep`(`depId`,`depCode`,`depName`) values (1,'0011','牙外科'),(2,'0012','内科'),(3,'0013','外科'),(4,'0014','妇科'),(5,'0015','儿科'),(6,'0016','心内科'),(7,'0017','呼吸科'),(8,'0018','血液科'),(9,'0019','消化科'),(10,'0020','超声科');

/*Table structure for table `dispensemedicine` */

DROP TABLE IF EXISTS `dispensemedicine`;

CREATE TABLE `dispensemedicine` (
  `bingLiId` varchar(100) NOT NULL DEFAULT '',
  `drugsId` int(11) DEFAULT NULL,
  `sendMeNoTotal` int(11) DEFAULT NULL,
  `alreadySendMe` int(11) DEFAULT NULL,
  `haveNotSendMe` int(11) DEFAULT NULL,
  `sendMeTime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bingLiId`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `dispensemedicine` */

/*Table structure for table `doctor` */

DROP TABLE IF EXISTS `doctor`;

CREATE TABLE `doctor` (
  `doctorId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '医生姓名',
  `identifierType` int(11) DEFAULT NULL COMMENT '证件类型',
  `identifier` varchar(100) DEFAULT NULL COMMENT '证件号',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机',
  `telephone` varchar(30) DEFAULT NULL COMMENT '座机',
  `gender` int(11) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birthDate` datetime DEFAULT NULL COMMENT '出生年月',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `depid` int(11) DEFAULT NULL COMMENT '科室类型id',
  `degree` int(11) DEFAULT NULL COMMENT '学历',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `createTime` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `del` int(4) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`doctorId`),
  KEY `depid` (`depid`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`depid`) REFERENCES `dep` (`depId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=gbk;

/*Data for the table `doctor` */

insert  into `doctor`(`doctorId`,`name`,`identifierType`,`identifier`,`phone`,`telephone`,`gender`,`age`,`birthDate`,`email`,`depid`,`degree`,`remark`,`createTime`,`del`) values (1,'张三',0,'440982199602102099','13432579863','7389609',1,23,'2020-12-10 22:08:58','1009727380@qq.com',1,1,'备注信息','2020-12-11',0),(2,'李四',0,'440982199602102099','13432579863','7389609',1,24,'2020-12-10 22:09:01','1009727380@qq.com',2,1,'备注信息','2020-12-11',0),(3,'王五',0,'440982199602102099','13432579863','7389609',1,25,'2020-12-10 22:09:02','1009727380@qq.com',1,1,'备注信息','2020-12-11',0),(4,'李小明',1,'440982199902303698','13423578943','7389609',0,32,'1998-06-13 00:00:00','1009727380@qq.com',4,2,'这是一个本科生！','2020-12-16',0),(5,'彭万里111',1,'440982199902301111','13423571111','7389111',1,11,'1998-06-11 00:00:00','1009721111@qq.com',5,2,'此人表现优异工作非常的积极！','2020-12-18',0),(6,'黄强辉',3,'440982199902303666','13423578966','7389123',1,32,'1998-06-13 00:00:00','1009727380@qq.com',9,3,'我是强光大家好！','2020-12-18',0),(7,'王祖蓝',3,'440982199902303690','13423578943','0668-7389654',0,12,'1998-09-09 00:00:00','1009727380@qq.com',10,2,'王祖蓝，可以可以！','2020-12-18',0);

/*Table structure for table `drugs` */

DROP TABLE IF EXISTS `drugs`;

CREATE TABLE `drugs` (
  `drugsId` varchar(100) NOT NULL DEFAULT '' COMMENT '药品表的id',
  `drugURL` varchar(100) DEFAULT NULL COMMENT '药品图片url',
  `purchasingPrice` int(11) DEFAULT NULL COMMENT '进价',
  `sellingPrice` int(11) DEFAULT NULL COMMENT '售价',
  `drugName` varchar(50) DEFAULT NULL COMMENT '药品名称',
  `drugType` int(11) DEFAULT NULL COMMENT '药品类型',
  `description` varchar(200) DEFAULT NULL COMMENT '简单描述',
  `productionDate` varchar(30) DEFAULT NULL COMMENT '生产日期',
  `expirationDate` varchar(30) DEFAULT NULL COMMENT '过期日期',
  `shelfLife` int(11) DEFAULT NULL COMMENT '保质期',
  `detail` varchar(500) DEFAULT NULL COMMENT '详细描述',
  `manufacturer` varchar(80) DEFAULT NULL COMMENT '生产厂商',
  `directions` varchar(300) DEFAULT NULL COMMENT '服用说明',
  `countpurchases` int(11) DEFAULT NULL COMMENT '总的进货量',
  `inventory` int(11) DEFAULT NULL COMMENT '剩余量或者库存量',
  `drugflag` int(11) DEFAULT '1' COMMENT '药品状态 1 销售中 2已停售',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del` int(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`drugsId`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `drugs` */

insert  into `drugs`(`drugsId`,`drugURL`,`purchasingPrice`,`sellingPrice`,`drugName`,`drugType`,`description`,`productionDate`,`expirationDate`,`shelfLife`,`detail`,`manufacturer`,`directions`,`countpurchases`,`inventory`,`drugflag`,`remark`,`del`) values ('10011','20bc6d30-a72e-433e-8d04-86e7e33521b5.jpg',18,28,'康泰克',3,'寒性感冒药','2016-08-13','2018-08-13',730,'感冒药吧','不知道','能吃就成',100,100,1,'吃吃吃',0),('10012','4c723603-8125-4f63-9210-23e23ca580c8.jpg',18,28,'感康',2,'另外一种感冒药','2015-08-20','2017-10-16',788,'另一种感冒药','不知道','不知道',100,100,1,'看着吃吧',0),('10013','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',19,29,'白加黑',3,'又一种感冒药','2015-08-20','2017-08-20',731,'挺好的吧大概','大概挺好','不知道',100,100,0,'谁知道能吃多少呢',0),('10014','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',21,32,'芬必得',4,'另又一种感冒药','2015-08-17','2017-08-17',731,'随意吧','不知道','不知道啊真的',100,100,1,'好吧',0),('10110','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',15,28,'泻立停',1,'止泻药','2016-08-20','2018-08-20',730,'居然不是感冒药了','还是不知道','猜猜看',100,100,0,'吃了就不拉',0),('10111','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',18,28,'黄连素',3,'好像是另一种止泻药','2016-08-18','2018-08-18',730,'又是止泻药','居然还是不知道','猜对了也不告诉你',100,100,1,'挺多的',0),('456789','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',9,15,'果导片',1,'泄不停，让你轻松变成纸片人','2016-08-01','2020-08-31',1491,'阿斯顿法国红酒可怜','沈阳','小黑不能吃',90,90,0,'吃了马上起死回生',0),('J171409806','f2b36a32703b4ca3828c3c918e14fc13j2.jpg',200,400,'克霉唑栓',2,'是一种很有效的药哦！','2020-12-18','2020-12-30',12,'是一种很有效的药哦！','广东长头发工厂','每天一桶一桶地吃',1000,500,1,'没有什么备注，赚到钱就可以了',0);

/*Table structure for table `feemanager` */

DROP TABLE IF EXISTS `feemanager`;

CREATE TABLE `feemanager` (
  `feeManageId` int(11) NOT NULL AUTO_INCREMENT,
  `bingLiId` varchar(100) DEFAULT NULL,
  `feeProjectId` int(100) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `feeDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`feeManageId`),
  KEY `feemanager_ibfk_1` (`bingLiId`),
  KEY `feemanager_ibfk_2` (`feeProjectId`),
  CONSTRAINT `feemanager_ibfk_1` FOREIGN KEY (`bingLiId`) REFERENCES `register` (`bingLiId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feemanager_ibfk_2` FOREIGN KEY (`feeProjectId`) REFERENCES `feeporject` (`feeProjectiId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=gbk;

/*Data for the table `feemanager` */

insert  into `feemanager`(`feeManageId`,`bingLiId`,`feeProjectId`,`fee`,`feeDate`) values (3,'1001608170941',1,0,'2016-08-17 09:41:35'),(4,'1001608170942',1,0,'2016-08-17 09:42:42'),(5,'1001608170943',1,5,'2016-08-17 18:18:04'),(6,'100160817094738',1,0,'2016-08-17 09:47:38'),(7,'100160817094739',1,0,'2016-08-17 18:18:05'),(8,'100160817101940',1,0,'2016-08-17 10:19:40'),(9,'100160819111618',1,0,'2016-08-19 11:16:18'),(10,'1001608170941',2,2000,'2016-08-23 03:45:03'),(15,'1001608170942',2,2000,'2016-08-30 08:39:50');

/*Table structure for table `feeporject` */

DROP TABLE IF EXISTS `feeporject`;

CREATE TABLE `feeporject` (
  `feeProjectiId` int(11) NOT NULL DEFAULT '0',
  `feepProjectName` varchar(100) DEFAULT NULL,
  `shouldReceiveMoney` int(11) DEFAULT NULL,
  PRIMARY KEY (`feeProjectiId`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `feeporject` */

insert  into `feeporject`(`feeProjectiId`,`feepProjectName`,`shouldReceiveMoney`) values (1,'挂号',5),(2,'住院押金',2000);

/*Table structure for table `hospitalaccount` */

DROP TABLE IF EXISTS `hospitalaccount`;

CREATE TABLE `hospitalaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bingLiId` varchar(100) DEFAULT NULL,
  `accountStatus` varchar(100) DEFAULT NULL,
  `sumAmount` int(11) DEFAULT NULL,
  `deposit` int(11) DEFAULT NULL,
  `unPaidPart` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `feeDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `meFee` int(11) DEFAULT NULL,
  `drugFee` int(11) DEFAULT NULL,
  `finishFee` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bingLiId` (`bingLiId`),
  CONSTRAINT `hospitalaccount_ibfk_1` FOREIGN KEY (`bingLiId`) REFERENCES `register` (`bingLiId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=gbk;

/*Data for the table `hospitalaccount` */

insert  into `hospitalaccount`(`id`,`bingLiId`,`accountStatus`,`sumAmount`,`deposit`,`unPaidPart`,`balance`,`feeDate`,`meFee`,`drugFee`,`finishFee`) values (1,'1001608170941','已住院',NULL,2000,NULL,NULL,'2016-08-23 03:45:03',NULL,NULL,NULL),(2,'1001608170942','已住院',NULL,2000,NULL,NULL,'2016-08-30 08:39:50',NULL,NULL,NULL);

/*Table structure for table `hospitalinformation` */

DROP TABLE IF EXISTS `hospitalinformation`;

CREATE TABLE `hospitalinformation` (
  `bingLiId` varchar(100) NOT NULL DEFAULT '',
  `carePeople` varchar(30) DEFAULT NULL,
  `bedId` varchar(40) DEFAULT NULL,
  `deposit` int(11) DEFAULT NULL,
  `illnessCondition` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`bingLiId`),
  CONSTRAINT `hospitalinformation_ibfk_1` FOREIGN KEY (`bingLiId`) REFERENCES `register` (`bingLiId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `hospitalinformation` */

insert  into `hospitalinformation`(`bingLiId`,`carePeople`,`bedId`,`deposit`,`illnessCondition`) values ('1001608170941','小红','1101',2000,'住着玩的'),('1001608170942','小红','1102',2000,'该吃药了');

/*Table structure for table `register` */

DROP TABLE IF EXISTS `register`;

CREATE TABLE `register` (
  `bingLiId` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(30) DEFAULT NULL COMMENT '登录名',
  `identifierType` varchar(100) DEFAULT NULL COMMENT '证件类型',
  `identifier` varchar(100) DEFAULT NULL COMMENT '证件号',
  `insuranceint` varchar(30) DEFAULT NULL COMMENT '社保号',
  `phone` varchar(30) DEFAULT NULL COMMENT '电话号码',
  `expenseFlag` varchar(20) DEFAULT NULL COMMENT '是否自费',
  `gender` int(11) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `profession` varchar(200) DEFAULT NULL COMMENT '职业',
  `czflag` varchar(30) DEFAULT NULL COMMENT '复诊或初诊',
  `doctorId` int(11) DEFAULT NULL COMMENT '医生id',
  `modifyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `createTime` varchar(30) DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT '1' COMMENT '状态 1已挂号 2已询医 3已出院 4已退号',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `guahaofei` double DEFAULT NULL COMMENT '挂号费',
  `del` int(4) DEFAULT '0' COMMENT '退号   或者逻辑删除',
  PRIMARY KEY (`bingLiId`),
  KEY `doctorId` (`doctorId`),
  CONSTRAINT `register_ibfk_1` FOREIGN KEY (`doctorId`) REFERENCES `doctor` (`doctorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `register` */

insert  into `register`(`bingLiId`,`name`,`identifierType`,`identifier`,`insuranceint`,`phone`,`expenseFlag`,`gender`,`age`,`profession`,`czflag`,`doctorId`,`modifyTime`,`createTime`,`status`,`remark`,`guahaofei`,`del`) values ('1001608170941','刘洋','身份证','1313131313','1111111111','138100000121','是',0,18,'学生','初诊',3,'2020-12-16 09:27:11','2020-12-02',3,'好的',11,1),('1001608170942','小黑','身份证','1231231122','131313131313','13801116638','是',0,21,'律师','初诊',2,'2020-12-16 09:27:11','2020-12-02',2,'好的',12,0),('1001608170943','邓晓伟','身份证','1234567890123','23421341243','13812345677','是',0,23,'工人','初诊',3,'2020-12-16 09:27:11','2020-12-02',1,'发帖人更好',13,0),('100160817094738','嘿嘿嘿嘿','身份证','12345678901234','12312321312','13810112345','是',0,18,'老师','初诊',2,'2020-12-16 09:27:11','2020-12-02',1,'阿斯顿撒旦',14,0),('100160817094739','asf','身份证','1234567890123','3432','12345123','是',1,23,'辅导员','初诊',1,'2020-12-16 09:27:11','2020-12-01',1,'阿斯顿发',15,0),('100160817101940','周吴郑王','身份证','23456','34567654345','232','否',1,132,'商人','复诊',3,'2020-12-16 09:27:11','2020-12-02',4,'啊发送到',16,0),('100160819111618','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-03',3,'阿斯顿111',17,0),('100160819111619','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-04',3,'阿斯顿111',17,0),('100160819111621','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-05',3,'阿斯顿111',17,0),('100160819111622','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-17 10:49:49','2020-12-06',2,'阿斯顿111',0,0),('100160819111623','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-07',3,'阿斯顿111',17,0),('100160819111624','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-08',3,'阿斯顿111',17,0),('100160819111625','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-09',3,'阿斯顿111',17,0),('100160819111626','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-12',3,'阿斯顿111',17,0),('100160819111627','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-12',3,'阿斯顿111',17,0),('100160819111628','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-12',3,'阿斯顿111',17,0),('100160819111630','李小龙','身份证','123123123','123123123','123123123','是',1,12,'白领','复诊',2,'2020-12-16 09:27:11','2020-12-12',3,'阿斯顿111',17,0),('170808960','牛了个牛','军人证','12121212','12121212','13423578943','是',1,23,'程序员','初诊',3,'2020-12-16 19:13:57','2020-12-15',1,'这个人有病！',0,0),('171540877','黄明','身份证','12121212','12121212','13423578943','是',1,23,'律师','初诊',2,'2020-12-16 19:22:37','2020-12-15',1,' 这个人的生病很严重！',0,0),('215319924','习大大4','护照','440982199902303666','446325987456326666','13423578966','否',0,60,'工人','复诊',2,'2020-12-16 19:13:57','2020-12-15',1,'这个人厉害了哦！jkljlkj;lj',0,0);

/*Table structure for table `resources` */

DROP TABLE IF EXISTS `resources`;

CREATE TABLE `resources` (
  `resId` int(11) NOT NULL AUTO_INCREMENT,
  `resname` varchar(30) DEFAULT NULL COMMENT '资源名称',
  `resurl` varchar(80) DEFAULT NULL COMMENT '资源url',
  `resparentid` int(11) DEFAULT NULL,
  `status` int(4) DEFAULT NULL COMMENT '状态',
  `del` int(4) DEFAULT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`resId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=gbk;

/*Data for the table `resources` */

insert  into `resources`(`resId`,`resname`,`resurl`,`resparentid`,`status`,`del`) values (1,'挂号信息管理','registration:index',NULL,0,0),(2,'门诊医生管理','doctor:index',NULL,0,0),(3,'药品管理','drugs:index',NULL,0,0),(4,'住院办理','hos:index',NULL,0,0),(5,'收费项目登记','hospital/charge.jsp',NULL,0,0),(6,'在院发药','hospital/dispensing.jsp',NULL,0,0),(7,'住院结算','hospital/account.jsp',NULL,0,0),(8,'月营业额统计','xxxxxx',NULL,0,0),(9,'年营业额统计','xxxxxx',NULL,0,0),(10,'用户管理','user:index',NULL,0,0),(11,'角色管理','role:index',NULL,0,0),(12,'资源管理','resource:index',NULL,0,0),(13,'密码设置','user:passRest',NULL,0,0);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT,
  `roleNum` varchar(30) DEFAULT NULL COMMENT '角色代码或者代号',
  `roleName` varchar(30) DEFAULT NULL COMMENT '角色名称',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `del` int(4) DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=gbk;

/*Data for the table `role` */

insert  into `role`(`roleId`,`roleNum`,`roleName`,`status`,`del`) values (1,'1','管理员',0,0),(7,'2','院长',0,0),(8,'3','医生',0,0),(9,'4','护士',0,0),(10,'5','科长',0,0),(11,'6','护士长',0,0),(12,'7','主任医师',0,0),(13,'8','副任医师',0,0),(14,'9','总医办公室',0,0),(15,'10','总经理',0,0),(16,'11','总主任',0,0);

/*Table structure for table `role_resources` */

DROP TABLE IF EXISTS `role_resources`;

CREATE TABLE `role_resources` (
  `resMiddleTableId` int(10) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `resId` int(11) DEFAULT NULL,
  PRIMARY KEY (`resMiddleTableId`),
  KEY `roleId` (`roleId`),
  KEY `resId` (`resId`),
  CONSTRAINT `role_resources_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`),
  CONSTRAINT `role_resources_ibfk_2` FOREIGN KEY (`resId`) REFERENCES `resources` (`resId`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=gbk;

/*Data for the table `role_resources` */

insert  into `role_resources`(`resMiddleTableId`,`roleId`,`resId`) values (27,8,3),(28,8,4),(29,8,5),(30,8,6),(34,1,1),(35,1,2),(36,1,3),(37,1,4),(38,1,5),(39,1,6),(40,1,7),(41,1,8),(42,1,9),(43,1,10),(44,1,11),(45,1,12),(46,1,13),(47,9,1),(48,10,1),(49,10,2),(50,10,3),(51,11,1),(52,11,2),(53,12,1),(54,12,2),(55,13,1),(56,13,2),(68,15,1),(69,15,2),(93,16,1),(94,16,2),(98,7,1),(99,7,2),(100,14,1),(101,14,2),(102,14,3),(103,14,10);

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `urid` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`urid`),
  KEY `userId` (`userId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userid`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=gbk;

/*Data for the table `user_role` */

insert  into `user_role`(`urid`,`userId`,`roleId`) values (13,4,1),(14,5,7),(16,6,9),(17,7,1),(18,8,8),(19,9,7);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(30) DEFAULT NULL COMMENT '登录名',
  `password` varchar(30) DEFAULT NULL COMMENT '密码',
  `realname` varchar(30) DEFAULT NULL COMMENT '真实的名字',
  `email` varchar(40) DEFAULT NULL COMMENT '邮箱',
  `status` int(4) DEFAULT '0' COMMENT '状态  禁用1  启用0',
  `del` int(4) DEFAULT '0' COMMENT '逻辑删除',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=gbk;

/*Data for the table `users` */

insert  into `users`(`userid`,`no`,`password`,`realname`,`email`,`status`,`del`,`modifytime`,`createTime`) values (4,'admin','admin','张三','1009727380@qq.com',0,0,'2020-12-10 20:46:55','2018-12-11 22:44:16'),(5,'sa','11111','李四','1009727380@qq.com',0,0,'2020-12-18 18:05:28','2020-12-20 18:05:07'),(6,'zhangsan','11111','李四','1009727380@qq.com',0,0,'2020-12-18 18:05:28','2020-12-18 18:05:21'),(7,'guanliyuan','11111','李四','1009727380@qq.com',0,0,'2020-12-18 18:05:28','2020-12-18 18:05:23'),(8,'mww','123','莫文蔚','1009727380@qq.com',0,0,'2020-12-18 20:35:40','2020-12-18 00:00:00'),(9,'hjk','222','黄俊林2','1009727380@qq.com',0,0,'2020-12-19 22:43:27','2020-12-19 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
