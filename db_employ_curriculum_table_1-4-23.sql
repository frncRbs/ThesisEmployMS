/*
SQLyog Trial v13.1.8 (64 bit)
MySQL - 10.4.27-MariaDB : Database - db_employ
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_employ` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_employ`;

/*Table structure for table `curriculum_result` */

DROP TABLE IF EXISTS `curriculum_result`;

CREATE TABLE `curriculum_result` (
  `curriculum_id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculum_year` varchar(150) DEFAULT NULL,
  `created_by` varchar(150) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`curriculum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `curriculum_result` */

insert  into `curriculum_result`(`curriculum_id`,`curriculum_year`,`created_by`,`date_created`) values 
(1,'2007 - 2008','CCSadmin01','2023-01-04 18:06:51'),
(2,'2016 - 2017','CCSadmin01','2023-01-04 18:24:28'),
(3,'2018 - 2019','CCSadmin01','2023-01-04 18:24:57'),
(7,'2020 - 2022','CCSfaculty01','2023-01-04 19:53:44');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
