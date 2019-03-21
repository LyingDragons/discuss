/*
Navicat MySQL Data Transfer

Source Server         : mysql1
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : forum_zhizhen

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2018-09-03 16:07:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for conment
-- ----------------------------
DROP TABLE IF EXISTS `conment`;
CREATE TABLE `conment` (
  `cId` int(10) NOT NULL AUTO_INCREMENT,
  `tid` int(10) NOT NULL,
  `userid` int(10) NOT NULL,
  `context` varchar(300) NOT NULL,
  `date` varchar(20) DEFAULT NULL,
  `floor` int(10) DEFAULT NULL,
  PRIMARY KEY (`cId`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
