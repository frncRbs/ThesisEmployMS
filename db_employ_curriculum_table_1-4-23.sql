/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.27-MariaDB : Database - db_employ
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
  PRIMARY KEY (`curriculum_id`),
  UNIQUE KEY `curriculum_year` (`curriculum_year`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `curriculum_result` */

insert  into `curriculum_result`(`curriculum_id`,`curriculum_year`,`created_by`,`date_created`) values (1,'2007 - 2008','CCSadmin01','2023-01-08 10:43:08'),(3,'2016 - 2018','CCSadmin01','2023-01-08 10:44:40'),(4,'2019 - 2020','CCSadmin01','2023-01-08 10:44:58'),(5,'2023 - 2025','CCSadmin01','2023-01-08 10:45:11');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
