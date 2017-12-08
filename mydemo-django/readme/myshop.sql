/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.6.23-log : Database - myshop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`myshop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `myshop`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `detail` */

DROP TABLE IF EXISTS `detail`;

CREATE TABLE `detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `orderid` int(11) DEFAULT NULL COMMENT '（订单号的外键）',
  `goodsid` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` double(6,2) DEFAULT NULL,
  `num` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `detail` */

insert  into `detail`(`id`,`orderid`,`goodsid`,`name`,`price`,`num`) values (42,40,19,'小黄人充电器',676.00,1),(43,41,2,'魅蓝 RRO 7Plus',3214.00,1),(44,41,9,'魅族耳麦',345.00,1),(45,42,16,'电煲',345.00,1),(46,43,1,'魅族 RR07',2245.00,1),(47,44,2,'魅蓝 RRO 7Plus',3214.00,1),(48,45,20,'手柄',342.00,1),(49,46,3,'魅族 Note5',2435.00,1),(50,47,4,'魅蓝  E2',1213.00,1),(51,47,15,'魅蓝充电手表',656.00,1);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2017-08-30 13:52:29.883454'),(2,'auth','0001_initial','2017-08-30 13:52:30.174958'),(3,'admin','0001_initial','2017-08-30 13:52:30.231660'),(4,'admin','0002_logentry_remove_auto_add','2017-08-30 13:52:30.246945'),(5,'contenttypes','0002_remove_content_type_name','2017-08-30 13:52:30.322033'),(6,'auth','0002_alter_permission_name_max_length','2017-08-30 13:52:30.345191'),(7,'auth','0003_alter_user_email_max_length','2017-08-30 13:52:30.372851'),(8,'auth','0004_alter_user_username_opts','2017-08-30 13:52:30.386416'),(9,'auth','0005_alter_user_last_login_null','2017-08-30 13:52:30.426200'),(10,'auth','0006_require_contenttypes_0002','2017-08-30 13:52:30.428827'),(11,'auth','0007_alter_validators_add_error_messages','2017-08-30 13:52:30.442755'),(12,'auth','0008_alter_user_username_max_length','2017-08-30 13:52:30.476046'),(13,'sessions','0001_initial','2017-08-30 13:52:30.509329');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('5rxgd9e6nme3drcvse4qzjk9y7gatt4w','YjYxMTRmZjRjODg3YTJlNGQ4ODQyNmU4NTczZDBkMmFhZjdjNGU3ZDp7InZlcmlmeWNvZGUiOiIxNFJaIiwidmlwdXNlciI6eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJhZGRyZXNzIjoiXHU1MzE3XHU0ZWFjXHU1ZTAyXHU2NjBjXHU1ZTczXHU1MzNhIiwiY29kZSI6IjEwMDEwMCIsInBob25lIjoiMTIzNDU2Nzg5OSIsImVtYWlsIjoiMTIzNDVAcXEuY29tIn0sInNob3BsaXN0Ijp7fSwiYWRtaW51c2VyIjoiXHU3YmExXHU3NDA2XHU1NDU4In0=','2017-09-18 01:21:51.995948'),('hhecn4wcobno4lozvv7c90tp71ixnhat','NWE5MjA1N2VjOTIxN2RlOTAxZTU2MjRkZTk2OGZhNDRhYmIyNmNiYzp7InZlcmlmeWNvZGUiOiJLVzFOIiwic2hvcGxpc3QiOnsiMiI6eyJpZCI6MiwiZ29vZHMiOiJcdTliNDVcdTg0ZGQgUlJPIDdQbHVzIiwiY29tcGFueSI6Ilx1NTMxN1x1NGVhY1x1NWUwMlx1NjYwY1x1NWU3MyIsImRlc2NyIjoiICAgICAgICAgICAgICAgICAgICBcdTczYjBcdThkMjdcdTkwMWZcdTUzZDEsXHU1M2NjXHU3N2IzXHU1OTgyXHU1YzBmXHU3YTk3IiwicHJpY2UiOjMyMTQuMCwicGljbmFtZSI6IjE1MDQxNDkzMjcuMTM3ODA1NS5qcGciLCJzdG9yZSI6MjM0LCJudW0iOjAsImNsaWNrbnVtIjoyNiwiYWRkdGltZSI6MTUwNDE0OTMyNywibSI6Mn19LCJhZG1pbnVzZXIiOiJcdTdiYTFcdTc0MDZcdTU0NTgifQ==','2017-09-18 02:54:30.756982'),('x3qziwp1o7dqowwwoehqdh9l4zwchx1p','M2YzOWEyYmY3YTE3YjYyZjExZTk3ODllODM1Mjg4OTc4NDJlOWFhMzp7InZlcmlmeWNvZGUiOiI4OVQ1IiwiYWRtaW51c2VyIjoiXHU3YmExXHU3NDA2XHU1NDU4Iiwic2hvcGxpc3QiOnt9LCJ2aXB1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6ImFkbWluIiwibmFtZSI6Ilx1NzM4YiIsImFkZHJlc3MiOiJcdTUzMTdcdTRlYWNcdTVlMDJcdTY2MGNcdTVlNzNcdTUzM2EiLCJjb2RlIjoiMTAwMTAwIiwicGhvbmUiOiIzNjg0NTY1NjQiLCJlbWFpbCI6IjEyMzQ1QHFxLmNvbSIsInNleCI6MH19','2017-09-18 10:35:16.027027'),('y8vxv6y9fc9vh6bz8litu27w4mcflp07','Y2E0MjAwMGRlNTMyYThiNDc5NGVhZDM5MzViYjViYzQyOGNhNmRiMjp7InZlcmlmeWNvZGUiOiJHRklDIiwidmlwdXNlciI6eyJpZCI6MTMsInVzZXJuYW1lIjoiMTIzMTIzIiwibmFtZSI6IjEyMyIsImFkZHJlc3MiOiIxMjMxMjMiLCJjb2RlIjoiMTIzMTIzIiwicGhvbmUiOiIxMjMxMjMiLCJlbWFpbCI6IjEyM0BuaWFiLmNvbSJ9LCJzaG9wbGlzdCI6e319','2017-09-18 00:13:20.417129');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `typeid` int(11) DEFAULT NULL COMMENT 'type表的id外键',
  `goods` varchar(32) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `descr` text,
  `price` double(6,2) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1' COMMENT '1：新添加、2：在售、3：下架',
  `store` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `clicknum` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_goods` (`typeid`),
  CONSTRAINT `FK_goods` FOREIGN KEY (`typeid`) REFERENCES `type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `goods` */

insert  into `goods`(`id`,`typeid`,`goods`,`company`,`descr`,`price`,`picname`,`state`,`store`,`num`,`clicknum`,`addtime`) values (1,2,'魅族 RR07','北京市大兴区','                    现货速发,双瞳如小窗,佳景观历历',2245.00,'1504147511.1643884.jpg',2,234,0,9,1504147511),(2,2,'魅蓝 RRO 7Plus','北京市昌平','                    现货速发,双瞳如小窗',3214.00,'1504149327.1378055.jpg',1,234,0,28,1504149327),(3,2,'魅族 Note5','北京市通州区','                    现货速发,双通如小窗',2435.00,'1504160578.0817683.jpg',1,123,0,30,1504149412),(4,2,'魅蓝  E2','北京市昌平','                    现货速发,双瞳如小窗',1213.00,'1504149483.529853.jpg',1,215,0,16,1504149483),(5,2,'魅族 Note5','北京市昌平','                    现货速发,双瞳如小窗',3421.00,'1504149593.6440284.jpg',1,124,0,4,1504149593),(6,2,'魅族 Note5','上海市珠市口','                    现货速发,双瞳如小窗,佳景观历历',3421.00,'1504155233.853007.jpg',1,231,0,10,1504155233),(7,2,'魅蓝','广州市','                    现货速卖,双瞳如小窗,佳景观历历\r\n',3424.00,'1504155355.0410593.jpg',1,566,0,4,1504155355),(8,2,'魅族 E5','澳门市','                    现货速卖,双瞳如小窗,佳景观历历\r\n',2341.99,'1504155535.492752.jpg',1,234,0,3,1504155535),(9,5,'魅族耳麦','北京市大兴区','                  3D  美音\r\n  ',345.00,'1504157259.8434622.png',1,342,0,2,1504157259),(10,5,'魅族耳机','北京市通州区','                    虚拟现场',234.00,'1504494488.910607.png',1,678,0,4,1504157357),(11,5,'魅族耳机','北京市通州区','                    超重低音',867.00,'1504157411.154106.png',1,456,0,3,1504157411),(12,5,'魅蓝耳机','北京市昌平区','                    纯净人声',456.00,'1504157488.7454011.png',1,234,0,0,1504157488),(14,11,'魅族配件','上海市珠市口','                    全能检测,非同一般',234.00,'1504426870.0679939.png',1,567,0,0,1504426870),(15,11,'魅蓝充电手表','广州市','                    为您准点报时,检测路程',656.00,'1504427244.0179396.png',1,342,0,2,1504427244),(16,11,'电煲','天津','                    秒速快熟',345.00,'1504427450.0305903.png',1,54634,0,2,1504427450),(17,11,'充电宝','湖北','                    急速充电\r\n',432.00,'1504427520.2049983.png',1,342,0,1,1504427520),(18,11,'音箱','上海','                    3D美音',345.00,'1504428531.5618415.png',1,456,0,2,1504428531),(19,11,'小黄人充电器','河北','                    快速充电',676.00,'1504428688.9163609.png',1,324,0,3,1504428688),(20,11,'手柄','湖南','                    游戏之王',342.00,'1504429328.0974605.png',1,565,0,1,1504429328),(21,11,'皮包','湖北','                    特装包',6547.00,'1504429443.5171862.png',1,324,0,0,1504429443);

/*Table structure for table `goods_copy` */

DROP TABLE IF EXISTS `goods_copy`;

CREATE TABLE `goods_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `typeid` int(11) DEFAULT NULL COMMENT 'type表的id外键',
  `goods` varchar(32) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `descr` text,
  `price` double(6,2) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1' COMMENT '1：新添加、2：在售、3：下架',
  `store` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `clicknum` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_goods` (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `goods_copy` */

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `total` double(8,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0:新订单；1：已发货；2：已收货，3 无效订单。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`id`,`uid`,`linkman`,`address`,`code`,`phone`,`addtime`,`total`,`status`) values (40,1,'管理员','北京市昌平区','100100','1234567899',1504478367,676.00,2),(41,1,'管理员','北京市昌平区','100100','1234567899',1504478509,3559.00,3),(42,1,'管理员','北京市昌平区','100100','1234567899',1504478566,345.00,1),(43,13,'123','123123','123123','123123',1504484000,2245.00,3),(44,1,'管理员','北京市昌平区','100100','1234567899',1504487274,3214.00,3),(45,1,'管理员','北京市昌平区','100100','1234567899',1504487320,342.00,0),(46,1,'管理员','北京市昌平区','100100','1234567899',1504495361,2435.00,0),(47,1,'管理员','北京市昌平区','100100','1234567899',1504495975,1869.00,3);

/*Table structure for table `type` */

DROP TABLE IF EXISTS `type`;

CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `type` */

insert  into `type`(`id`,`name`,`pid`,`path`) values (1,'魅族手机',0,'0,'),(2,'魅族手机',1,'0,1,'),(4,'魅族美音',0,'0,'),(5,'魅族耳机',4,'0,4,'),(6,'魅族配件',4,'0,4,'),(10,'智能.配件',0,'0,'),(11,'智能配件',10,'0,10,');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `password` char(32) NOT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `state` tinyint(1) DEFAULT '1',
  `addtime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`name`,`password`,`sex`,`address`,`code`,`phone`,`email`,`state`,`addtime`) values (1,'admin','王','d54d1702ad0f8326224b817c796763c9',0,'北京市昌平区','100100','368456564','12345@qq.com',0,1710151554),(2,'wefe','王丽','e10adc3949ba59abbe56e057f20f883e',0,'北京市昌平区回龙观','100200','13644889','123@qq.com',1,1504130797),(3,'wangname','王伟','e10adc3949ba59abbe56e057f20f883e',1,'天津市二郎区','100300','45481783','124@qq.com',1,1504158543),(4,'2312435','余力','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区回龙观','100300','123467897','1234@qq.com',1,1504195029),(16,'abccd','qweqweqw','e10adc3949ba59abbe56e057f20f883e',0,'12321312','123213','3213213214214','1231231@qweq.com',1,1504494100),(15,'qq','贼','202cb962ac59075b964b07152d234b70',1,'qq','111111','123455666','@qq.com',1,1504494016),(12,'123','三','e10adc3949ba59abbe56e057f20f883e',1,'北京市','100100','123456789','123@qq.com',1,1504318697);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
