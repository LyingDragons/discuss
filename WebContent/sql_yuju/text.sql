/*
Navicat MySQL Data Transfer

Source Server         : mysql1
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : forum_zhizhen

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2018-09-03 16:07:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for text
-- ----------------------------
DROP TABLE IF EXISTS `text`;
CREATE TABLE `text` (
  `tid` int(10) NOT NULL AUTO_INCREMENT,
  `tname` varchar(20) NOT NULL,
  `userid` int(10) NOT NULL,
  `context` varchar(20000) NOT NULL,
  `img` varchar(100) DEFAULT NULL,
  `bid` int(10) NOT NULL,
  `bname` varchar(20) DEFAULT NULL,
  `date` varchar(30) DEFAULT NULL,
  `clicks` int(10) DEFAULT NULL,
  `lastdate` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
