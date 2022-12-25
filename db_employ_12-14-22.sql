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
  `main_rank` varchar(255) NOT NULL,
  `sub_rank1` varchar(255) NOT NULL,
  `sub_rank2` varchar(255) NOT NULL,
  `sub_rank3` varchar(15) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `prediction_result_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `prediction_result` */

insert  into `prediction_result`(`result_id`,`main_rank`,`sub_rank1`,`sub_rank2`,`sub_rank3`,`user_id`,`date_created`) values 
(1,'Technical Support Specialist : 67%','Academician : 33%','Administrative Assistant : 33%','No Result',1,'2022-12-24 13:37:43'),
(2,'Technical Support Specialist : 67%','No Result','Administrative Assistant : 33%','No Result',1,'2022-12-24 13:38:26'),
(3,'Technical Support Specialist : 75%','Academician : 25%','Administrative Assistant : 50%','No Result',1,'2022-12-24 13:38:31'),
(4,'Software Engineer / Programmer : 67%','Academician : 33%','Administrative Assistant : 33%','No Result',1,'2022-12-24 13:39:11'),
(5,'Technical Support Specialist : 75%','Academician : 25%','Administrative Assistant : 50%','No Result',5,'2022-12-24 13:39:54'),
(6,'Software Engineer / Programmer : 75%','Academician : 25%','Administrative Assistant : 50%','No Result',5,'2022-12-24 13:40:08'),
(7,'Software Engineer / Programmer : 50%','No Result','No Result','No Result',5,'2022-12-24 13:40:17'),
(8,'Software Engineer / Programmer : 100%','Academician : 33%','Administrative Assistant : 67%','No Result',5,'2022-12-24 13:40:26');

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
  `password` varchar(255) NOT NULL,
  `is_approve` tinyint(1) NOT NULL,
  `user_type` smallint(6) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`first_name`,`middle_name`,`last_name`,`sex`,`curriculum_year`,`contact_number`,`email`,`desired_career`,`department`,`password`,`is_approve`,`user_type`,`date_created`) values 
(1,'Daphne','Lila Hewitt','Jacobson','Female','2020 - 2022','09645343434','risikud@mailinator.com','Software Engineer / Programmer','Computer Science','sha256$Jh7sUIUSgxRWVF0U$449214401fc04c58f2e4833d3fd84ed511dced65f7931a3206603d3250acdccf',1,1,'2022-12-24 13:20:15'),
(2,'CCSadmin01','','WMSU','Male','2020 - 2022','09661573159','CCSadmin01@wmsu.com.ph','Technical Support Specialist','Faculty','sha256$DDcBg7jj8OePABEK$dc73e090ea582e2991807abc0629fd1ec53bc3d0d607b88edad720b4f0ba3b83',1,-1,'2022-12-24 13:21:46'),
(3,'CCSadmin02','','WMSU','Male','2020 - 2022','09661573158','CCSadmin02@wmsu.com.ph','Software Engineer / Programmer','Faculty','sha256$PYBXIJNGK8uTlze9$c5bc5377d5fd73aecff5e1b01618d808e0fd3f09758e5a87b26b6a4296a56b75',1,-1,'2022-12-24 13:23:01'),
(4,'CCSadmin03','','WMSU','Female','2020 - 2022','09661573157','CCSadmin03@wmsu.com.ph','Academician','Faculty','sha256$PsP5XFfRtlNtAOj1$11a7a6b9137adbdef2b2c8f5ae78c08b70e5c5e1e32e3b12a54314dc2777a325',1,-1,'2022-12-24 13:24:18'),
(5,'Doris','Myra Bolton','Fowler','Female','2016 - 2017','09661573156','cudepi@mailinator.com','Academician','Information Technology','sha256$qs2xYrUH758UeBph$cca588322809187268c60554c75fb13f39eb01a8e823a43b868b839309962c5b',1,1,'2022-12-24 13:25:36'),
(6,'CCSfaculty01','','WMSU','Female','-------','09661573151','CCSfaculty01@wmsu.com.ph','Faculty','Faculty','sha256$aoiKBo5K6E5gp2zP$f3b800ee93007ea039d7730b1c6a9e76976113b0d756fcb15a36c6f2553df051',1,0,'2022-12-24 13:32:22'),
(7,'CCSfaculty02','','WMSU','Female','-------','09661573152','CCSfaculty02@wmsu.com.ph','Faculty','Faculty','sha256$zVTzCozVC0ncWRjq$a80cf09ebcbb5e49b4d60257b69704817f822722c1f9e97e828750fad0abe340',1,0,'2022-12-24 13:33:57'),
(8,'CCSfaculty03','','WMSU','Male','-------','09661573153','CCSfaculty03@wmsu.com.ph','Faculty','Faculty','sha256$gAbLydTKUWCvf3NX$92cd37d6744d8a1c1df89bf978fd0838ed80eebbb204298d18e49e55f30a8874',1,0,'2022-12-24 13:34:50'),
(9,'Montana','Flynn Leon','Wagner','Male','2016 - 2017','09553846372','cihih@mailinator.com','Software Engineer / Programmer','Computer Science','sha256$36ogojDxUKFbjxvf$bd9cb99a48631ed07160db7480cde3e67d3c29ec739fbd1e2e22299fc3fced3d',1,1,'2022-12-24 13:47:21'),
(10,'Suki','Willa Rogers','Benjamin','Male','2016 - 2017','09661573892','zukijig@mailinator.com','Administrative Assistant','Computer Science','sha256$it9uDp9S48ohyyfI$8a4c94e80e813fe667b7308bd1e61c9e42d399752711a5cafc14325872653893',1,1,'2022-12-24 13:47:54'),
(11,'Irene','Indira Beard','Mcleod','Female','2016 - 2017','09667834926','syjajor@mailinator.com','Software Engineer / Programmer','Computer Science','sha256$bcN1WwmzleroyVAF$76a78e1ceed61c1b0a996338fbede8f4fd0983446933c0bc77babefb011438da',1,1,'2022-12-24 13:48:16'),
(12,'Zenia','Ila Roberson','Harris','Male','2016 - 2017','09667485335','qyces@mailinator.com','Software Engineer / Programmer','Computer Science','sha256$6BQIpapKUDjPq8jN$a15e1d2aabdadcfab1b8705fb988a7e53bd7630cfc23c93f3915047ff0415a91',0,1,'2022-12-24 13:50:09'),
(13,'Raja','Tanek Fox','Anderson','Male','2020 - 2022','09667485335','muja@mailinator.com','Software Engineer / Programmer','Information Technology','sha256$7Pz78UjUz56JjSYf$8263e834ca9fe8eca56aa7d5def59418f971bca525346288594b58e6552e067a',1,1,'2022-12-24 13:50:54'),
(14,'Ezra','Donna Thomas','Galloway','Male','2018 - 2019','09667485344','tiviliv@mailinator.com','Academician','Information Technology','sha256$5fUMlO5II1OFRL5V$fcd2617d9bcf64852c535f4ff1bacdf893c1e574cd3d08939ef0e10bff415e0e',1,1,'2022-12-24 13:51:15'),
(15,'Nathan','Amanda Jensen','Hardy','Male','2007 - 2008','09667485335','lunywoliv@mailinator.com','Software Engineer / Programmer','Information Technology','sha256$914tOQwHtSyHERAR$63dcbc4c2f1b6b65f15e269ecf2e4967934467239d9649e4315f0cb7546624df',0,1,'2022-12-24 13:51:37'),
(16,'Zorita','Anthony Rutledge','Gates','Female','2020 - 2022','09667485335','xudinogisu@mailinator.com','Technical Support Specialist','Information Technology','sha256$BAdnVDHa2fxSn6KO$f6f9fdff91e349307f8086e9c335f9250b4b6f988e8038a2659840a54357a580',1,1,'2022-12-24 13:52:08');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
