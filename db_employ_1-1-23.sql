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

/*Table structure for table `prediction_result` */

DROP TABLE IF EXISTS `prediction_result`;

CREATE TABLE `prediction_result` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `chart_rank` varchar(255) NOT NULL,
  `main_rank` varchar(255) NOT NULL,
  `sub_rank1` varchar(255) NOT NULL,
  `sub_rank2` varchar(255) NOT NULL,
  `sub_rank3` varchar(15) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `prediction_result_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `prediction_result` */

insert  into `prediction_result`(`result_id`,`chart_rank`,`main_rank`,`sub_rank1`,`sub_rank2`,`sub_rank3`,`user_id`,`date_created`) values 
(119,'Technical Support Specialist','Technical Support Specialist : 50%','Academician : 50%','Administrative Assistant : 50%','No Result',21,'2022-12-30 22:52:29'),
(124,'Software Engineer / Programmer','Software Engineer / Programmer : 67%','Academician : 33%','Administrative Assistant : 33%','No Result',20,'2022-12-31 16:34:36'),
(129,'Technical Support Specialist','Technical Support Specialist : 67%','Academician : 33%','Administrative Assistant : 33%','No Result',20,'2023-01-01 01:54:18'),
(130,'Technical Support Specialist','Technical Support Specialist : 50%','Academician : 50%','Administrative Assistant : 50%','No Result',21,'2023-01-01 01:58:43'),
(131,'Software Engineer / Programmer','Software Engineer / Programmer : 67%','Academician : 33%','Administrative Assistant : 67%','No Result',15,'2023-01-01 02:06:08'),
(134,'Technical Support Specialist','Technical Support Specialist : 50%','Academician : 50%','Administrative Assistant : 50%','No Result',22,'2023-01-01 15:20:47'),
(135,'Technical Support Specialist','Technical Support Specialist : 100%','Academician : 33%','Administrative Assistant : 67%','No Result',22,'2023-01-01 15:21:17');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `sex` varchar(150) NOT NULL,
  `curriculum_year` varchar(150) NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `email` varchar(150) NOT NULL,
  `desired_career` varchar(150) NOT NULL,
  `department` varchar(150) NOT NULL,
  `program` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_approve` tinyint(1) NOT NULL,
  `predict_no` smallint(6) NOT NULL,
  `user_type` smallint(6) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`first_name`,`middle_name`,`last_name`,`sex`,`curriculum_year`,`contact_number`,`email`,`desired_career`,`department`,`program`,`password`,`is_approve`,`predict_no`,`user_type`,`date_created`) values 
