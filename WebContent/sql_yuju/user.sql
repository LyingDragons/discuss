/*
Navicat MySQL Data Transfer

Source Server         : mysql1
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : forum_zhizhen

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2018-09-03 16:07:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `age` int(10) NOT NULL,
  `sex` varchar(5) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL,
  `score` int(20) DEFAULT NULL,
  `identity` varchar(10) DEFAULT NULL,
  `collections` varchar(10000) DEFAULT NULL,
  `img` varchar(10000) DEFAULT NULL,
  `single` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`userid`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
