/*
Navicat MySQL Data Transfer

Source Server         : mysql1
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : forum_zhizhen

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2018-09-03 16:06:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `mid` int(50) NOT NULL AUTO_INCREMENT,
  `senderid` varchar(50) DEFAULT NULL,
  `reciverid` varchar(50) NOT NULL,
  `message` varchar(10000) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `statu` varchar(5) NOT NULL,
  `tid` int(10) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
