-- --------------------------------------------------------
-- 主机:                           spring-abc.xyz
-- 服务器版本:                        5.5.43-MariaDB - MariaDB Server
-- 服务器操作系统:                      Linux
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 spring_winds 的数据库结构
CREATE DATABASE IF NOT EXISTS `spring_winds` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `spring_winds`;


-- 导出  表 spring_winds.collection 结构
CREATE TABLE IF NOT EXISTS `collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_miyylw8b3lg44gmh7k5y3u72h` (`topic_id`),
  KEY `FK_aanxkg6n45mck5fl454yd9aaa` (`user_id`),
  CONSTRAINT `FK_aanxkg6n45mck5fl454yd9aaa` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_miyylw8b3lg44gmh7k5y3u72h` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.collection 的数据：~6 rows (大约)
DELETE FROM `collection`;



-- 导出  表 spring_winds.comment 结构
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` mediumtext NOT NULL,
  `create_at` datetime NOT NULL,
  `floor` bigint(20) NOT NULL,
  `like_count` bigint(20) NOT NULL,
  `status` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1by25k3whex972v78w01wbnar` (`topic_id`),
  KEY `FK_mxoojfj9tmy8088avf57mpm02` (`user_id`),
  CONSTRAINT `FK_1by25k3whex972v78w01wbnar` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `FK_mxoojfj9tmy8088avf57mpm02` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.comment 的数据：~26 rows (大约)
DELETE FROM `comment`;



-- 导出  表 spring_winds.comment_user 结构
CREATE TABLE IF NOT EXISTS `comment_user` (
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`,`user_id`),
  KEY `FK_obutvg4o609wp066ipmoky7ar` (`user_id`),
  CONSTRAINT `FK_obutvg4o609wp066ipmoky7ar` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ri39mcdgmam0363rvww15yxoo` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 导出  表 spring_winds.node 结构
CREATE TABLE IF NOT EXISTS `node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `topic_count` bigint(20) DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `section_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_fwigxdmj6bsrpcmhcgpmlsirh` (`name`),
  KEY `FK_kihhhba7yo0oh5kplfgafba4e` (`section_id`),
  CONSTRAINT `FK_kihhhba7yo0oh5kplfgafba4e` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.node 的数据：~12 rows (大约)
DELETE FROM `node`;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` (`id`, `avatar`, `description`, `topic_count`, `name`, `status`, `section_id`) VALUES
	(1, NULL, '每天每时每刻记下你的亲身感触', 0, '感触', 0, 1);
/*!40000 ALTER TABLE `node` ENABLE KEYS */;


-- 导出  表 spring_winds.notification 结构
CREATE TABLE IF NOT EXISTS `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT '0',
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_inxhsk5bf6gpm7b41orsar7fc` (`comment_id`),
  KEY `FK_1urdwwsh2ti15ta6f6p5dbdcp` (`user_id`),
  CONSTRAINT `FK_1urdwwsh2ti15ta6f6p5dbdcp` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_inxhsk5bf6gpm7b41orsar7fc` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.notification 的数据：~33 rows (大约)
DELETE FROM `notification`;

-- 导出  表 spring_winds.section 结构
CREATE TABLE IF NOT EXISTS `section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_rwqtt5x96oahjdtqt20vxu4um` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.section 的数据：~4 rows (大约)
DELETE FROM `section`;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` (`id`, `name`, `sort`) VALUES
	(1, 'test', 0);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;


-- 导出  表 spring_winds.topic 结构
CREATE TABLE IF NOT EXISTS `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collecton_id` int(11) DEFAULT NULL,
  `comment_count` bigint(20) unsigned DEFAULT '0',
  `content` longtext NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `last_comment_at` datetime DEFAULT NULL,
  `last_comment_user` tinyblob,
  `last_comment_user_id` int(11) DEFAULT NULL,
  `like_count` bigint(20) unsigned DEFAULT '0',
  `score` bigint(20) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `update_at` datetime DEFAULT NULL,
  `view_count` bigint(20) unsigned DEFAULT '0',
  `node_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_99um5d29ufxu4mrm2lbt3a9ms` (`node_id`),
  KEY `FK_c975xs66f0v6extdjdl0csctr` (`user_id`),
  CONSTRAINT `FK_99um5d29ufxu4mrm2lbt3a9ms` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`),
  CONSTRAINT `FK_c975xs66f0v6extdjdl0csctr` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.topic 的数据：~8 rows (大约)
DELETE FROM `topic`;



-- 导出  表 spring_winds.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `comment_count` bigint(20) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `home_page` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `nick` varchar(255) DEFAULT NULL,
  `number` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `points` bigint(20) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `topic_count` bigint(20) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_sb8bbouer5wak8vyiiy4pf2bx` (`username`),
  UNIQUE KEY `UK_ob8kqyqqgmefl0aco34akdtpe` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  spring_winds.user 的数据：~6 rows (大约)
DELETE FROM `user`;