(1,'Daphne','Lila Hewitt','Jacobson','Female','2020 - 2022','09645343434','risikud@mailinator.com','Software Engineer / Programmer','Computer Science','Regular','sha256$Jh7sUIUSgxRWVF0U$449214401fc04c58f2e4833d3fd84ed511dced65f7931a3206603d3250acdccf',1,0,1,'2022-12-24 13:20:15'),
(2,'CCSadmin01','','WMSU','Male','2020 - 2022','09661573159','CCSadmin01@wmsu.com.ph','Technical Support Specialist','Faculty','Regular','sha256$DDcBg7jj8OePABEK$dc73e090ea582e2991807abc0629fd1ec53bc3d0d607b88edad720b4f0ba3b83',1,0,-1,'2022-12-24 13:21:46'),
(3,'CCSadmin02','','WMSU','Male','2020 - 2022','09661573158','CCSadmin02@wmsu.com.ph','Software Engineer / Programmer','Faculty','Regular','sha256$PYBXIJNGK8uTlze9$c5bc5377d5fd73aecff5e1b01618d808e0fd3f09758e5a87b26b6a4296a56b75',1,0,-1,'2022-12-24 13:23:01'),
(4,'CCSadmin03','','WMSU','Female','2020 - 2022','09661573157','CCSadmin03@wmsu.com.ph','Academician','Faculty','Regular','sha256$PsP5XFfRtlNtAOj1$11a7a6b9137adbdef2b2c8f5ae78c08b70e5c5e1e32e3b12a54314dc2777a325',1,0,-1,'2022-12-24 13:24:18'),
(6,'CCSfaculty01','','WMSU','Female','-------','09661573151','CCSfaculty01@wmsu.com.ph','Faculty','Faculty','Regular','sha256$aoiKBo5K6E5gp2zP$f3b800ee93007ea039d7730b1c6a9e76976113b0d756fcb15a36c6f2553df051',1,0,0,'2022-12-24 13:32:22'),
(7,'CCSfaculty02','','WMSU','Female','-------','09661573152','CCSfaculty02@wmsu.com.ph','Faculty','Faculty','Regular','sha256$zVTzCozVC0ncWRjq$a80cf09ebcbb5e49b4d60257b69704817f822722c1f9e97e828750fad0abe340',1,0,0,'2022-12-24 13:33:57'),
(12,'Zenia','Ila Roberson','Harris','Male','2016 - 2017','09667485335','qyces@mailinator.com','Software Engineer / Programmer','Computer Science','Shiftee','sha256$6BQIpapKUDjPq8jN$a15e1d2aabdadcfab1b8705fb988a7e53bd7630cfc23c93f3915047ff0415a91',0,0,1,'2022-12-24 13:50:09'),
(14,'Ezra','Donna Thomas','Galloway','Male','2018 - 2019','09667485344','tiviliv@mailinator.com','Academician','Information Technology','Shiftee','sha256$5fUMlO5II1OFRL5V$fcd2617d9bcf64852c535f4ff1bacdf893c1e574cd3d08939ef0e10bff415e0e',1,0,1,'2022-12-24 13:51:15'),
(15,'Nathan','Amanda Jensen','Hardy','Male','2007 - 2008','09667485335','lunywoliv@mailinator.com','Academician','Information Technology','Regular','sha256$914tOQwHtSyHERAR$63dcbc4c2f1b6b65f15e269ecf2e4967934467239d9649e4315f0cb7546624df',1,1,1,'2022-12-24 13:51:37'),
(17,'Quyn','Ulric Charles','Mosley','Female','2018 - 2019','09667439286','lasypud@mailinator.com','Academician','Computer Science','Transferee','sha256$FI3WsCfL5c5Q8rZn$ba753f5f5ef0e340d475e829fdb7a91e46690cce16ae3153b43e1d944041b54c',0,0,1,'2022-12-25 19:15:42'),
(18,'Marvin','Ocean Mccray','Cook','Female','-------','09661738157','lygy@mailinator.com','Faculty','Faculty','Regular','sha256$HYbm1eGinkAJxvO5$52e179e465c24da5d086e3802822e5588b979c2f01e881b02bc374e063e0e263',1,0,0,'2022-12-26 21:53:47'),
(19,'Brent','Colton Mckenzie','Rush','Female','-------','09664789523','haleji@mailinator.com','Faculty','Faculty','Regular','sha256$XOUC4D7LSRHXwO76$79f0de6338468e63898904acea477676da69d8a225d0933b6438cd56f376f510',1,0,0,'2022-12-26 21:54:02'),
(20,'Lila','Ross Ortiz','Roth','Female','2016 - 2017','09778435672','rucoji@mailinator.com','Software Engineer / Programmer','Information Technology','Regular','sha256$F9uCH2ba3mrNWlzy$df7529715faa3eb112509aae883676aeacee3ca98e4412f115957a4cabb59049',1,2,1,'2022-12-30 20:25:26'),
(21,'Mason','Charde Tucker','Moss','Male','2007 - 2008','09778486272','koxivyt@mailinator.com','Software Engineer / Programmer','Computer Science','Regular','sha256$B5Nm2XdnATTRSrca$c0a6b53e550d8d92ef394d4e1329442cb9f7c042ff2c2828f8b353c2e46c08aa',1,2,1,'2022-12-30 22:51:38'),
(22,'Darrel','Hyatt Barron','Oliver','Male','2016 - 2017','09754634952','famipof@mailinator.com','Software Engineer / Programmer','Computer Science','Transferee','sha256$UcTmnNQbe8jkZB9v$86292b016aa54b759bfe0a038168684c769aa15952b2b6470774b014d1e4414a',1,2,1,'2023-01-01 14:08:13');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
