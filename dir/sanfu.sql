-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: sanfu
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_order`
--

DROP TABLE IF EXISTS `app_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `status` int(11) NOT NULL,
  `identifier` varchar(256) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_order_user_id_f25a9fc4_fk_sf_user_id` (`user_id`),
  CONSTRAINT `app_order_user_id_f25a9fc4_fk_sf_user_id` FOREIGN KEY (`user_id`) REFERENCES `sf_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_order`
--

LOCK TABLES `app_order` WRITE;
/*!40000 ALTER TABLE `app_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_ordergoods`
--

DROP TABLE IF EXISTS `app_ordergoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_ordergoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_ordergoods_goods_id_b3c19f94_fk_sf_goods_id` (`goods_id`),
  KEY `app_ordergoods_order_id_ef926487_fk_app_order_id` (`order_id`),
  CONSTRAINT `app_ordergoods_goods_id_b3c19f94_fk_sf_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `sf_goods` (`id`),
  CONSTRAINT `app_ordergoods_order_id_ef926487_fk_app_order_id` FOREIGN KEY (`order_id`) REFERENCES `app_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_ordergoods`
--

LOCK TABLES `app_ordergoods` WRITE;
/*!40000 ALTER TABLE `app_ordergoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_ordergoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add goods',7,'add_goods'),(20,'Can change goods',7,'change_goods'),(21,'Can delete goods',7,'delete_goods'),(22,'Can add banner url',8,'add_bannerurl'),(23,'Can change banner url',8,'change_bannerurl'),(24,'Can delete banner url',8,'delete_bannerurl'),(25,'Can add wheel',9,'add_wheel'),(26,'Can change wheel',9,'change_wheel'),(27,'Can delete wheel',9,'delete_wheel'),(28,'Can add user',10,'add_user'),(29,'Can change user',10,'change_user'),(30,'Can delete user',10,'delete_user'),(31,'Can add car',11,'add_car'),(32,'Can change car',11,'change_car'),(33,'Can delete car',11,'delete_car'),(34,'Can add order',12,'add_order'),(35,'Can change order',12,'change_order'),(36,'Can delete order',12,'delete_order'),(37,'Can add order goods',13,'add_ordergoods'),(38,'Can change order goods',13,'change_ordergoods'),(39,'Can delete order goods',13,'delete_ordergoods');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'app','bannerurl'),(11,'app','car'),(7,'app','goods'),(12,'app','order'),(13,'app','ordergoods'),(10,'app','user'),(9,'app','wheel'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-03-15 11:17:23.452799'),(2,'auth','0001_initial','2019-03-15 11:17:23.645098'),(3,'admin','0001_initial','2019-03-15 11:17:23.698264'),(4,'admin','0002_logentry_remove_auto_add','2019-03-15 11:17:23.714923'),(5,'app','0001_initial','2019-03-15 11:17:23.761844'),(6,'contenttypes','0002_remove_content_type_name','2019-03-15 11:17:23.813249'),(7,'auth','0002_alter_permission_name_max_length','2019-03-15 11:17:23.848861'),(8,'auth','0003_alter_user_email_max_length','2019-03-15 11:17:23.870915'),(9,'auth','0004_alter_user_username_opts','2019-03-15 11:17:23.884929'),(10,'auth','0005_alter_user_last_login_null','2019-03-15 11:17:23.913385'),(11,'auth','0006_require_contenttypes_0002','2019-03-15 11:17:23.919010'),(12,'auth','0007_alter_validators_add_error_messages','2019-03-15 11:17:23.934642'),(13,'auth','0008_alter_user_username_max_length','2019-03-15 11:17:23.963180'),(14,'sessions','0001_initial','2019-03-15 11:17:23.986257'),(15,'app','0002_user','2019-03-15 14:04:31.968876'),(16,'app','0003_car','2019-03-16 13:29:58.104116'),(17,'app','0004_order_ordergoods','2019-03-18 11:14:42.532992');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('t67ig10rramjrjghvfzb3yx52gjmyvo0','MDExZTA5Yzc1MzIzMWZiOWQ4YjcxNjA3NzQ2MDQ3YTA2MTdkOGU4OTp7InRva2VuIjoiNmE5NDA4NzU4Y2YxZDU5MDJjNzBlNTNlYmI3ZTFjYWQifQ==','2019-04-01 01:40:39.926193');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf_bannerurl`
--

DROP TABLE IF EXISTS `sf_bannerurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sf_bannerurl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(300) NOT NULL,
  `categoryid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf_bannerurl`
--

LOCK TABLES `sf_bannerurl` WRITE;
/*!40000 ALTER TABLE `sf_bannerurl` DISABLE KEYS */;
INSERT INTO `sf_bannerurl` VALUES (1,'img/hotsingle/20160912012014_31.jpg','10'),(2,'img/manspic/20160912012022_68.jpg','10'),(3,'img/womanspic/20160912012027_93.jpg','10');
/*!40000 ALTER TABLE `sf_bannerurl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf_car`
--

DROP TABLE IF EXISTS `sf_car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sf_car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `isselect` tinyint(1) NOT NULL,
  `isdelete` tinyint(1) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sf_car_goods_id_4f565e99_fk_sf_goods_id` (`goods_id`),
  KEY `sf_car_user_id_6f5082c8_fk_sf_user_id` (`user_id`),
  CONSTRAINT `sf_car_goods_id_4f565e99_fk_sf_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `sf_goods` (`id`),
  CONSTRAINT `sf_car_user_id_6f5082c8_fk_sf_user_id` FOREIGN KEY (`user_id`) REFERENCES `sf_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf_car`
--

LOCK TABLES `sf_car` WRITE;
/*!40000 ALTER TABLE `sf_car` DISABLE KEYS */;
INSERT INTO `sf_car` VALUES (1,2,1,0,1,5),(2,1,1,0,3,5);
/*!40000 ALTER TABLE `sf_car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf_goods`
--

DROP TABLE IF EXISTS `sf_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sf_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(300) NOT NULL,
  `name` varchar(300) NOT NULL,
  `truckid` varchar(100) NOT NULL,
  `original` decimal(5,1) NOT NULL,
  `present` decimal(5,1) NOT NULL,
  `categoryid` varchar(100) NOT NULL,
  `childid` varchar(100) NOT NULL,
  `childname` varchar(200) NOT NULL,
  `dealerid` varchar(100) NOT NULL,
  `hot` int(11) NOT NULL,
  `new` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf_goods`
--

LOCK TABLES `sf_goods` WRITE;
/*!40000 ALTER TABLE `sf_goods` DISABLE KEYS */;
INSERT INTO `sf_goods` VALUES (1,'img/newhot/20160912012009_7.jpg','三福2016男秋哆啦A梦','20160912012009_7',99.0,79.0,'11','12','男装','1001',1,1),(2,'img/newhot/20160912012010_11.jpg','三福2016女秋荷叶袖杠','20160912012009_11',399.0,299.0,'31','32','女装','1002',0,1),(3,'img/newhot/20160912012010_12.jpg','三福2016女冬休闲百搭','20160912012009_12',399.0,299.0,'31','32','女装','1003',1,1),(4,'img/newhot/20160912012010_8.jpg','三福2016男秋哆啦A梦','20160912012009_8',99.0,79.0,'11','12','男装','1004',0,1),(5,'img/newhot/20160912012010_9.jpg','三福2016男秋哆啦A梦','20160912012009_9',99.0,79.0,'11','12','男装','1005',1,1),(6,'img/newhot/20160912012010_10.jpg','三福2016男秋哆啦A梦','20160912012009_10',99.0,79.0,'11','12','男装','1006',0,1),(7,'img/newhot/20160912012014_30.jpg','三福2016女卡通动物形状链条单肩包 韩版斜挎','20160912012009_30',149.0,139.0,'41','42','背包','1007',0,1),(8,'img/newhot/20160912012014_28.jpg','三福2016女净色流苏纽扣斜挎包 韩版迷你PU单肩','20160912012009_28',199.0,179.0,'41','42','背包','1008',1,1),(9,'img/hotsingle/20160912012015_32.jpg','三福2015新品彩妆 新肌能蚕丝面膜细腻修复混款','20160912012015_32',99.0,79.0,'11','12','面膜','1009',0,0),(10,'img/hotsingle/20160912012015_33.jpg','三福2016 动物面膜 卖萌神器提亮匀净水润','20160912012015_33',99.0,79.0,'11','12','面膜','1010',0,0),(11,'img/hotsingle/20160912012015_34.jpg','三福2016新品盒装面贴 修护锁水蚕丝面膜 正品5片装','20160912012015_34',99.0,79.0,'11','12','面膜','1011',0,0),(12,'img/hotsingle/20160912012015_35.jpg','三福2015新品 保湿补水面膜贴 八杯水/小黄瓜铁盒12片 送保湿水','20160912012015_35',99.0,79.0,'11','12','面膜','1012',0,0),(13,'img/womanspic/20160912012028_94.jpg','三福2016女秋净色翻领薄外套 中长款七分袖风衣','20160912012028_94',399.0,299.0,'31','32','女装','1013',0,1),(14,'img/womanspic/20160912012028_95.jpg','三福2016女冬纯色翻领夹克 韩版机车修身厚外套','20160912012028_95',399.0,299.0,'31','32','女装','1014',0,1),(15,'img/womanspic/20160912012028_96.jpg','三福2016女秋后背字母刺绣双口袋牛仔外套 百搭夹克','20160912012028_96',399.0,299.0,'31','32','女装','1015',0,1);
/*!40000 ALTER TABLE `sf_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf_user`
--

DROP TABLE IF EXISTS `sf_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sf_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(40) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf_user`
--

LOCK TABLES `sf_user` WRITE;
/*!40000 ALTER TABLE `sf_user` DISABLE KEYS */;
INSERT INTO `sf_user` VALUES (1,'asdasd','123123','asd'),(2,'aaa','111111','tom'),(3,'asd','123123','alice'),(4,'sb','123123','张楷'),(5,'mm','4297f44b13955235245b2497399d7a93','张楷');
/*!40000 ALTER TABLE `sf_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf_wheel`
--

DROP TABLE IF EXISTS `sf_wheel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sf_wheel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf_wheel`
--

LOCK TABLES `sf_wheel` WRITE;
/*!40000 ALTER TABLE `sf_wheel` DISABLE KEYS */;
INSERT INTO `sf_wheel` VALUES (1,'img/index/banner.jpg'),(2,'img/index/banner1.jpg'),(3,'img/index/banner2.jpg');
/*!40000 ALTER TABLE `sf_wheel` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-18 20:04:58
