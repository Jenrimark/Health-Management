/*
 Navicat Premium Dump SQL

 Source Server         : Jenrimark
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : personal_health

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 20/06/2025 12:33:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '美食类别ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类别名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '美食类别表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '家常菜');
INSERT INTO `category` VALUES (2, '常见点心');
INSERT INTO `category` VALUES (3, '水果');
INSERT INTO `category` VALUES (4, '海鲜');
INSERT INTO `category` VALUES (5, '蔬菜');
INSERT INTO `category` VALUES (6, '早茶点心');
INSERT INTO `category` VALUES (7, '烧腊');
INSERT INTO `category` VALUES (8, '徽州古韵');
INSERT INTO `category` VALUES (9, '蒙古草原盛宴');
INSERT INTO `category` VALUES (10, '云南过桥米线');
INSERT INTO `category` VALUES (11, '东北炖菜');
INSERT INTO `category` VALUES (12, '新疆烤串风情');
INSERT INTO `category` VALUES (13, '闽南风味小吃');
INSERT INTO `category` VALUES (14, '湘菜辣味传奇');
INSERT INTO `category` VALUES (15, '海鲜佳肴');
INSERT INTO `category` VALUES (16, '奶茶');
INSERT INTO `category` VALUES (17, '非遗美食');
INSERT INTO `category` VALUES (18, '奶制品');

-- ----------------------------
-- Table structure for cookbook
-- ----------------------------
DROP TABLE IF EXISTS `cookbook`;
CREATE TABLE `cookbook`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '食谱ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `category_id` int NULL DEFAULT NULL COMMENT '所属分类ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否是公开食谱',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '食谱信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES (1, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e910183莴苣苣炒鸡.webp', '莴苣苣炒鸡', 1, '<p>鸡肉40g，莴苣苣50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (2, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8f0dda0红白饭.webp', '红白饭', 1, '<p>大米20g，红米20g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (3, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=720738d橙子.webp', '橙子', 3, '<p>200g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (5, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=50b9254杂粮饭.webp', '黑米饭', 1, '<p>黑米15g，大米35g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (10, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f3556da牛奶.webp', '低脂牛奶', 18, '<p>250mL</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (11, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dc10fb9盐水菜心.webp', '盐水菜心', 1, '<p>菜心100g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (12, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ce6670e清蒸鲩鱼.webp', '清蒸鲩鱼', 1, '<p>鲩鱼30g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (13, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=90e47b2米饭.webp', '米饭', 1, '<p>大米60g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (14, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c961d7f苹果.webp', '苹果', 3, '<p>200g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (15, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6543954山药菌菇汤.webp', '山药菌菇汤', 1, '<p>鲜山药30g，香菇25g，白玉菇25g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (16, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c376334虾仁鸡蛋羹.webp', '虾皮紫菜鸡蛋羹', 1, '<p>虾皮10g，紫菜10g，鸡蛋50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (17, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=606acde黄白饭.webp', '黄白饭', 1, '<p>大米25g，玉米碴干120g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (18, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1ab7826辣椒炒鸡肉.webp', '辣椒炒鸡肉', 1, '<p>尖椒80g，鸡胸肉50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (21, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=74922d7蒸南瓜.webp', '蒸南瓜', 1, '<p>150g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (22, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4604eac蛋肠粉.webp', '鸡蛋肠粉', 6, '<p>菠菜50g，鸡蛋50g，肠粉150g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (23, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=88df171西兰花炒香菇.webp', '西兰花炒香菇', 1, '<p>西兰花100g，香菇60g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (24, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3e3ce4c鸡蛋.webp', '茶盐鸡蛋', 1, '<p>50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (25, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7e13996馒头.jpg', '杂粮馒头', 1, '<p>面粉40g，玉米面粉25g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (27, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7698edc水煮油莱.webp', '水煮油莱', 1, '<p>油莱150g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (28, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4961f62鸡蛋.webp', '鸡蛋', 1, '<p>50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (29, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3890e12苋菜汤.webp', '苋菜汤', 1, '<p>苋菜150g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (30, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dde190d山药炒肉片.webp', '山药炒肉片', 1, '<p>鲜山药150g，红米25g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (31, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b4ee46f蒸山药.webp', '蒸山药', 1, '<p>鲜山药*300g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (32, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0d69310二米饭.webp', '二米饭', 1, '<p>大米30g，小米20g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (33, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=29c2933猪肉炖酸菜.webp', '猪肉炖酸菜', 1, '<p>猪里脊肉50g，酸菜100g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (34, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=259616c红枣发糕.jpg', '红枣发糕', 1, '<p>20g，生姜50g，大枣10g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (35, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a3ab166沙拉.webp', '藜麦沙拉', 1, '<p>藜麦20g，苦苣50g，紫甘蓝50g，鲜虾仁50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (36, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d17e154开心果仁.webp', '开心果仁', 1, '<p>10g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (37, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1b14ab7鸡蛋.webp', '茶叶蛋', 1, '<p>鸡蛋50g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (38, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1aedb02冬枣.webp', '冬枣', 3, '<p>100g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (39, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9c1b5bc菠菜鸡蛋汤面.webp', '菠菜鸡蛋汤面', 1, '<p>菠菜50g，鸡蛋25g，面条40g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (40, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a610d25圆白菜炒腐竹.webp', '圆白菜炒腐竹', 1, '<p>圆白菜100g，腐竹20g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (41, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=77e14fc红薯饭.webp', '红薯饭', 1, '<p>大米40g，红薯100g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (42, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fa295bf胡萝卜炒肉.webp', '胡萝卜炒肉', 1, '<p>柿子椒30g，胡萝卜50g，猪瘦肉40g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (43, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1d30a60西红柿豆腐汤.webp', '西红柿豆腐汤', 1, '<p>西红柿50g，豆腐30g</p>', 1, '2025-04-19 11:13:00');
INSERT INTO `cookbook` VALUES (64, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=93f374egouqi.webp', '枸杞叶豆腐汤', 1, '<p>枸杞叶50g，豆腐50g</p>', 1, '2025-04-19 18:37:13');
INSERT INTO `cookbook` VALUES (65, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bd95531水煮奶白菜.jpg@watermark=0', '水煮奶白菜', 1, '<p><span style=\"color: rgb(84, 83, 84); background-color: rgb(245, 247, 250); font-size: 14px;\">烧脚白菜80g</span></p>', 1, '2025-04-19 18:39:16');
INSERT INTO `cookbook` VALUES (66, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c237504鲜虾焖冬笋.jpg@h_1280', '鲜虾焖冬笋', 1, '<p><span style=\"color: rgb(84, 83, 84); background-color: rgb(245, 247, 250); font-size: 14px;\">冬笋80g，海虾30g</span></p>', 1, '2025-04-19 18:40:35');
INSERT INTO `cookbook` VALUES (67, 1, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bfda12a红薯.webp', '红薯', 1, '<p><br></p>', 1, '2025-04-19 23:33:49');
INSERT INTO `cookbook` VALUES (68, 2, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3788599t013a1780aedcfea383.jpg', '巧克力', 2, '<p>超甜！</p>', 0, '2025-04-23 10:58:09');
INSERT INTO `cookbook` VALUES (71, 29, 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e6bae5b90.jpg', '奶茶', 16, '<p>超好喝</p>', 1, '2025-06-19 15:17:06');

-- ----------------------------
-- Table structure for cookbook_nutriment
-- ----------------------------
DROP TABLE IF EXISTS `cookbook_nutriment`;
CREATE TABLE `cookbook_nutriment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '食谱营养素关联信息主键ID',
  `cookbook_id` int NULL DEFAULT NULL COMMENT '食谱ID',
  `nutriment_id` int NULL DEFAULT NULL COMMENT '营养素ID',
  `100g_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '每100g食物中含量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '食谱营养素关联信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cookbook_nutriment
-- ----------------------------
INSERT INTO `cookbook_nutriment` VALUES (1, 68, 3, '200');
INSERT INTO `cookbook_nutriment` VALUES (2, 42, 1, '10');
INSERT INTO `cookbook_nutriment` VALUES (3, 42, 7, '2');
INSERT INTO `cookbook_nutriment` VALUES (4, 42, 8, '360');
INSERT INTO `cookbook_nutriment` VALUES (5, 42, 4, '5');
INSERT INTO `cookbook_nutriment` VALUES (6, 42, 3, '7');
INSERT INTO `cookbook_nutriment` VALUES (7, 42, 5, '190');
INSERT INTO `cookbook_nutriment` VALUES (8, 42, 9, '0.1');
INSERT INTO `cookbook_nutriment` VALUES (9, 42, 6, '30');
INSERT INTO `cookbook_nutriment` VALUES (10, 65, 1, '1.5');
INSERT INTO `cookbook_nutriment` VALUES (11, 65, 7, '1');
INSERT INTO `cookbook_nutriment` VALUES (12, 65, 8, '100');
INSERT INTO `cookbook_nutriment` VALUES (13, 65, 6, '100');
INSERT INTO `cookbook_nutriment` VALUES (14, 65, 4, '2');
INSERT INTO `cookbook_nutriment` VALUES (15, 65, 3, '0.2');
INSERT INTO `cookbook_nutriment` VALUES (16, 65, 5, '130');
INSERT INTO `cookbook_nutriment` VALUES (17, 43, 8, '90');
INSERT INTO `cookbook_nutriment` VALUES (18, 43, 7, '1');
INSERT INTO `cookbook_nutriment` VALUES (19, 43, 6, '110');
INSERT INTO `cookbook_nutriment` VALUES (20, 43, 5, '180');
INSERT INTO `cookbook_nutriment` VALUES (21, 43, 3, '2');
INSERT INTO `cookbook_nutriment` VALUES (22, 43, 1, '6');
INSERT INTO `cookbook_nutriment` VALUES (23, 16, 1, '10');
INSERT INTO `cookbook_nutriment` VALUES (24, 16, 7, '1.5');
INSERT INTO `cookbook_nutriment` VALUES (25, 16, 8, '140');
INSERT INTO `cookbook_nutriment` VALUES (26, 16, 6, '120');
INSERT INTO `cookbook_nutriment` VALUES (27, 16, 3, '7');
INSERT INTO `cookbook_nutriment` VALUES (28, 16, 4, '7');
INSERT INTO `cookbook_nutriment` VALUES (29, 16, 5, '130');
INSERT INTO `cookbook_nutriment` VALUES (30, 13, 1, '2.6');
INSERT INTO `cookbook_nutriment` VALUES (31, 13, 7, '0.3');
INSERT INTO `cookbook_nutriment` VALUES (32, 13, 8, '0');
INSERT INTO `cookbook_nutriment` VALUES (33, 13, 6, '7');
INSERT INTO `cookbook_nutriment` VALUES (34, 13, 4, '25.9');
INSERT INTO `cookbook_nutriment` VALUES (35, 13, 2, '0.3');
INSERT INTO `cookbook_nutriment` VALUES (36, 13, 5, '30');
INSERT INTO `cookbook_nutriment` VALUES (37, 5, 5, '3.4');
INSERT INTO `cookbook_nutriment` VALUES (38, 5, 7, '1');
INSERT INTO `cookbook_nutriment` VALUES (39, 5, 8, '0.1');
INSERT INTO `cookbook_nutriment` VALUES (40, 5, 6, '10');
INSERT INTO `cookbook_nutriment` VALUES (41, 5, 4, '23');
INSERT INTO `cookbook_nutriment` VALUES (42, 5, 3, '0.7');
INSERT INTO `cookbook_nutriment` VALUES (43, 5, 5, '40');
INSERT INTO `cookbook_nutriment` VALUES (44, 10, 1, '3');
INSERT INTO `cookbook_nutriment` VALUES (45, 10, 7, '0');
INSERT INTO `cookbook_nutriment` VALUES (46, 10, 8, '104');
INSERT INTO `cookbook_nutriment` VALUES (47, 10, 4, '3.4');
INSERT INTO `cookbook_nutriment` VALUES (48, 10, 3, '1');
INSERT INTO `cookbook_nutriment` VALUES (49, 10, 5, '109');
INSERT INTO `cookbook_nutriment` VALUES (50, 67, 1, '1.1');
INSERT INTO `cookbook_nutriment` VALUES (51, 67, 7, '2');
INSERT INTO `cookbook_nutriment` VALUES (52, 67, 8, '125');
INSERT INTO `cookbook_nutriment` VALUES (53, 67, 6, '23');
INSERT INTO `cookbook_nutriment` VALUES (54, 67, 4, '20');
INSERT INTO `cookbook_nutriment` VALUES (55, 67, 3, '0.2');
INSERT INTO `cookbook_nutriment` VALUES (56, 67, 5, '130');
INSERT INTO `cookbook_nutriment` VALUES (57, 1, 1, '10');
INSERT INTO `cookbook_nutriment` VALUES (58, 1, 7, '1.5');
INSERT INTO `cookbook_nutriment` VALUES (59, 1, 8, '40');
INSERT INTO `cookbook_nutriment` VALUES (60, 1, 6, '18');
INSERT INTO `cookbook_nutriment` VALUES (62, 1, 3, '4');
INSERT INTO `cookbook_nutriment` VALUES (63, 1, 5, '210');
INSERT INTO `cookbook_nutriment` VALUES (64, 10, 9, '1');
INSERT INTO `cookbook_nutriment` VALUES (65, 68, 4, '28.9');
INSERT INTO `cookbook_nutriment` VALUES (66, 68, 3, '53');
INSERT INTO `cookbook_nutriment` VALUES (67, 68, 14, '205');
INSERT INTO `cookbook_nutriment` VALUES (68, 68, 1, '10.7');
INSERT INTO `cookbook_nutriment` VALUES (69, 68, 8, '60');

-- ----------------------------
-- Table structure for diet_history
-- ----------------------------
DROP TABLE IF EXISTS `diet_history`;
CREATE TABLE `diet_history`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户饮食主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `cookbook_id` int NULL DEFAULT NULL COMMENT '食谱ID',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '记录的值',
  `create_time` datetime NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户饮食信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of diet_history
-- ----------------------------
INSERT INTO `diet_history` VALUES (1, 2, 1, '早餐', '200', '2025-04-04 14:02:37');
INSERT INTO `diet_history` VALUES (2, 2, 67, '早餐', '200', '2025-04-04 23:34:44');
INSERT INTO `diet_history` VALUES (3, 2, 10, '早餐', '160', '2025-04-04 23:34:44');
INSERT INTO `diet_history` VALUES (4, 2, 5, '中饭', '150', '2025-04-05 23:36:47');
INSERT INTO `diet_history` VALUES (5, 2, 13, '晚饭', '150', '2025-04-05 23:36:47');
INSERT INTO `diet_history` VALUES (6, 2, 16, '中饭', '100', '2025-04-05 23:36:47');
INSERT INTO `diet_history` VALUES (7, 2, 43, '晚饭', '150', '2025-04-06 23:36:47');
INSERT INTO `diet_history` VALUES (8, 2, 65, '中饭', '150', '2025-04-06 23:36:47');
INSERT INTO `diet_history` VALUES (9, 2, 42, '晚饭', '150', '2025-04-07 23:36:47');
INSERT INTO `diet_history` VALUES (10, 2, 68, '中餐', '500', '2025-04-08 15:56:52');
INSERT INTO `diet_history` VALUES (11, 2, 67, '早餐', '100', '2025-04-11 15:56:52');
INSERT INTO `diet_history` VALUES (12, 2, 43, '晚餐', '500', '2025-04-11 15:56:52');
INSERT INTO `diet_history` VALUES (13, 2, 16, '中餐', '300', '2025-04-15 15:56:52');
INSERT INTO `diet_history` VALUES (14, 2, 13, '中餐', '200', '2025-04-15 15:56:52');
INSERT INTO `diet_history` VALUES (15, 2, 10, '早餐', '160', '2025-04-16 16:14:16');
INSERT INTO `diet_history` VALUES (16, 2, 10, '早餐', '250', '2025-04-17 16:14:32');
INSERT INTO `diet_history` VALUES (17, 2, 10, '早餐', '300', '2025-04-18 16:14:49');
INSERT INTO `diet_history` VALUES (18, 2, 10, '早餐', '200', '2025-04-19 16:15:10');
INSERT INTO `diet_history` VALUES (19, 2, 1, '早餐', '200', '2025-04-20 16:15:33');
INSERT INTO `diet_history` VALUES (20, 2, 1, '早餐', '200', '2025-04-23 16:13:32');
INSERT INTO `diet_history` VALUES (21, 2, 67, '早餐', '200', '2025-04-24 16:19:23');
INSERT INTO `diet_history` VALUES (22, 2, 42, '中餐', '200', '2025-04-24 16:19:23');
INSERT INTO `diet_history` VALUES (23, 2, 68, '中餐', '500', '2025-04-24 16:19:55');
INSERT INTO `diet_history` VALUES (24, 2, 13, '中餐', '200', '2025-04-24 16:19:55');
INSERT INTO `diet_history` VALUES (25, 2, 68, '中餐', '500', '2025-04-26 13:48:14');
INSERT INTO `diet_history` VALUES (26, 2, 67, '早餐', '200', '2025-04-26 13:48:14');
INSERT INTO `diet_history` VALUES (27, 2, 10, '早餐', '500', '2025-04-26 13:48:14');
INSERT INTO `diet_history` VALUES (28, 2, 43, '中餐', '300', '2025-04-26 13:48:14');
INSERT INTO `diet_history` VALUES (29, 2, 1, '晚餐', '300', '2025-04-26 13:48:14');
INSERT INTO `diet_history` VALUES (30, 2, 65, '午餐', '200', '2025-05-14 21:57:35');
INSERT INTO `diet_history` VALUES (31, 2, 43, '晚餐', '300', '2025-05-14 21:57:35');
INSERT INTO `diet_history` VALUES (33, 2, 68, NULL, '500', '2025-05-16 11:04:33');
INSERT INTO `diet_history` VALUES (34, 2, 68, '午餐', '200', '2025-05-16 19:23:20');
INSERT INTO `diet_history` VALUES (35, 2, 67, '早餐', '200', '2025-05-16 19:23:20');
INSERT INTO `diet_history` VALUES (36, 2, 68, '午餐', '300', '2025-05-17 09:01:17');
INSERT INTO `diet_history` VALUES (37, 2, 67, '早餐', '200', '2025-05-17 09:01:17');
INSERT INTO `diet_history` VALUES (38, 29, 66, NULL, '10', '2025-06-17 17:41:52');
INSERT INTO `diet_history` VALUES (39, 29, 17, NULL, '3', '2025-06-17 17:41:52');
INSERT INTO `diet_history` VALUES (40, 29, 10, NULL, '2', '2025-06-17 17:41:52');
INSERT INTO `diet_history` VALUES (41, 2, 30, NULL, '10', '2025-06-19 23:03:59');

-- ----------------------------
-- Table structure for evaluations
-- ----------------------------
DROP TABLE IF EXISTS `evaluations`;
CREATE TABLE `evaluations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int NULL DEFAULT NULL COMMENT '父级评论ID',
  `commenter_id` int NULL DEFAULT NULL COMMENT '评论者ID',
  `replier_id` int NULL DEFAULT NULL COMMENT '回复者ID',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型',
  `content_id` int NULL DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '评论内容',
  `upvote_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '点赞列表，以\",\"分割',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluations
-- ----------------------------
INSERT INTO `evaluations` VALUES (1, NULL, 4, NULL, 'GOURMET', 4, '说的太好了！！\n', '3,4', '2025-04-19 22:41:25');
INSERT INTO `evaluations` VALUES (2, NULL, 4, NULL, 'GOURMET', 5, '学到了\n', NULL, '2025-04-19 22:41:48');
INSERT INTO `evaluations` VALUES (3, NULL, 4, NULL, 'GOURMET', 1, '说的真好\n', NULL, '2025-04-19 22:42:25');
INSERT INTO `evaluations` VALUES (4, 1, 3, NULL, 'NEWS', 4, '是的是的', NULL, '2025-04-19 22:43:22');
INSERT INTO `evaluations` VALUES (5, NULL, 5, NULL, 'GOURMET', 4, '说的不错', NULL, '2025-04-19 22:53:20');
INSERT INTO `evaluations` VALUES (6, NULL, 5, NULL, 'NEWS', 2, '好！', '5', '2025-04-19 22:53:46');
INSERT INTO `evaluations` VALUES (7, NULL, 5, NULL, 'NEWS', 5, '666', NULL, '2025-04-19 22:54:11');
INSERT INTO `evaluations` VALUES (8, NULL, 5, NULL, 'NEWS', 33, '6666', NULL, '2025-04-19 22:54:19');
INSERT INTO `evaluations` VALUES (9, NULL, 5, NULL, 'NEWS', 36, '不错', NULL, '2025-04-19 22:54:30');
INSERT INTO `evaluations` VALUES (10, NULL, 6, NULL, 'NEWS', 5, '太棒了！', NULL, '2025-04-19 23:06:57');
INSERT INTO `evaluations` VALUES (11, 7, 6, NULL, 'NEWS', 5, '777', NULL, '2025-04-19 23:07:04');
INSERT INTO `evaluations` VALUES (12, NULL, 6, NULL, 'NEWS', 1, '6666', NULL, '2025-04-19 23:07:18');
INSERT INTO `evaluations` VALUES (13, NULL, 4, NULL, 'NEWS', 1, 'xixi', NULL, '2025-04-19 23:38:55');
INSERT INTO `evaluations` VALUES (14, 13, 2, NULL, 'NEWS', 1, '(｡･∀･)ﾉﾞ嗨', NULL, '2025-04-19 23:39:48');
INSERT INTO `evaluations` VALUES (15, NULL, 4, NULL, 'NEWS', 2, '老铁666', NULL, '2025-04-20 00:14:59');
INSERT INTO `evaluations` VALUES (16, 13, 4, 2, 'NEWS', 1, '你好', NULL, '2025-04-20 00:19:00');
INSERT INTO `evaluations` VALUES (17, 13, 2, 4, 'NEWS', 1, '噜噜噜', NULL, '2025-04-20 00:19:47');
INSERT INTO `evaluations` VALUES (18, NULL, 2, NULL, 'NEWS', 67, 'HELLO', NULL, '2025-04-26 13:52:36');
INSERT INTO `evaluations` VALUES (19, NULL, 2, NULL, 'NEWS', 63, '你好呀~', NULL, '2025-04-26 13:52:48');
INSERT INTO `evaluations` VALUES (20, 13, 2, NULL, 'NEWS', 1, '111', NULL, '2025-05-16 18:53:44');
INSERT INTO `evaluations` VALUES (21, NULL, 2, NULL, 'NEWS', 5, '11', NULL, '2025-05-16 19:16:36');
INSERT INTO `evaluations` VALUES (22, 10, 2, NULL, 'NEWS', 5, '好的', NULL, '2025-05-16 19:16:45');
INSERT INTO `evaluations` VALUES (23, NULL, 2, NULL, 'NEWS', 1, '1111', NULL, '2025-05-16 19:20:28');
INSERT INTO `evaluations` VALUES (24, NULL, 29, NULL, 'NEWS', 70, '很不错', NULL, '2025-06-17 17:39:54');

-- ----------------------------
-- Table structure for evaluations_upvote
-- ----------------------------
DROP TABLE IF EXISTS `evaluations_upvote`;
CREATE TABLE `evaluations_upvote`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论点赞表ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `evaluations_id` int NULL DEFAULT NULL COMMENT '点赞ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluations_upvote
-- ----------------------------
INSERT INTO `evaluations_upvote` VALUES (55, 2, 13);
INSERT INTO `evaluations_upvote` VALUES (56, 2, 14);
INSERT INTO `evaluations_upvote` VALUES (57, 2, 12);
INSERT INTO `evaluations_upvote` VALUES (58, 3, 16);
INSERT INTO `evaluations_upvote` VALUES (59, 3, 17);
INSERT INTO `evaluations_upvote` VALUES (60, 3, 14);
INSERT INTO `evaluations_upvote` VALUES (61, 3, 13);
INSERT INTO `evaluations_upvote` VALUES (62, 3, 12);
INSERT INTO `evaluations_upvote` VALUES (63, 2, 16);
INSERT INTO `evaluations_upvote` VALUES (65, 2, 10);
INSERT INTO `evaluations_upvote` VALUES (66, 2, 23);

-- ----------------------------
-- Table structure for gourmet
-- ----------------------------
DROP TABLE IF EXISTS `gourmet`;
CREATE TABLE `gourmet`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '美食表主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `is_audit` tinyint(1) NULL DEFAULT NULL COMMENT '是否已经审核',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否公开',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '美食做法表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gourmet
-- ----------------------------
INSERT INTO `gourmet` VALUES (1, 2, 1, '2025两会聚焦：深化全民心理健康服务体系，共筑心理健康防护网', '<p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp; 在2025年全国两会期间，心理健康议题成为热议焦点。随着社会的快速发展，心理健康问题日益凸显，成为全民福祉的关键影响因素。代表委员们围绕心理健康议题提出了多项提案和建议，旨在通过国家政策和社会各界的努力，为全民心理健康提供坚实保障。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\">针对青少年心理健康，两会提出了多项具体措施：</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;全国政协委员翟美卿强调心理健康教育的重要性，呼吁通过立法确保其规范化实施。将心理健康纳入中小学必修课，并推动出台《中小学生心理健康促进法》，增设青春期身心一体健康教育专题课程，系统讲解青春期的身心变化及应对策略。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;人大代表陈玮指出性教育是青少年成长不可或缺的一部分，应得到足够重视。将性教育设为独立课程，系统教授性健康与人格塑造知识。课程应该涵盖性生理、性心理、性道德等多个维度，旨在帮助青少年建立正确的性观念。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;全国人大代表赵玉芳强调，青少年面临复杂的身心发展协同挑战，建议扩展心理健康教育课程内容，加入身心一体健康教育，并重点关注高风险群体。加强师资队伍建设，提升心理教师的专业素养和教学能力。按一定比例配齐专职心理教师，推动职称评定与专业培训。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;全国政协委员谢文敏建议，打造“家校医社”心理健康教育保障体系，加强经费保障，鼓励社会力量支持青少年心理健康服务。多方代表提议通过定期筛查和数据分析，及时发现并干预青少年的心理健康问题。开展常态化心理健康筛查，构建全国学生心理健康监测平台。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;多方代表提议通过立法手段推动各方共同关注青少年心理健康问题，形成全社会共同参与的格局。立法明确学校、家庭、政府的权责，如按比例配备心理教师，家长需完成年度心理健康培训等。家庭教育协会代表提议通过讲座等方式提升心理健康素养，并强调家长责任。教育心理学专家及教师工会代表提议提升教师队伍的心理专业素养，包括心理疏导能力，并组织法治教育与培训。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;企业员工福利协会等组织代表提议建立包括咨询、培训、危机干预在内的职场心理健康多方支持体系。提供心理咨询服务和心理健康培训，帮助职场人士应对压力、倦怠等问题，鼓励企业设立员工心理健康日，提高员工重视程度。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp; &nbsp;社区治理专家等代表提议试点社区心理驿站，推广智能分诊、在线咨询等经验。注重智慧健康养老应用平台的建设，提供家政、助餐、心理慰藉等服务。教育部门等相关部门代表提议将心理咨询和治疗纳入医保范围，减轻患者经济负担。并推动中小学心理健康教育立法，制定《国家心理健康促进法》，明确心理健康服务地位、职责和权益。加强师资队伍建设，丰富校园生活，提高公众重视程度，完善医疗体系。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp;心理科技应用研究等组织代表提议利用大数据、人工智能等技术手段，提供个性化的心理健康教育和干预方案；推广智能分诊、在线咨询与跨区域档案共享；研发VR情景模拟课程、心理咨询机器人等，提升服务可及性和趣味性。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp;2025年全国两会关于心理健康的提案和建议，展现了国家对全民心理健康的高度重视。从青少年到职场人士，从服务体系构建到科技赋能，每一项政策都在为全民心理健康铺路。强调了政府、社会、学校、企业和家庭等多方面的共同参与和协作。</span></p><p><span style=\"background-color: rgb(255, 255, 255);\"> &nbsp;华怡心辰公司作为一家专注于心理健康领域的公司，我们将积极响应国家号召，充分发挥自身优势，积极参与到全民心理健康事业中来。通过提供高质量的心理健康产品和服务，帮助更多人解决心理健康问题，提升他们的幸福感和获得感。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6d0e6df2.webp', 1, 1, '2025-04-19 20:59:09');
INSERT INTO `gourmet` VALUES (2, 2, 3, '女子狂“炫”几个紧急入院！有人拿它当早餐……', '<p><span style=\"font-family: 宋体;\">女子狂“炫”几个紧急入院！有人拿它当早餐…… 祭祖、踏青、品寒食是清明传统民俗作为清明时节的代表食物青团成为不少人近期餐桌上的“顶流”咸蛋黄肉松味、抹茶味、鲜花牛奶味……五花八门的青团让人食欲大开有些人还拿它当早饭然而，近日杭州的沈女士（化名）却因吃青团把自己吃进了医院↓↓↓</span></p><p><span style=\"font-family: 宋体;\">“狂炫”各种口味青团女子确诊急性胰腺炎</span></p><p><span style=\"font-family: 宋体;\">清明节前，杭州萧山的沈女士把每种口味的青团都吃了个遍，结果引发腹痛。</span></p><p><span style=\"font-family: 宋体;\">各种新式青团。</span></p><p><span style=\"font-family: 宋体;\">起初她以为是胃痛，直到在杭州市萧山区第二人民医院检查后才得知患上了急性胰腺炎，而且是高脂血症性急性胰腺炎，不得不住院三天。</span></p><p><span style=\"font-family: 宋体;\">医生解释，新式青团的馅料大多比传统青团更加高脂高糖，大量进食会导致血脂，尤其是甘油三酯急性增高，极易诱发急性胰腺炎。</span></p><p><span style=\"font-family: 宋体;\">急性胰腺炎发病急、进展快、并发症多如病情严重或治疗不当可能会危及生命</span></p><p><span style=\"font-family: 宋体;\">急性胰腺炎的常见症状</span></p><p><span style=\"font-family: 宋体;\">1. 腹痛：多表现为进食后不久突发持续性上腹部疼痛，甚至如刀割般绞痛，常向背部放射。</span></p><p><span style=\"font-family: 宋体;\">2. 恶心、呕吐及腹胀：多在起病后出现，可频繁发作，且呕吐后腹痛、腹胀不会缓解。</span></p><p><span style=\"font-family: 宋体;\">3. 发热：多有中度以上发热，持续3-5天。若胰腺发生坏死，则可能出现高热。</span></p><p><span style=\"font-family: 宋体;\">如何应对急性胰腺炎？</span></p><p><span style=\"font-family: 宋体;\">应急处理需注意停止进食：患者应立即停止进食，防止胰液分泌量增多，加重病情。及时就医：急性胰腺炎是一种急危重症，需专业医生进行诊断和治疗。一旦发现相关症状，应立即就医。缓解疼痛：帮助患者处于仰卧体位，双腿屈曲，减轻疼痛。</span></p><p><span style=\"font-family: 宋体;\">注意！当疼痛难忍时，切勿揉肚子，更不能吃止痛药。揉肚子可能促使炎症扩散、加重病情。服用麻醉性止痛药会掩盖腹痛症状，给医生的诊断增加困难。</span></p><p><span style=\"font-family: 宋体;\">保持呼吸道通畅：呕吐频繁者应注意保持呼吸道通畅，防止误吸。补液防脱水：急性胰腺炎患者常因呕吐、禁食等原因导致体液丢失过多，可给予补液、电解质平衡、维持酸碱平衡等治疗。</span></p><p><span style=\"font-family: 宋体;\">哪些因素易诱发？急性胰腺炎的发生与多种因素有关，其中不良生活习惯是主要诱因之一。高脂饮食、暴饮暴食、长期饮酒等都会增加患急性胰腺炎的风险。</span></p><p><span style=\"font-family: 宋体;\">记住这4点，健康享美味</span></p><p><span style=\"font-family: 宋体;\">适量食用青团通常高脂高糖，过多食用会刺激胃酸过度分泌，老人及肠胃病患者不宜多食。</span></p><p><span style=\"font-family: 宋体;\">选择馅料糖尿病患者和高血脂人群应避免含糖量高或脂肪含量高的馅料，如豆沙、枣泥、咸蛋黄肉松等。</span></p><p><span style=\"font-family: 宋体;\">注意食用时间糯米不易消化，晚上食用可能加重胃肠道负担。</span></p><p><span style=\"font-family: 宋体;\">特殊人群要小心胰腺炎、胃炎、胆囊炎、胆结石等患者以及胃肠功能敏感人群应谨慎食用青团，以免加重病情或引起不适。</span></p><p><span style=\"font-family: 宋体;\">幼儿需在家长看护下食用，谨防噎食。如不慎噎住，应立即采取海姆立克急救法进行处置。</span></p><p><span style=\"font-family: 宋体;\">如何正确使用海姆立克急救法？</span></p><p><span style=\"font-family: 宋体;\">1. “剪刀、石头、布”口诀剪刀：两个手指并拢，放在肚脐上方两横指的位置。石头：一手握拳，放在剪刀上方停住。布：另一只手变成布包住拳头，快速向内、向上冲击上腹部，直到异物排出。 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2.针对肥胖者和孕妇采用胸部冲击法。施救者站在患者背后，双臂从患者腋窝下环抱其胸部，右手握拳置于患者胸骨中部，另一手握紧此拳向后冲击数次，直至异物咳出。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=97f21d81.jpg', 1, 1, '2025-04-19 21:00:42');
INSERT INTO `gourmet` VALUES (3, 2, 8, '维生素B6，一旦缺乏有多可怕？警惕：皮肤出现4种异常，尽快补', '<p style=\"text-align: start;\">维生素很多人都知道，但很多人并不知道维生素B6缺乏有多么可怕？</p><p style=\"text-align: start;\"><strong>一、维生素B6，一旦缺乏有多可怕？</strong></p><p style=\"text-align: start;\">维生素B6是一种<strong>水溶性维生素</strong>，在红细胞内能转化为磷酸吡哆醛，能参与糖脂代谢、氨基酸和同型半胱氨酸的代谢、神经递质的产生等，还能作为辅酶参与碳水化合物、脂质及蛋白质的代谢。</p><p style=\"text-align: start;\">维生素B6的来源较为广泛，无论是动物性还是植物性食品中都有，其在<strong>肉类、全谷物、蔬菜以及坚果类食物</strong>中含量较为丰富。</p><p style=\"text-align: start;\"><strong>西医肿瘤内科主治医师吴丹</strong>表示，临床上严重缺乏维生素B6的情况现在已经很少见，一般都是轻度缺乏或与其他B族维生素同时缺乏。缺乏维生素B6可表现为<strong>脂溢性皮炎</strong>、唇口裂、口舌炎等症状，还可能会有抑郁、容易受刺激、神志错乱等<strong>精神症状</strong>。婴幼儿如果缺乏维生素B6可能会出现生长停止、惊厥、贫血、脑电图异常等，而孕妇如果缺乏维生素B6则可能会影响<strong>胎儿脑细胞发育</strong><span style=\"color: rgb(0, 0, 0);\">。</span></p><p style=\"text-align: start;\">常见的容易出现缺乏维生素B6的人群有患有乳糜泻、溃疡性结肠炎、类风湿性关节炎、克罗恩病等<strong>某些自身免疫性疾病的人</strong>，患有吸收不良综合征的人群、肾脏疾病患者，以及存在酒精依赖、正在服用某些抗癫痫药物的人。</p><p style=\"text-align: start;\"><strong>二、小小维生素B6，却能改善6种健康问题</strong></p><p style=\"text-align: start;\">生活中维生素B6的价格十分便宜，一瓶100片规格的维生素B6价格只需要几块钱到十几块不等，然后这么小小的一瓶维生素B6，竟然可以帮助改善多种健康问题。</p><p style=\"text-align: start;\"><strong>1、减轻妊娠呕吐</strong></p><p style=\"text-align: start;\">人体代谢过程中，随着蛋白质的分解会导致血液中氨基酸过多，从而刺激催吐化学感受区引发恶心、呕吐等症状，而维生素B6能够促进氨基酸的代谢，从而减轻呕吐症状。</p><p style=\"text-align: start;\"><strong>2、治疗皮肤病</strong></p><p style=\"text-align: start;\">临床上维生素B6在皮肤科的应用很广泛，对于脂溢性皮炎、唇炎、斑秃、痤疮、毛囊炎、口腔炎、雄激素性脱发等都有一定效果，还能用来辅助治疗红斑狼疮、白癜风等疾病。</p><p style=\"text-align: start;\"><strong>3、治疗原发性痛经</strong></p><p style=\"text-align: start;\">维生素B6能够提高子宫肌细胞内的镁离子浓度，减少对外界物质的刺激，让子宫肌更松弛一点，还能作为辅酶参与氨基丁酸合成，促进肌肉松弛，以此来降低子宫平滑肌张力。</p><p style=\"text-align: start;\"><strong>4、治疗经期前综合症</strong></p><p style=\"text-align: start;\">维生素B6能够通过调节自主神经系统、促进代谢、抑制催乳素合成等，来减轻经期前综合征。一般在临床上，会通过维生素B6联合氟西汀来治疗经期前综合征。</p><p style=\"text-align: start;\"><strong>5、高同型半胱氨酸血症</strong></p><p style=\"text-align: start;\">高同型半胱氨酸血症会增加动脉粥样硬化、心血管疾病的风险，更容易被脑卒中、痴呆等疾病盯上。而维生素B6能催化同型半胱氨酸分解代谢酶，遵医嘱用药能降低同型半胱氨酸水平。临床上一般推荐维生素B6和叶酸一起补充，但不建议长期服用，最好不要超过3个月。</p><p style=\"text-align: start;\"><strong>6、改善睡眠</strong></p><p style=\"text-align: start;\">维生素B6能帮助氨基酸代谢，参与了色氨酸（生理时钟氨基酸）的代谢，能够放松心情、帮助改善睡眠。</p><p style=\"text-align: start;\"><strong>三、科学补充维生素B6，注意这3点</strong></p><p style=\"text-align: start;\">维生素B6作为一种补充维生素的普通药物，使用不当可能会导致周围神经炎加重，甚至影响治疗效果，建议平常要正确认识并合理使用维生素B6。</p><p style=\"text-align: start;\"><strong>1、不同人群剂量</strong></p><p style=\"text-align: start;\">缺乏维生素B6的不同人群适合的剂量不同，<strong>一般成人建议一天10—20毫克，用药时间不要超过三周</strong>，好转后每天减量为2—5毫克；六月龄以下的婴儿每天0.1毫克，1—3岁的每天0.5毫克，4—6岁的每天0.6毫克，7-13岁的每天0.7—0.9毫克，14岁以上的每天1.1—1.2毫克。</p><p style=\"text-align: start;\"><strong>2、关注不良反应</strong></p><p style=\"text-align: start;\">补充维生素B6要小心过量，随时关注不良反应。<strong>孕妇</strong>如果过量服用维生素B6，胎儿出生后可能会出现兴奋、反复惊厥等症状，而且可能会导致<strong>婴儿出现短肢畸形</strong>的风险。</p><p style=\"text-align: start;\">长期大量摄入维生素B6可能会<strong>导致血栓形成</strong>，出现恶心、视力模糊、眩晕、头痛等症状，还可能引发<strong>低血糖、血清胆固醇升高、血栓性静脉炎</strong>等。</p><p style=\"text-align: start;\"><strong>3、药物相互作用</strong></p><p style=\"text-align: start;\">如果与雌激素同时服用，由于雌激素会降低维生素B6在体内的活性，因此要增加维生素B6用量。左旋多巴与小剂量维生素B6合用，可能会影响左旋多巴治疗帕金森病的疗效。</p><p style=\"text-align: start;\">另外，<strong>环磷酰胺、糖皮质激素、环孢素</strong>等药物可能会拮抗维生素B6，增加维生素B6的排泄，甚至引发周围神经炎或贫血等。</p><p style=\"text-align: start;\"><strong>4、可以多吃富含维生素B6的食物</strong></p><p style=\"text-align: start;\">维生素B6的动物性来源比植物性来源丰富，可以多吃鸡肉、鱼肉等白色肉类、动物肝脏、小麦、糙米等全谷物、坚果以及蛋黄等食物。</p><p style=\"text-align: start;\">维生素B6作为一种水溶性维生素，一旦缺乏可能会引发很多问题。适当补充维生素B6或许能改善多种健康问题，补充维生素B6一定要讲究科学合理，不同人群适合的剂量不同，还要注意药物间的相互作用。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d6ba7953.jpg', 1, 1, '2025-04-19 22:06:01');
INSERT INTO `gourmet` VALUES (4, 2, 10, '校园暴力的深层原因是什么？', '<p style=\"text-align: start;\">近段时间，“校园暴力”这个词已经几次刺痛了公众敏感的神经。先是某副县长之女率众对同校女生施暴，又来了个初二学生被十余中学生群殴当场昏迷，接着网上又开始轰轰烈烈地诉说着“布鞋门”。而“布鞋门”事件更是被拍成视频上传网络，使更多的人“欣赏”到了这场赤裸裸的校园版暴力电影。</p><p style=\"text-align: start;\">　　本是一方净土的校园，为何会成为斗殴行凶的集散地？原为手无缚鸡之力的“白面书生”，又为什么变得青面獠牙？为此，中国青年报记者(以下简称“记”)采访了国家级心理咨询师彭熠(以下简称“彭”)，以“布鞋门”事件为例，探讨了校园暴力产生的深层次原因。</p><p style=\"text-align: start;\">　　记：近一段时间不断有关于校园暴力的新闻传入耳中，暴力行为缘何频频在校园出现？</p><p style=\"text-align: start;\">　　彭：由于未成年人身心还没有发育成熟，所以，他们的行为很明显地带有模仿性和习得性，也就是说，他们本身的一些行为很可能是通过模仿、比照学来的。之所以产生暴力行为，很大程度上也是因为其模仿性在作怪。这种模仿首先可能来源于家庭，例如父母打骂孩子、夫妻吵架等家庭暴力。长此以往，孩子们很可能会不把暴力当回事，完全出于好玩的心理而见怪不怪。</p><p style=\"text-align: start;\">　　另外，网络游戏也是造成校园暴力的重要原因。网络游戏中有很多暴力元素，其中杀人、抢劫、打斗等情景很常见。青少年由于心理并未成熟，经常受网络暴力游戏的影响，久而久之就养成习惯，并慢慢开始对现实生活中的暴力行为习以为常。</p><p style=\"text-align: start;\">　　记：作为“布鞋门”事件的施暴者，她们并没有把“布鞋妹妹”打伤，而是采用了赤裸裸的人格侮辱方式，对此该如何看待？</p><p style=\"text-align: start;\">　　彭： “布鞋门”事件中施暴的女孩，其实都有一种扭曲的心理，她们并不以致受害人鲜血淋漓为目标，而是采取人格侮辱的方式，由此可见，她们的心理是非常扭曲的。这种心理的产生，很大程度上是因为其内心当中存在很大的愤怒，进而把“布鞋妹妹”当成了宣泄对象。受了欺负，就会找一个更弱小的对象去欺负，以解心头之恨。</p><p style=\"text-align: start;\">　　这种心理的产生很可能是因为她们在家庭中缺少关爱，在学校里缺乏老师、同学们的支持和鼓励。这种长期缺乏支持鼓励的孩子，其负面情绪积累后，就会产生愤怒感，于是，她们很可能会找一个宣泄物进行发泄。</p><p style=\"text-align: start;\">　　她们本身和“布鞋妹妹”并没有深仇大恨，如果把“布鞋妹妹”打伤，很可能受到法律制裁。采用人格侮辱这一“外表不见伤”的暴力行为，既能发泄自己的愤怒，同时又能避免受到严厉的惩罚。</p><p style=\"text-align: start;\">　　记：其中一个女孩对于外界针对自己的谩骂，持一种无所谓的态度。她说：“是我做错了，骂我是对的，我没什么可难过的。”</p><p style=\"text-align: start;\">　　彭：现在的教育无疑缺少了平等、尊重这一课。作为家长、老师，可能很少去尊重孩子们的意愿。一些孩子犯错误了，家长就会让孩子下跪认错；孩子考试成绩不理想，家长有可能就对孩子打骂，而这些完全是人格侮辱。久而久之，孩子们就会渐渐习惯，并在实际生活中加以运用，因为他们意识不到让人下跪、对人打骂是一种侮辱，反而会认为这很正常。</p><p style=\"text-align: start;\">　　记：这些孩子在围攻“布鞋妹妹”的同时，还有人用手机进行拍摄，并且传到了网上，怎么理解这种行为？</p><p style=\"text-align: start;\">　　彭：作为成年人都知道，打架是不对的，但这些女孩很可能是出于游戏心理，把打人当成了游戏。在拍摄视频的时候，她们也许会把这段视频当成一种可以炫耀的资本，这段视频在女孩手机中存了两个月，最后传到了网上。她之所以保存这段视频，可能就是想拿出来炫耀。从这点可以看出，她们平时可能很少有值得炫耀的东西，如学习成绩、老师的表扬等。</p><p style=\"text-align: start;\">　　在她们的内心，其实是非常希望被别人赏识、看重的。而在现实生活中，如果她们的成绩不好，老师可能就会把她们评为差等生，家人也可能不喜欢她们。所以，她们也只好用这一点儿自认为可以炫耀的东西让别人对自己高看一眼，因为别人做不到、拍不到的东西，自己能办到。</p><p style=\"text-align: start;\">　　记：在“布鞋门”事件中，还有一些孩子完全是出于一种“凑热闹”的心理来参与的，这种心理是什么原因造成的呢？</p><p style=\"text-align: start;\">　　彭：孩子们都有自我保护的心理，这不难理解。在她们的心中可能有两种想法：首先，如果我不打她，别人会不会怀疑是我偷了东西；其次，如果我不动手，是不是就会被大家看不起，被孤立起来。</p><p style=\"text-align: start;\">　　记：这样的事情发生后，我们的家庭、学校应该进行哪些方面的反思？</p><p style=\"text-align: start;\">　　彭：作为学校，必须提高教师和学生们的法制意识。在这次事件中，我们发现很多老师的法制意识非常淡薄，并没有把学生打架提到一个很高的高度去认识。所以，学校应该多对老师和学生进行法制教育，使正处于青春期的孩子们在心里形成一种平衡机制，从而控制好自己的行为，避免给他人造成伤害。</p><p style=\"text-align: start;\">　　家长、学校在关注学生成绩的同时，还应更多地重视孩子的心理健康。孩子们的心理很脆弱，需要老师、家长的引导帮助，这一点如果重视不够，可能导致孩子们产生扭曲心理。现在，出现了很多高智商、低情商的学生，就说明我们的教育确实出了问题，所以，学校、家庭乃至社会应该多关注孩子们的人格培养，关心孩子们的情商教育。</p><p style=\"text-align: start;\">　　拍视频的孩子可能仅仅把这当成了游戏，主观上并不存在很大的恶意。这种行为的悲哀之处，就在于她不懂得尊重人，自身也没有一个健全的人格来控制自己的行为。而平等、尊重的观念，是一个人的人格中应具备的基本要素。如果我们的教育不重视对孩子人格、情商的培养，那么，在这种教育体制的影响下，孩子们就会产生很多问题，有的问题甚至会影响到他们的下一代。由此可见，其实“布鞋门”事件中打人的孩子，本身也是受害者。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b6794bb4.webp', 1, 1, '2025-04-19 22:09:24');
INSERT INTO `gourmet` VALUES (5, 2, 6, '为什么换个环境鼻炎就好了', '<p style=\"text-align: start;\">换个环境鼻炎就好了，可能是因为环境因素所致，但也可能是因为过敏性鼻炎、鼻窦炎等原因引起的。</p><p style=\"text-align: start;\">1、环境因素</p><p style=\"text-align: start;\">如果患者突然换个环境，可能会导致鼻腔里面的环境发生改变，从而出现鼻炎好了的情况。患者可通过佩戴口罩的方式使症状得到缓解，也可在医生的指导下使用糠酸莫米松鼻喷雾剂、布地奈德鼻喷雾剂等药物进行治疗。</p><p style=\"text-align: start;\">2、过敏性鼻炎</p><p style=\"text-align: start;\"><span style=\"color: rgb(51, 51, 51);\">过敏性鼻炎通常是因为环境的因素所致，如果患者换环境后，接触到过敏原，可能会导致过敏性鼻炎发作，从而出现鼻痒、打喷嚏等症状。患者可在医生的指导下口服盐酸左西替利嗪片、氯雷他定片等药物进行治疗，也可以在医生的指导下使用丙酸氟替卡松鼻喷雾剂、糠酸莫米松鼻喷雾剂等药物进行治疗。</span></p><p style=\"text-align: start;\">3、鼻窦炎</p><p style=\"text-align: start;\">鼻窦炎通常是因为细菌感染所致，如果患者换环境后，接触到细菌感染的环境，可能会导致鼻窦炎发作，从而出现鼻塞、流脓涕等症状。患者可在医生的指导下口服阿莫西林胶囊、头孢克肟胶囊等药物进行治疗，也可以遵医嘱使用丙酸氟替卡松鼻喷雾剂、布地奈德鼻喷雾剂等药物进行治疗。</p><p style=\"text-align: start;\">除了以上因素，还可能是因为鼻息肉等原因引起的。患者应及时前往医院就诊，查明原因后进行规范化治疗。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=00161c15.webp', 1, 1, '2025-04-19 22:12:22');
INSERT INTO `gourmet` VALUES (6, 4, 6, 'Alzheimers Dementia：空气污染，或可增加痴呆风险，但维生素B或可缓解', '<p style=\"text-align: start;\">目前，全世界有近5000万人患有痴呆症，到2050年这一数字可能会增加两倍。虽然目前还没有治愈痴呆症的方法，但通过改变风险因素来预防，有可能遏制痴呆症患者人数的增加。因此，在过去的几十年里，人们已经采取了具体措施，以确定可改变的痴呆症风险因素，如环境污染和饮食。</p><p style=\"text-align: start;\">暴露于直径小于2.5微米的环境细颗粒物（PM2.5）已被越来越多的人认为是老年人痴呆症的一个新的环境风险因素。最近的研究报告显示，接触PM2.5与脑萎缩、认知障碍以及阿尔茨海默病和痴呆症的高风险有关。</p><p style=\"text-align: start;\">尽管PM2.5神经毒性的潜在分子机制还没有被完全理解，但以前的研究发现PM2.5暴露与同型半胱氨酸之间存在正相关，这是一个独立于社会人口、生活方式、病史和脂蛋白E（APOE）遗传易感性的强大的痴呆症风险因素。据推测，微粒空气污染物可能通过破坏同型半胱氨酸向蛋氨酸的再甲基化而增加同型半胱氨酸水平。</p><p style=\"text-align: start;\">终身营养也可能对大脑功能有直接影响。以前的纵向研究报告了某些营养素，包括B族维生素，与大脑萎缩和认知能力下降的关联，一些临床试验证实了这些结果。在八种B族维生素中，有三种特别值得关注，因为它们在高半胱氨酸代谢中发挥着重要作用。叶酸和维生素B12是高半胱氨酸再甲基化所需的辅助因子，而维生素B6在将高半胱氨酸转化为半胱氨酸的反硫化途径中是必需的。</p><p style=\"text-align: start;\">因此，生理上的同型半胱氨酸水平主要由饮食中摄入的叶酸、维生素B12或维生素B6决定。这三种营养素的降低同型半胱氨酸的作用已在补充单种或多种B族维生素的随机对照试验中得到充分证明。</p><p style=\"text-align: start;\">藉此， 哥伦比亚大学的Cheng Chen等人假设高水平的叶酸、维生素B12和/或维生素B6可能通过降低PM2.5暴露诱发的高半胱氨酸水平来抵消PM2.5的潜在神经毒性。这一假设得到了先前一项研究的支持，该研究报告称，在比较血浆叶酸和维生素B12浓度较高和较低的个体时，暴露于交通相关颗粒物与总同型半胱氨酸水平的关联有所不同；仅在这两种B族维生素浓度较低的个体中观察到正相关。</p><p style=\"text-align: start;\">这项研究包括7183名65至80岁的社区居住妇女，这些妇女被纳入在妇女健康倡议（WHI）记忆研究（WHIMS）中，她们没有发生全因痴呆症。</p><p style=\"text-align: start;\">他们藉此系统探究了叶酸、维生素B12或维生素B6的摄入量与全因痴呆症发病率之间的关系。</p><p style=\"text-align: start;\">这项研究纳入了7183名基线年龄在65至80岁的妇女。通过基线时的食物频率调查表估计饮食和补充剂中的B族维生素摄入量。使用时空模型估计3年的平均PM2.5暴露。</p><p style=\"text-align: start;\">在平均9年的随访中，342名参与者患上了全因性痴呆症。</p><p style=\"text-align: start;\">居住在PM2.5暴露量超过监管标准（12 μg/m3）的地方，仅在这些B族维生素摄入量较低的参与者中与较高的痴呆风险有关。</p><p style=\"text-align: start;\">该研究表明：PM2.5暴露的神经毒性可能被高B族维生素摄入量所减弱。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3173b066.jpg', 1, 1, '2025-04-19 22:14:51');
INSERT INTO `gourmet` VALUES (7, 4, 8, '不少人问：血压高到多少会发生脑出血？医生给出参考值，心里有数', '<p style=\"text-align: start;\">高血压长期控制不好可能会引发脑出血或脑梗死，那血压高到什么程度可能会引发脑出血呢？</p><p style=\"text-align: start;\"><strong>一、高血压如何引起脑梗死和脑出血？</strong></p><p style=\"text-align: start;\">脑梗死即<strong>缺血性脑卒中</strong>，是各种脑血管病变引发脑部血液障碍，从而导致<strong>局部脑组织缺血、缺氧坏死。</strong></p><p style=\"text-align: start;\">脑出血即<strong>出血性脑卒中</strong>，是非外伤性的脑实质内出血，多见于高血压合并小动脉硬化，由于长期的高血压导致脑细小动脉变性坏死，<strong>血压突然升高引发了血管破裂出血。</strong></p><p style=\"text-align: start;\">那高血压是如何引起脑梗死和脑出血的呢？</p><p style=\"text-align: start;\"><strong>河北省人民医院郭艺芳</strong>指出：<strong>高血压长期得不到控制会导致血管内膜破损</strong>，胆固醇趁机进入，慢慢会形成斑块，导致<strong>血管腔变狭窄</strong>，从而发生脑缺血。<strong>斑块突然破裂还可能形成血栓</strong>，导致血管腔严重闭塞，引发脑梗死。</p><p style=\"text-align: start;\">另外，高血压长期得不到控制，会使<strong>血管持续扩张变得更硬更脆</strong>，甚至没有弹性，时间长了血压突然升高，<strong>就可能导致血管破裂</strong>，引发脑出血。</p><p style=\"text-align: start;\"><strong>二、血压多高会诱发脑出血？3条红线需警惕</strong></p><p style=\"text-align: start;\">人体理想的血压应该是收缩压小于120mmHg，舒张压小于80mmHg，<strong>120—139/80-89mmHg就属于正常高值血压了</strong>，血压值处于这个范围内的人群日后被高血压盯上的风险更高。</p><p style=\"text-align: start;\">事实上，血压值和脑出血之间并没有一定固定的数值门槛。但高血压有三条“红线”，一定要提高警惕！</p><p style=\"text-align: start;\"><strong>1、警戒线</strong></p><p style=\"text-align: start;\"><strong>广东省人民医院、中山大学第一附属医院</strong>研究发现：年轻人血压大于等于120/80mmHg，就处于警戒范围。</p><p style=\"text-align: start;\">研究发现收缩压超过120mmHg的人，血压每升高10mmHg，就比正常人脑出血风险增加61%。老年人的血压警戒线则是超过140/90mmHg，超过这个范围的一定要提高警惕。</p><p style=\"text-align: start;\"><strong>2、危险线</strong></p><p style=\"text-align: start;\">高血压根据血压值可以分为<strong>一级高血压、二级高血压和三级高血压</strong>三种。</p><p style=\"text-align: start;\"><strong>一级高血压</strong>一般高压在140~160mmHg之间，低压在90~100mmHg之间，可通过调整生活习惯控制血压，必要时遵医嘱用药；</p><p style=\"text-align: start;\"><strong>二级高血压</strong>一般高压在160~180mmHg之间，低压在100~110mmHg之间，需及时遵医嘱用药治疗；</p><p style=\"text-align: start;\"><strong>三级高血压</strong>高压大于180mmHg，或低压在110mmHg以上，可能会引发各种病变，需及时干预治疗。</p><p style=\"text-align: start;\"><strong>3、极线</strong></p><p style=\"text-align: start;\">人的血压是有极线的，人体血压最高达到<strong>250/140mmHg</strong>时，可能会引发急性心脑血管病变，必须马上就医治疗。</p><p style=\"text-align: start;\">高血压人群如果有<strong>头痛、头晕、肢体麻木无力、蒙黑、呛咳等不适症状</strong>出现，要警惕是脑出血的早期信号，一定要尽早就医排查！</p><p style=\"text-align: start;\"><strong>三、高血压者手指出现3个异常，谨防脑梗</strong></p><p style=\"text-align: start;\"><strong>广州医科大学附属第二医院心血管科主任医师张双伟</strong>提醒：高血压并非无迹可循，如果高血压患者手指出现了下面几个异常，要警惕脑梗发作！</p><p style=\"text-align: start;\"><strong>1、手指无力或发抖</strong></p><p style=\"text-align: start;\">高血压患者如果肌力下降、神经传导受到干扰，就可能无法提起重物，从而出现手指无力或发抖的症状。</p><p style=\"text-align: start;\"><strong>2、手指僵硬、不够灵活</strong></p><p style=\"text-align: start;\">手指好好的变僵硬、不灵活了，要警惕脑梗，因为大脑控制着人体的感觉和运动，一旦大脑血液循环受阻出现缺血、缺氧，就可能会影响运动、感觉功能，从而导致手部活动受到影响。</p><p style=\"text-align: start;\"><strong>3、手指发麻</strong></p><p style=\"text-align: start;\">高血压患者如果出现持续性的手指发麻，休息无法缓解，要警惕急性脑梗或脑出血。因为手指处于神经末梢，体内血管被堵会导致手指出现异常症状。</p><p style=\"text-align: start;\"><strong>四、高血压患者预防脑梗脑出血，牢记5点</strong></p><p style=\"text-align: start;\">高血压作为心脑血管病的高危因素，严重的可能会引发脑出血并发症，高血压患者一定要做好脑出血的预防！</p><p style=\"text-align: start;\"><strong>1、健康合理饮食</strong></p><p style=\"text-align: start;\">高血压患者要少吃钠盐、肥肉等，保证合理膳食，多吃新鲜蔬果和粗纤维食物等。</p><p style=\"text-align: start;\"><strong>2、养成良好的生活习惯</strong></p><p style=\"text-align: start;\">平常要保持乐观的心态，保证睡眠充足，避免过度劳累，还要预防摔倒，注意做好保暖措施等。</p><p style=\"text-align: start;\"><strong>3、自我监测血压</strong></p><p style=\"text-align: start;\">平常要定期监测自己的血压，选择一个安静的环境、在情绪平稳时测压，并做好记录。</p><p style=\"text-align: start;\"><strong>4、遵医嘱服用降压药</strong></p><p style=\"text-align: start;\">高血压患者服用降压药要遵医嘱，避免随意停药，以免导致血压波动，甚至被脑梗、脑出血等意外盯上。</p><p style=\"text-align: start;\"><strong>5、坚持运动</strong></p><p style=\"text-align: start;\">适当进行中等强度的有氧运动，像骑车、快走、太极拳等都是不错的选择。</p><p style=\"text-align: start;\">高血压虽然是一种常见的慢性病，但长期控制不佳可能会引发严重的并发症，因此一定要重视高血压。</p><p style=\"text-align: start;\">要随时关注身体异常症状，警惕脑出血来袭，平常要做好脑出血的预防。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=05fb5b57.jpg', 1, 1, '2025-04-19 22:16:44');
INSERT INTO `gourmet` VALUES (8, 4, 3, 'Clin Nutrition：Omega-3脂肪酸、类胡萝卜素和维生素E补充剂可改善老年人的记忆力', '<p style=\"text-align: start;\">由于阿尔茨海默病 (AD) 的患病率不断增加，以及其相关的经济、社会和护理负担的不断加重，全球目前现在正将重点放在此病的预防策略上，以延缓其发病并降低患上这种疾病的风险。越来越多的证据表明，良好的营养（例如水果、蔬菜、鱼）和健康的饮食模式对于提高认知能力很重要，并且与降低患 AD 的风险有关。一些饮食成分选择性地积聚在大脑中，发挥重要的生理功能。这些包括 omega-3 脂肪酸 (ω-3FAs)，叶黄素类胡萝卜素（含氧、植物性色素）和维生素E。总体而言，这些营养素可以独立发挥作用以提高患者的认知能力，这主要是由于它们的抗氧化和抗炎特性导致的。有趣的是，先前的探索性工作表明，ω-3FA 二十二碳六烯酸 (DHA) 和叶黄素类胡萝卜素叶黄素的组合可以协同作用以提高老年女性的认知能力，因此，本项研究旨在检查ω-3FA（即 DHA 和二十碳五烯酸 [EPA]）、叶黄素类胡萝卜素（特别是叶黄素、玉米黄质）组合的潜在协同效应和维生素 E ( d-α-生育酚）对老年人的认知表现的影响。</p><p style=\"text-align: start;\">本项研究是一项双盲、安慰剂对照、随机临床试验，研究人员对≥65岁的认知健康个体进行了饮食干预，一部分患者每天摄入 1 克鱼油（其中有430 毫克二十二碳六烯酸、90毫克二十碳五烯酸）、22 毫克类胡萝卜素（10 毫克叶黄素、10 毫克玉米黄质）和 15 毫克维生素 E，一部分患者接受安慰剂饮食治疗。在随访24个月后统计患者的认知变化水平。</p><p style=\"text-align: start;\">本项研究共纳入30名受试者，年龄平均 69.7岁，70 %为女性，在改变饮食模式 24 个月后，研究人员发现随着工作记忆任务的认知负荷增加，治疗组的表现优于安慰剂组。与安慰剂相比，在治疗组中也观察到组织类胡萝卜素浓度、血清叶黄素类胡萝卜素浓度和血浆 ω-3FA 浓度的显着改善（点估计效应大小范围为 0.078-0.589）。此外，组织中类胡萝卜素浓度的变化幅度最为明显，而这部分老人的记忆力改善情况也是最为明显的，远优于安慰剂组患者。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8ee8d868.jpg', 1, 1, '2025-04-19 22:19:14');
INSERT INTO `gourmet` VALUES (9, 4, 6, '保护环境，人人有责——改善空气质量，减少老年痴呆！', '<p style=\"text-align: start;\">目前，认知功能障碍已成为威胁老年人群健康以及生活质量的重要原因，给家庭和社会带来巨大负担。空气污染是被最新证实的痴呆症可调控风险因素。既往多项观察性研究的结果显示，长期暴露于细颗粒物（如PM2.5）与认知功能损害、痴呆症以及其他神经系统疾病的发生及发展存在相关性。</p><p style=\"text-align: start;\">此前，北京大学国家发展研究院健康与老龄发展研究中心团队在《柳叶刀-老龄健康》期刊发表重要研究成果，通过改善空气质量可以延缓老年人群衰退。为此，来自美国的科学家研究了空气质量的改善是否与74至92岁的老年妇女认知能力下降的速度减慢有关，结果发表在PLOS MEDICINE杂志上。</p><p style=\"text-align: start;\">研究人员研究了居住在美国48个毗连州的2232名妇女的队列。他们在2008至2012年的基线上没有痴呆症。对年度（2008年至2018年）认知功能的测量包括TICSm和CVLT。使用区域化的通用克里格模型来估计居民点的PM2.5和NO2的年度浓度。使用线性混合效应模型来研究空气质量改善与TICSm和CVLT轨迹的认知下降率之间的关系。</p><p style=\"text-align: start;\">对于PM2.5和NO2，空气质量在WHIMS-ECHO入组前的10年里有明显的改善。在中位数6.2年（IQR=5.0）的随访期间，观察到一般认知状态（β=-0.42/年，95%CI：-0.44，-0.40）和外显记忆（β=-0.59/年，95%CI：-0.64，-0.54）都有下降。</p><p style=\"text-align: start;\">总的来说，更大的空气质量改善与TICSm的下降速度有关（βPM2.5改善=0.026/年，PM2.5改善的每个IQR=1.79μg/m3减少，95%CI：0.001，0.05；βNO2改善=0.034/年，NO2改善的每个IQR=3.92亿分之[ppb]减少，95%CI：0. 01， 0.06）和CVLT（βPM2.5改善=0.070/年，每IQR=1.79μg/m3减少，95%CI：0.02， 0.12；βNO2改善=0.060/年，每IQR=3.97 ppb减少，95%CI：0.005， 0.12）。</p><p style=\"text-align: start;\">与TICSm和CVLT的各自关联等同于发现的0.9至1.2岁和1.4至1.6岁的较慢下降速度，并且在年龄、地区、教育、载脂蛋白E（ApoE）e4基因型或心血管风险因素方面没有明显的差异。</p><p style=\"text-align: start;\">综上，晚年长期空气质量的更大改善与老年妇女的认知能力下降较慢有关。这个新的观察结果加强了空气污染和认知老化之间的流行病学证据。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=64355c49.jpg', 1, 1, '2025-04-19 22:20:01');
INSERT INTO `gourmet` VALUES (10, 4, 10, '青少年腰痛 小心强脊炎', '<p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\"> &nbsp; &nbsp; &nbsp; &nbsp;当一些青少年向家人述说“腰痛”时，常会得到这样的回答：“小孩没腰没背，那会腰痛，睡一夜就没事了”在日常的习惯思维中，腰痛是大人才有的病。其实有一种叫做</span><a href=\"http://jbk.39.net/keshi/neike/fengshi/4fab0.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">强直性脊柱炎</span></a><span style=\"color: rgb(0, 0, 0);\">的疾病，90%以上发生在年轻男性中，严重的可引起脊柱畸形。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">　　强直性脊柱炎是一种慢性进</span><a href=\"http://baike.39.net/2000-2800-2804-91/\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">行</span></a><span style=\"color: rgb(0, 0, 0);\">性炎性疾病，主要侵犯骶髂关节、脊柱骨突、脊柱旁软组织及外周关节，多发于15-30岁的青少年男子(男比女多11倍)。早期表现为腰部僵硬、酸痛、沉困，以夜间、清晨疼痛明显，久坐、久站加重，活动</span><a href=\"http://hzpk.39.net/pinpai/86394.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">后</span></a><span style=\"color: rgb(0, 0, 0);\">减轻。有些病人还伴有髋、膝、踝关节肿痛，臀部、腹股沟疼痛，颈背部沉痛，</span><a href=\"http://zzk.39.net/zz/toubu/yan/4ff87.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">红眼</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://zzk.39.net/zz/sizhi/xiazhi/a9d19.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">足跟痛</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://zzk.39.net/zz/qita/a6216.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">低热</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://zzk.39.net/zz/quanshen/a62f6.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">乏力</span></a><span style=\"color: rgb(0, 0, 0);\">等。由于本病起病进展缓慢，开始时的腰痛为间歇性，全身症状较轻，数月或数年后才发展为持续性，所以早期的强直性脊柱炎患者常被忽视或误诊。随着病情的进一步发展，病人出现“鸭步”、臀部后隆、平腰，甚至出现</span><a href=\"http://zzk.39.net/zz/beibu/a94fd.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">驼背</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://baike.39.net/2000-2600-2605-57/\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">腰椎</span></a><span style=\"color: rgb(0, 0, 0);\">及髋关节活动受限等状态，导致生活不能自理，丧失劳动力，致残率在30%以上。由于本病以上症状特殊，常被误诊为</span><a href=\"http://jbk.39.net/keshi/neike/fengshi/5fe4c.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">风湿性关节炎</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://jbk.39.net/keshi/waike/guke/4cca5.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">腰椎间盘突出</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"http://jbk.39.net/keshi/neike/shenjing/49018.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">坐骨神经痛</span></a><span style=\"color: rgb(0, 0, 0);\">、关节结核、滑膜炎、</span><a href=\"http://jbk.39.net/keshi/waike/guke/696b3.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">骨质增生</span></a><span style=\"color: rgb(0, 0, 0);\">等病。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">　　对本病的病因，现代医学尚未找到明确的答案，大多认为与遗传、感染、环境因素、</span><a href=\"http://baike.39.net/6000-6200-6201-71/\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">免疫</span></a><span style=\"color: rgb(0, 0, 0);\">等有关，所以在治疗上，主要采用</span><a href=\"http://baike.39.net/2000-2800-2801-44/\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">药物</span></a><span style=\"color: rgb(0, 0, 0);\">和功能锻炼，晚期</span><a href=\"http://hzpk.39.net/pinpai/5bd09.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">可采</span></a><span style=\"color: rgb(0, 0, 0);\">用手术矫正。本病的预后好坏，早诊断、早治疗是关键。青少年一旦出现腰髋疼痛三个月以上不能缓解者，应警惕是否患可此病，尤其有类似家族病史者需及时检查。X线检查对本病的诊断有极为重要的意义，约98%-100%的</span><a href=\"http://baike.39.net/2000-2600-2601-34/\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">病例</span></a><span style=\"color: rgb(0, 0, 0);\">有骶骼关节的X线改变，是本病诊断的重要依据。早期可疑患者，应做HLA-B27(组织相容性抗原B27)测定，若为阳性，对早期确诊有一定的帮助。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">　　另外还有一些能引起青少年</span><a href=\"http://jbk.39.net/keshi/waike/waishang/48f28.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">腰腿痛</span></a><span style=\"color: rgb(0, 0, 0);\">的疾病需加以排除，如腰骶关节劳损、结核性脊柱炎、瑞特综合征等。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">　　青少年时期是生长发育的重要时期，也是学习、生活最</span><a href=\"http://zzk.39.net/zz/qita/a6518.html\" target=\"_blank\"><span style=\"color: rgb(0, 0, 0);\">紧张</span></a><span style=\"color: rgb(0, 0, 0);\">时期，对自己断断续续或持续出现的腰痛不愿提起或提起后被家人忽视，都是对早期诊断、治疗不利的。在这里提醒大家，青少年的腰腿痛应及时诊治，让他们有一个健康的身体。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=99ad58710.jpg', 1, 1, '2025-04-19 22:21:10');
INSERT INTO `gourmet` VALUES (11, 4, 6, '睡眠环境越黑越好吗', '<p style=\"text-align: start;\">睡眠环境越黑越好，因为较暗的环境有利于褪黑激素的分泌，从而帮助改善睡眠质量。</p><p style=\"text-align: start;\">较暗的睡眠环境能够减少外界光线干扰，促使体内褪黑激素水平升高，该激素具有抑制觉醒的作用，可诱导人进入深睡眠状态。但需要注意的是，如果睡眠环境过于黑暗，可能导致视力适应能力下降，增加跌倒的风险，尤其是老年人及行动不便者。</p><p style=\"text-align: start;\">睡眠环境的亮度因个体差异而异，通常建议在舒适的范围内调节灯光亮度以确保安全和舒适性。</p><p style=\"text-align: start;\">为了优化睡眠质量，应避免使用蓝光电子设备，并在睡前保持规律作息时间，有助于建立良好的睡眠习惯。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1f690ee11.jpg', 1, 1, '2025-04-19 22:22:40');
INSERT INTO `gourmet` VALUES (12, 4, 7, '职场健康隐患8大坏习惯 怎样改正？', '<p style=\"text-align: start;\"><strong>一、饮食不规律，不吃早餐</strong></p><p style=\"text-align: start;\">　　一日三餐，规律的饮食习惯，是人类在长期的生活中所形成的，是维持人体生命健康的基本生理需要。很多上班族饮食习惯不良，如不吃早餐、饥一顿饱一顿、三餐饮食不均衡或暴饮暴食等都是有损健康的。</p><p style=\"text-align: start;\"><strong> 长期饮食不规律有哪些危害？</strong></p><p style=\"text-align: start;\">　　1、不吃早餐诱发胃肠疾病</p><p style=\"text-align: start;\">　　饮食不规律，不吃就不吃，一吃起来就吃太饱，会打乱胃肠消化的生物钟。当不吃早餐，或饥饿时，胃酸等消化液分泌后得不到食物中和，从而胃酸可侵蚀胃黏膜，加上幽门螺杆菌的感染，可引起急慢性胃炎、胃和十二指肠溃疡等疾病。另外暴饮暴食，可引起急性胃扩张，严重损害胃肠功能。</p><p style=\"text-align: start;\">　　2、饮食不规律引起营养失衡</p><p style=\"text-align: start;\">　　由于饮食不规律，或经常不吃早餐，或饮食不均衡，不能给身体提供足够的能量和营养，久而久之，会导致皮肤干燥、贫血、细胞衰老等营养缺乏症状。</p><p style=\"text-align: start;\">　　有调查指出，有饮食不规律不良习惯的人，骨骼密度远远低于规律饮食的人，对已发生骨质疏松的人来说，饮食不规律是主要原因之一。</p><p style=\"text-align: start;\">　　3、饮食不规律的其他危害</p><p style=\"text-align: start;\">　　在三餐定时情况下，人体内会自然产生胃结肠反射现象，可使排便规律，有利身体内代谢产物的排出；如饮食不规律、不吃早餐等，可造成胃结肠反射作用失调，产生便秘等症状，身体排毒不畅，容易引起皮肤疾病，如痤疮等。</p><p style=\"text-align: start;\"><strong> 专家建议：</strong></p><p style=\"text-align: start;\">　　1、注意饮食规律。科学饮食规律即定时、定量进食，不吃或少吃零食。</p><p style=\"text-align: start;\">　　2、科学地分配三餐热量，早餐吃好，午餐吃饱，晚餐吃少。</p><p style=\"text-align: start;\">　　3、注意饮食均衡，合理膳食；不合理、不科学的饮食或营养结构会导致肥胖的发生。</p><p style=\"text-align: start;\">　　4、饮食与运动相结合，进食量与体力活动要平衡，保持适宜体重。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dcc754012.jpg', 1, 1, '2025-04-19 22:24:03');
INSERT INTO `gourmet` VALUES (13, 4, 5, '正确的美妆步骤是如何进行的？', '<p style=\"text-indent: 2em; text-align: start;\">生活中有不少刚开始学化妆的女性可能不知道从哪里下手，的确自己以前也没有学过美妆的相关课程，不会化妆也是正常的。我们知道美妆是需要遵循一定的步骤，那么正确的美妆步骤分为哪几步呢？接下来就大家为大家介绍的就是美妆的详细步骤。</p><p style=\"text-indent: 2em; text-align: start;\">美妆步骤：</p><p style=\"text-indent: 2em; text-align: start;\">第一步，先做好底妆，我们把妆前乳点在脸上，不要点太多黄豆粒大小就行。然后用粉扑或者美妆蛋轻轻的晕开，用拍打的方式不要用揉搓，因为肌肤会吸收不了。</p><p style=\"text-indent: 2em; text-align: start;\">第二步，上bb霜，也跟第一步一样，用点拍的方式把它涂在脸上，工具也是粉扑或者美妆蛋。用的量一定要合适，用太多的话会显得死白，我们在选着bb霜的时候，一定要选择跟肤色相近的。</p><p style=\"text-indent: 2em; text-align: start;\">第三步，画眉毛，在选择眉笔的时候，要跟发色相近。在画的时候，我们先找到眉头、眉峰和眉尾，然后用笔把它们三点起来，轻轻地勾勒出眉形，然后用眉刷刷几下就会自然一些。</p><p style=\"text-indent: 2em; text-align: start;\">第四步，先找一个合适的眼影上色，根据今天想要的妆容，选择一个自己喜欢的颜色涂在眼皮上。然后画眼线，画的方法有很多种，建议大家从中间画到尾部，前半部分就不要画，因为很考验技术。然后是涂睫毛膏，选择一款刷头小一点的，这样苍蝇就会少一些，显得很自然。</p><p style=\"text-indent: 2em; text-align: start;\">第五步，涂口红，选择一款适合自己的颜色，在上下唇的中间涂一点，然后慢慢抿开，这样就是很简单的一个口红画法。在所有的妆容都画完后，我们再涂上粉饼定妆，这样一个精致的彩妆就完成了。</p><p style=\"text-indent: 2em; text-align: start;\">可以看出正确的美妆步骤分为5步，分别是做好底妆、涂抹bb霜、画眉毛、寻找一个适合自己的眼影、涂口红，希望每一位女性在给自己化妆的时候都能按照这些步骤进行，这样妆容画出来一定非常惊艳。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2c320ae13.webp', 1, 1, '2025-04-19 22:25:24');
INSERT INTO `gourmet` VALUES (14, 4, 4, '孕妇专用护肤品排行榜有哪些护肤品', '<p style=\"text-align: start;\">一般情况下，孕妇专用护肤品排行榜如下：</p><p style=\"text-align: start;\">妊娠期间，孕妇的皮肤状态可能会发生改变，这可能与体内激素水平的变化、皮肤干燥、皮肤敏感等因素有关。建议孕妇选择适合孕妇使用的护肤品，以保证皮肤的健康与安全。一般孕妇专用护肤品的排行榜如下：</p><p style=\"text-align: start;\">妊娠期间，孕妇的皮肤可能会发生改变，这可能与体内激素水平的变化、皮肤干燥、皮肤敏感等因素有关。建议孕妇选择适合孕妇使用的护肤品，以保证皮肤的健康与安全。一般孕妇专用护肤品的排行榜如下：</p><p style=\"text-align: start;\">纯天然植物配方的护肤品，其中一般不含有刺激性成分，通常不会对孕妇和胎儿造成伤害。</p><p style=\"text-align: start;\">而以玻尿酸为主要成分的护肤品通常具有保湿、补水的作用，能够在一定程度上改善妊娠期间皮肤干燥、起皮等症状。</p><p style=\"text-align: start;\">但是，建议孕妇选择适合孕妇的护肤品，以保证自身的皮肤状态和胎儿的健康。同时，建议孕妇注意饮食均衡，可以适当进食富含蛋白质、维生素等营养物质的食物，如鸡蛋、芹菜等，有助于补充机体所需要的营养物质，增强抵抗力。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0f354ee14.webp', 1, 1, '2025-04-19 22:27:00');
INSERT INTO `gourmet` VALUES (15, 4, 2, '适当运动能控糖，但这3个大坑千万别踩！', '<p style=\"text-align: start;\">运动能够帮助糖尿病患者控制血糖吗？答案是毋庸置疑的。</p><p style=\"text-align: start;\">　　运动能显著改善与代谢相关的指标，如运动能改善糖尿病患者的糖化血红蛋白（HbA1c）水平，这种改善效果和饮食治疗、药物治疗和胰岛素治疗的效果相当。也有研究表明，为期仅12周的有氧运动即能明显降低患者的HbA1c水平、增加骨骼肌力量和改善运动感知水平。</p><p style=\"text-align: start;\">　　但临床上常常遇到患者根据自己的想法进行运动，却没有任何效果，甚至还有过度运动带来低血糖的病例发生，今天，我们就来盘点一下，运动控糖最容易踩的那些“坑”！</p><p style=\"text-align: start;\"><strong> 01 运动前不一定要进行准备活动？错！</strong></p><p style=\"text-align: start;\">　　根据《中国糖尿病运动治疗指南》的建议，每次运动应有运动前5～10分钟的准备活动，运动后也至少要有5分钟的放松活动。</p><p style=\"text-align: start;\">　　人体从安静状态进入到剧烈的运动，需要有一个适应的过程，充分做好准备活动不仅能提高中枢神经系统的兴奋性，克服内脏器官的惰性。同时提高神经系统对肌肉协调指挥能力，使得各器官之间互相配合、协调、提高运动器官的工作能力，还能预防伤害事故。</p><p style=\"text-align: start;\"><strong> 02 运动强度越大越好？错！</strong></p><p style=\"text-align: start;\">　　运动的设计需要运动时间和运动强度配合。当运动强度较大时，运动持续时间相应缩短；强度较小时，运动持续时间则适当延长。</p><p style=\"text-align: start;\">　　此外运动强度不可过大，运动量过大或短时间内剧烈运动，会刺激机体的应激反应，导致儿茶酚胺等对抗胰岛素作用的激素分泌增多、血糖升高，甚至诱发糖尿病性酮症酸中毒，对控制糖尿病病情反而不利。</p><p style=\"text-align: start;\">　　为确保锻炼安全有效，运动强度必须控制在已确定的有效范围之内，超过80%VO2max（最大摄氧量）的运动存在一定的危险性；小于50%VO2max的运动对老年人和心脏病患者适宜。</p><p style=\"text-align: start;\">　　而对于中老年糖尿病患者，由于并发症较多，以 50%～60%VO2max的强度运动比较适宜。为了安全运动 ，原则上要求年龄大于40岁、病程超过10年、有心血管疾病症状与体征的糖尿病患者，应通过运动试验获得靶心率。</p><p style=\"text-align: start;\">　<strong> 03 运动方案可以随意调整？错！</strong></p><p style=\"text-align: start;\">　　运动疗法属于糖尿病患者生活方式干预的一部分，如果医生确定了运动方案，不建议患者自行调整，从目前关于运动与糖尿病的研究成果来看，有氧运动和抗阻训练是糖尿病患者运动方式的良好选择，建议2型糖尿病患者的最佳运动方案为有氧运动与抗阻训练相结合。</p><p style=\"text-align: start;\">　　由于个体疾病状况及运动能力的差异，因此运动训练计划要采取循序渐进（由少到多、由轻至重、由稀至繁，周期性、适度恢复）的原则，并且在不同时期还要根据病情和运动能力的变化而调整计划。</p><p style=\"text-align: start;\">　　因此，糖尿病患者的运动方案调整是复杂的，应该在专业医师的指导下进行。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9d7058215.webp', 1, 1, '2025-04-19 22:39:10');
INSERT INTO `gourmet` VALUES (16, 4, 1, '一荣俱荣、一损俱损，夫妻和睦痴呆少', '<p style=\"text-align: start;\">配偶通常共享一个共同的环境，许多研究调查了配偶的一致性因素，如生活方式和生理和心理健康，这些因素在夫妻之间是一致的，它们与患痴呆或认知能力下降的风险有关，并且与配偶认知障碍呈负相关。因此，这些因素可能介导夫妻之间相关的认知障碍和认知功能的改变。此外，因为这些因素大多数是可以改变的，可以有助于降低患痴呆症的风险，所以夫妻之间的早期发现和矫正对于预防痴呆症很重要。然而，夫妻之间共同的风险因素对与配偶认知障碍相关的认知障碍风险的中介作用从未被直接研究过。</p><p style=\"text-align: start;\">Hee Won Yang等再JAMA Network Open杂志发表研究文章，探讨了影响夫妻认知能力下降的因素及其在夫妻认知障碍和认知功能共同风险中的中介作用。</p><p style=\"text-align: start;\">该前瞻性队列研究每两年对784名参与者进行随访，包括了来自韩国认知老化和痴呆纵向研究(KLOSCAD)的老年夫妇和他们的配偶(KLOSCAD- s)。配偶的认知障碍被定义为轻度认知障碍或痴呆。采用结构方程模型研究了夫妻双方共同的因素在一方认知障碍和另一方认知障碍风险之间的中介作用。</p><p style=\"text-align: start;\">该研究纳入了784名KLOSCAD参与者(307名女性[39.2%]，477名男性[60.8%];平均[SD]年龄(74.8[4.8]岁)和配偶(477名女性[60.8%]和307名男性[39.2%];平均[SD]年龄，73.6[6.2]岁)。在KLOSCAD-s队列中，KLOSCAD参与者的认知障碍与他们配偶的认知障碍风险几乎倍相关(优势比，1.74;95%置信区间，1.12 - -2.69;P = 0.01)。</p><p style=\"text-align: start;\">头部损伤史(β = 0.50;95%置信区间，0.09 - -0.90;P = 0.02)和年龄(β = 2.57;95%置信区间，1.37 - -3.76;P&lt;0.001)介导了KLOSCAD参与者的认知障碍与其配偶认知障碍风险之间的关联。体力活动不足通过重度抑郁障碍介导了这种关联(体力活动不足β = 0.33， 95% CI， 0.09-0.57， P = 0.006; 重度抑郁症β = 0.28， 95% CI， 0.13-0.44， P&lt;0.001)。这些因素同样介导了配偶认知障碍和认知功能(如记忆和执行功能)之间的联系。</p><p style=\"text-align: start;\">夫妻共同生活的环境可能会导致夫妻共同的认知障碍和认知表现。识别和干预夫妻之间痴呆症的共同风险因素，可能会降低痴呆症患者配偶患认知障碍的风险。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0bdd3d016.jpg', 1, 1, '2025-04-19 22:40:14');
INSERT INTO `gourmet` VALUES (33, 3, 2, '早晨有氧运动晚上无氧运动可以吗', '<p>核心提示：早晨有氧运动晚上无氧运动不可以。早晨进行有氧运动后，血液循环会加快，晚上进行无氧运动时，早上产生的乳酸等代谢废物可能还未完全清除，可能导致肌肉疲劳或疼痛。如果此时继续进行无氧运动，可能会加重肌肉酸痛、</p><p>早晨有氧运动晚上无氧运动不可以。</p><p>早晨进行有氧运动后，血液循环会加快，晚上进行无氧运动时，早上产生的乳酸等代谢废物可能还未完全清除，可能导致肌肉<a href=\"https://jbk.39.net/zhengzhuang/pl/\" target=\"\">疲劳</a>或<a href=\"https://jbk.39.net/zhengzhuang/tt1/\" target=\"\">疼痛</a>。如果此时继续进行无氧运动，可能会加重<a href=\"https://jbk.39.net/zhengzhuang/jrst/\" target=\"\">肌肉酸痛</a>、损伤的风险，因此不建议在早晨有氧运动后立即进行晚上无氧运动。</p><p>对于初次接触健身的人群，由于身体机能较差，为避免运动风险，一般不建议在早晨进行有氧运动晚上进行无氧运动。</p><p>无论是早晨还是晚上进行任何形式的运动，都要注意做好充分的热身活动，并且在运动过程中随时监测身体反应，以免发生意外伤害。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e52c30517.webp', 1, 1, '2025-04-19 22:45:22');
INSERT INTO `gourmet` VALUES (34, 3, 2, '补气虚的运动有哪些', '<p style=\"text-align: start;\">补气虚可以尝试瑜伽、太极、普拉提、健步走、游泳等运动。需注意的是，食物并不能直接治疗气虚，如症状持续不改善，建议寻求专业中医师的帮助。</p><p style=\"text-align: start;\">1.瑜伽</p><p style=\"text-align: start;\">瑜伽是一种温和的锻炼方式，通过各种体位、呼吸练习和冥想来促进血液循环，有助于增强身体的能量。长期坚持瑜伽可以提高身体的免疫力，改善睡眠质量，进而达到补气虚的效果。</p><p style=\"text-align: start;\">2.太极</p><p style=\"text-align: start;\">太极强调缓慢而流畅的动作，配合深长均匀的呼吸，以滋养内脏器官，增强气血运行。经常练习太极可提升体内气血流通效率，缓解压力，从而辅助补气虚。</p><p style=\"text-align: start;\">3.普拉提</p><p style=\"text-align: start;\">普拉提着眼于核心稳定性和身体对称性，通过一系列动作激活深层肌肉群，以助于调整气血平衡。持续进行普拉提训练有助于加强筋膜系统功能，改善姿势不对称问题，对于存在气虚症状具有一定的改善作用。</p><p style=\"text-align: start;\">4.健步走</p><p style=\"text-align: start;\">健步走是一项简单易行的有氧运动，能够增加氧气摄入量，刺激气血产生。经常进行健步走可以帮助增强心肺功能，改善身体耐力，从而起到补气的作用。</p><p style=\"text-align: start;\">5.游泳</p><p style=\"text-align: start;\">游泳是一项全身性的运动，能够提高心肺功能，促进血液循环，增强气血运行能力。长期游泳可以增强体质，提高抵抗力，有助于预防气虚的发生。同时还可以帮助减轻压力，放松身心。</p><p style=\"text-align: start;\">建议患者平时注意饮食调理，适当进食红枣、龙眼等温补食材，以辅助补益气血。此外，患者还应保持良好的作息习惯，避免过度劳累，以免加重气虚的症状。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c5c32d518.jpg', 1, 1, '2025-04-19 22:46:32');
INSERT INTO `gourmet` VALUES (35, 3, 4, '含神经酰胺的护肤品对皮肤有哪些作用？', '<p><span style=\"color: rgb(51, 51, 51);\">女性使用过化妆品的都知道其中是含有神经酰胺的，但是大家对于含神经酰胺的护肤品对于皮肤会产生哪些作用并不是十分清楚，这些基本常识是每一位女性必须去了解清楚的，今天小编正好给大家请来了皮肤方面的权威专家，一起来听听他们是怎么说的。<br><br> </span><span style=\"color: rgb(51, 51, 51);\"><strong>神经酰胺是什么？</strong></span></p><p><span style=\"color: rgb(51, 51, 51);\"> 我们知道人的皮肤主要由三个部分组成，分别是真皮、表皮和皮下组织，我们每天使用化妆品的时候与皮肤发生关系的就是表皮层，而表皮层的外面就是角质层，而神经酰胺就是角质层细胞之间的物质，占据的比例能够达到50%，相当于神经酰胺在皮肤表面形成了一层保护膜，能够抵抗外界的腐蚀。<br><br> </span><span style=\"color: rgb(51, 51, 51);\"><strong> 含神经酰胺的护肤品对皮肤的作用如下：<br><br> 1）粘合作用：<br></strong></span><span style=\"color: rgb(51, 51, 51);\"> &nbsp;第一个神经酰胺功能就是粘合功能，这是它十分独特的一个功能，能够非常强地将很多的角质细胞粘合在一起，这样皮肤就会锁住水分了，保持湿润。<br><br> </span><span style=\"color: rgb(51, 51, 51);\"><strong> 2）保湿作用：</strong></span></p><p><span style=\"color: rgb(51, 51, 51);\"> 神经酰胺还能帮助大家锁住水分子，最终形成网状的结构锁水，其他的锁水物质效果都不如神经酰胺好。皮肤湿度有保证了，整个人的皮肤就会变得非常好。<br> </span><span style=\"color: rgb(51, 51, 51);\"><strong> 3）屏障作用：</strong></span></p><p><span style=\"color: rgb(51, 51, 51);\"> 皮肤中有了神经酰胺这种物质之后能够让皮肤少受外界的刺激，如果皮肤里面没有它，就失去了一个屏障。<br><br> </span><span style=\"color: rgb(51, 51, 51);\"><strong>4）抗过敏作用：</strong></span><span style=\"color: rgb(51, 51, 51);\"> </span></p><p><span style=\"color: rgb(51, 51, 51);\">有些人的皮肤本身就非常的薄，这时候使用含有神经酰胺的化妆品的话能够让角质层变得厚一点，皮肤会变得更加有耐受力，不会出现红血丝了。<br><br><br> </span><span style=\"color: rgb(51, 51, 51);\"><strong>5）抗衰老：</strong></span><span style=\"color: rgb(51, 51, 51);\"> 皮肤干燥会引起皱纹，做好保湿自然是可以辅助抗衰老的。<br><br><br> 相信大家读完上文后对于含神经酰胺的护肤品对皮肤的5个作用都有十分全面的认识，能够看出这样的一种物质对于皮肤是有十分明显的保护作用的，希望大家在使用化妆品的时候尽量选择含有神经酰胺的，只要大家坚持使用皮肤会变得越来越好的。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1f7855c19.webp', 1, 1, '2025-04-19 22:48:05');
INSERT INTO `gourmet` VALUES (36, 3, 8, '人们在走神时大脑活动更为活跃', '<p style=\"text-align: start;\"> 这项研究发现，当我们心不在焉的时候，大脑很多区域的活动都有所增强。研究结果刊登在最新一期《美国科学院院刊》上。事实上，该研究表明，一些同解决复杂问题有关的大脑区域在我们进行天马行空的想象时高度活跃，而科学家之前认为这些区域在我们走神时处于休眠状态。</p><p style=\"text-align: start;\">　　领导实施这项研究的不列颠哥伦比亚大学心理学教授卡琳娜·克里斯托夫(KalinaChristoff)表示：“思绪飘扬一般同懒散或精力不集中等负面事情有关。但是，这项研究却表明我们走神时大脑活动反而更为活跃，活跃程度甚至超过我们专心从事一些日常工作的时候。”</p><p style=\"text-align: start;\">　　在研究中，志愿者躺在fMRI扫描仪里面，当数字出现在屏幕上时进行按键等简单活动。研究人员可以通过大脑扫描、志愿者的主动报告以及追踪志愿者的成绩来调查他们的瞬间注意力。研究结果发现，走神(最多可以占据我们清醒状态下三分之一的时间)是一种重要的认知状态，在这种状态下，我们可能在不知不觉中将注意力从当前的工作转向梳理日常生活中的重要问题。</p><p style=\"text-align: start;\">　　大脑活动的数量和质量表明，尝试解决复杂问题的人应该先停下来，转而从事更为简单的工作，让思绪自由飘荡。克里斯托夫说：“你在走神的时候，可能并没有取得直接目标——比如在课堂上读书或集中注意力听讲，但思绪可能利用这一时间去解决你人生中更为重要的问题，比如事业发展或个人关系。”</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fc1962820.jpg', 1, 1, '2025-04-19 22:50:19');
INSERT INTO `gourmet` VALUES (37, 5, 6, '长期处于低温环境人会如何', '<p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">长期处于低温环境可能导致</span><a href=\"https://jbk.39.net/zhengzhuang/twtjwl/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">体温调节紊乱</span></a><span style=\"color: rgb(0, 0, 0);\">、低代谢状态、</span><a href=\"https://jbk.39.net/ds/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">冻伤</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"https://jbk.39.net/ts/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">脱水</span></a><span style=\"color: rgb(0, 0, 0);\">、</span><a href=\"https://jbk.39.net/zhengzhuang/mylxj/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">免疫力下降</span></a><span style=\"color: rgb(0, 0, 0);\">等风险反应。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">1.体温调节紊乱</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">长期处于低温环境中会导致机体产热不足以维持正常体温，引起体温调节中枢功能障碍。此时可能出现寒战、颤抖等自主性产热增加的现象，严重时可导致</span><a href=\"https://jbk.39.net/twgd/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">体温过低</span></a><span style=\"color: rgb(0, 0, 0);\">甚至昏迷。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">2.低代谢状态</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">低温状态下，为了保持体温，身体会降低新陈代谢率以减少热量散失。这可能导致心率减慢、呼吸变浅以及其他生理过程的减缓，进一步影响血液循环和器官功能。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">3.冻伤</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">当人体长时间暴露于低温环境中，皮肤表面温度低于5℃时，局部组织会发生冻结现象，这是由于低温导致细胞内外水分结晶所致。冻伤后，受损部位会出现红斑、</span><a href=\"https://jbk.39.net/zs13/\" target=\"\"><span style=\"color: rgb(0, 0, 0);\">肿胀</span></a><span style=\"color: rgb(0, 0, 0);\">、疼痛等症状，严重者可能伴有水疱或组织坏死。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">4.脱水</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">低温环境下，人体出汗减少，但呼吸加快以保持呼吸道湿润，从而造成水分流失。脱水可能导致头晕、口渴、尿量减少等不适症状，严重时可引发电解质紊乱。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">5.免疫力下降</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">低温条件下，机体为抵御寒冷需要消耗大量能量，这可能会干扰免疫系统的正常功能。因此，长期处于低温环境中的人更容易受到感染，恢复期也相对较长。</span></p><p style=\"text-align: start;\"><span style=\"color: rgb(0, 0, 0);\">在低温环境中活动时，应做好保暖措施，避免穿着潮湿衣物，以免加重体温调节紊乱。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6d12a2221.jpg', 1, 1, '2025-04-19 22:56:01');
INSERT INTO `gourmet` VALUES (38, 5, 4, '美甲变毁甲 “指尖上的美丽”如何守护', '<p style=\"text-indent: 2em; text-align: justify;\">从“过年三件套”到敖闰的“裂空爪”，从“法式甲”到“中式风”，从刷油涂胶到可穿戴……美甲已成为不少消费者展示自我、表达个性的“新刚需”。</p><p style=\"text-indent: 2em; text-align: justify;\">然而，美甲变毁甲等糟心事不时发生，一些爱美人士不仅丢了“指尖美丽”，还搭上了指甲的健康。</p><p style=\"text-indent: 2em; text-align: justify;\">如何守护“指尖上的美丽”？记者进行了调查采访。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>美丽背后潜藏风险</strong></p><p style=\"text-indent: 2em; text-align: justify;\">前不久，广西南宁市民周小怡发现，刚做两天的美甲“发霉”了——透过厚厚的淡粉色延长甲片，可以清晰看到指甲上长出黝黑的霉菌。就医后医生告诉她，这是因为甲片与指甲贴合不紧，水分进入缝隙滋生了霉菌。</p><p style=\"text-indent: 2em; text-align: justify;\">在一些医院皮肤科，类似的患者并不鲜见。“我们科每天开设七八个门诊诊室，每个诊室日均至少有一两个患者因为美甲出现问题。”吉林大学第二医院皮肤科主治医师单百卉说，她遇到过指甲变绿的、变灰的、发炎的、分层的，甚至还有指甲整个掀翻的，“还有不少青少年患者”。</p><p style=\"text-indent: 2em; text-align: justify;\">记者在小红书等社交平台上搜索发现，“美甲变毁甲”“美甲后出现问题”等话题浏览量超千万次，上万人参与讨论。除了指甲发霉、变绿，指甲红肿、变脆、泛血丝等也是常见的讨论问题。</p><p style=\"text-indent: 2em; text-align: justify;\">记者调查发现，美甲变毁甲等问题的背后，是美甲越来越受到消费者青睐，近些年美甲相关企业大量出现，鱼龙混杂。</p><p style=\"text-indent: 2em; text-align: justify;\">业内人士透露，美甲市场火热，但行业门槛较低，一些“美甲工作室”没有经营许可，藏身于居民楼间，甚至一个人、一个筐就能上门服务。</p><p style=\"text-indent: 2em; text-align: justify;\">有些不良商家凭借低价抢占市场，使用劣质材料，卫生环境较差，造成潜在风险。“美甲的风险包括指甲损伤、甲分离、甲沟炎、皮肤刺激，以及细菌、真菌或病毒感染等，长期频繁接触质量欠佳的指甲油、指甲胶，还会增加患癌风险。”广西医科大学第一附属医院皮肤性病科副主任医师张馨予说。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>问题到底出在哪</strong></p><p style=\"text-indent: 2em; text-align: justify;\">近期，记者在多地实地探访发现，不少美甲店的产品设备、卫生环境、操作流程等隐患重重。</p><p style=\"text-indent: 2em; text-align: justify;\">记者在一家美甲店看到，各式甲油胶琳琅满目。美甲师表示，这些甲油胶都是厂家直供，市场上买不到。记者提出想要看一下产品合格证，美甲师说，产品是老板拿来的，“我们只负责用，不知道合格证在哪里。”</p><p style=\"text-indent: 2em; text-align: justify;\">前不久，上海市消保委对43款美甲产品进行测评，结果显示，有几款油性指甲油和甲油胶中测出了一定含量的甲苯、乙苯等挥发性有机物；含闪粉和亮片的指甲油被检出多种重金属元素，深红色指甲油中铬或镍的检出浓度较高。</p><p style=\"text-indent: 2em; text-align: justify;\">商务部2007年发布的美容美发行业经营管理技术规范要求，美甲服务应备有皮肤病顾客的专用工具箱，美甲工具应采用紫外线消毒，做到一客一消毒，或使用一次性用品。</p><p style=\"text-indent: 2em; text-align: justify;\">记者周末到店体验时看到，繁忙时段，多名美甲师混用美甲工具，“你剪完我用，你磨完我磨”，最多用湿巾擦一下，鲜有消毒工序。当记者询问这些工具是否需要“一客一消”时，一名美甲师说：“请您放心，闭店之后我们都会认真消毒的。”</p><p style=\"text-indent: 2em; text-align: justify;\">“如果操作过程中没有经过严格的消毒，那细菌、病毒、真菌就会通过器械传播到其他人身上去；尤其是如果修剪过程中破皮了、出血了，交叉感染隐患就更大。”张馨予说。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>健康与美丽能否兼得</strong></p><p style=\"text-indent: 2em; text-align: justify;\">美甲行业快速发展、消费群体日益扩大，如何守护“指尖上的美丽”？</p><p style=\"text-indent: 2em; text-align: justify;\">广西消费者权益保护委员会秘书长唐楚尧建议，有关部门出台强制性标准和规范，加强监管，指导行业协会对美甲商家定期评星评级，为消费者选择美甲服务提供有效参考；同时加大从业人员的培训力度，推动行业自律，促进美甲行业健康发展。</p><p style=\"text-indent: 2em; text-align: justify;\">多位医生建议，加强健康科普宣传，引导消费者树立健康美甲、理性美甲的观念。单百卉等医生提示，每次美甲至少应间隔一个月至一个半月，给指甲充分的休息时间；一旦发现指甲出现变色等异常情况应及时就医，千万不能为了一时的美丽影响身体健康。</p><p style=\"text-indent: 2em; text-align: justify;\">“随着健康美甲需求的不断增长，只有更安全、更卫生、更规范的美甲服务，才能赢得消费者的信赖和口碑。”广西美甲标准专业委员会副会长黄谢丹说。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=91fe3f122.webp', 1, 1, '2025-04-19 22:57:54');
INSERT INTO `gourmet` VALUES (39, 5, 3, '去挖野菜了吗？荠菜、香椿、蒲公英可不能随便吃，医生总结野菜食用提醒', '<p style=\"text-indent: 2em; text-align: justify;\">微雨众卉新，春天是万物复苏的季节，百草萌发，又到了吃野菜的季节。野菜是春天限时版的美味，如今相约一起摘野菜更成为都市人放松社交的新方式。不过，既然叫野菜，食用也有讲究。这里来说说一些常见的春季野菜。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>荠菜：天然维C源</strong></p><p style=\"text-indent: 2em; text-align: justify;\">荠菜在田野里随处可见，可以轻轻松松挖上一篮筐。荠菜含有丰富的维生素C和膳食纤维，100克荠菜中的维生素C含量约43毫克，大约是苹果的14倍，可与130克圣女果相媲美，是天然的维C源。</p><p style=\"text-indent: 2em; text-align: justify;\">荠菜的烹饪方法多种多样，可以做荠菜炒鸡蛋、蒸荠菜（荠菜加玉米面搅拌均匀后蒸熟）、荠菜团子（荠菜加上胡萝卜、粉丝、虾皮，再加入食用油锁住水分，搅拌均匀后蒸熟）。采用这些烹饪方法，既可以保留荠菜的自然风味，还能较大限度保留其营养价值。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>香椿：“春菜”人气榜必有一席</strong></p><p style=\"text-indent: 2em; text-align: justify;\">香椿具有独特芳香，被誉为“树上蔬菜”。在我国，食用香椿的历史悠久，民间自古就有“食用香椿，不染杂病”的说法。香椿中含有丰富的钙、镁、铁、磷等微量元素，香椿的镁含量是猕猴桃的3倍，铁含量是新鲜红枣的3倍。香椿中也含有丰富的膳食纤维，其含量与菠菜相当。</p><p style=\"text-indent: 2em; text-align: justify;\">要注意的是，吃香椿前需要先焯水，以去除亚硝酸盐和草酸等物质，焯水时间不需过长，30秒即可。香椿可以和其他食材搭配食用，例如可以做成香椿炒鸡蛋、香椿烙饼（香椿洗净切碎后加入面粉和鸡蛋，搅成糊状，小火慢煎）、香椿豆腐泥（豆腐压成泥，加入香椿碎、芝麻、花生碎等），鲜美无比。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>蒲公英：蘸酱过多增加肾负担</strong></p><p style=\"text-indent: 2em; text-align: justify;\">蒲公英又称婆婆丁，属于药食同源的食物，具有清热解毒，消肿、散结块、保护视力的作用，维生素A的含量约是胡萝卜的1.7倍。更有研究发现，蒲公英提取物可改善2型糖尿病大鼠胰岛素抵抗状态，并降低血糖水平。</p><p style=\"text-indent: 2em; text-align: justify;\">有人喜欢用蒲公英来蘸酱食用，这种方法虽简单便捷，但食用过多会导致盐分摄入过多，加重肾脏负担。更推荐将其凉拌，做成鸡蛋饼或蒲公英包子，或制作成蒲公英茶，既可以保留美味，又不会加重身体代谢负担。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>特别提醒：</strong></p><p style=\"text-indent: 2em; text-align: justify;\">野菜是春天里一道特殊美食，然而，像荠菜、香椿、马齿苋等野菜都是光敏性食物，食用后会增加人体对紫外线的吸收，在阳光下暴晒容易诱发日光性皮炎，光敏体质者更容易中招。因此，这类人群在食用野菜时应特别小心，尤其是外出旅游或在户外工作之前最好不要食用野菜。即使没有明显光敏感的人群，也应注意控制食用量，并在食用后尽量避免阳光直射，或选择在晚餐时食用。</p><p style=\"text-indent: 2em; text-align: justify;\">为了加速身体排泄，食用野菜后要多喝水。</p><p style=\"text-indent: 2em; text-align: justify;\">食用野菜前，最好先将其焯水，以去除多余的草酸等物质，同时还能软化粗纤维，有助于消化和吸收。</p><p style=\"text-indent: 2em; text-align: justify;\">无论是哪种野菜，都需要注意控制食用量和烹调方法，以避免过度摄入盐、糖分或脂肪。</p><p style=\"text-indent: 2em; text-align: justify;\">选择野菜时，要注意避免采摘花坛边、路边、矿厂附近的野菜，因为这些地方可能存在污染风险。</p><p style=\"text-indent: 2em; text-align: justify;\">如果遇到不认识或辨识不清的野菜，不要采摘，以免误食导致食物中毒。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4c7288c23.png', 1, 1, '2025-04-19 22:58:51');
INSERT INTO `gourmet` VALUES (40, 5, 10, '减少“小胖墩”需家校社协同共治', '<p style=\"text-indent: 2em; text-align: justify;\">“我家孩子才9岁，这半年长了20斤”……近期，首都儿科研究所成立医学体重管理中心，不少家长带孩子前来向医生咨询体重管理意见。近年来，我国儿童青少年超重肥胖比例持续上升。超重肥胖，不仅会影响孩子身体健康，还可能带来焦虑、抑郁等心理问题。</p><p style=\"text-indent: 2em; text-align: justify;\">随着国家卫健委等16部门发起“体重管理年”行动，超重肥胖问题成为社会关注焦点，“小胖墩”现象也引起社会广泛关注。《中国居民营养与慢性病状况报告（2020年）》显示，我国6至17岁儿童青少年的超重肥胖率为19%，即每5个孩子中就有1个体重超标。更为严峻的是，若不加以有效干预，到2030年我国儿童超重肥胖率将突破31.8%。</p><p style=\"text-indent: 2em; text-align: justify;\">儿童青少年正处于生长发育的关键阶段，儿童期肥胖的危害远大于“中年发福”。肥胖容易诱发高血压、糖尿病、脂肪肝等疾病，还会影响儿童的运动能力、骨骼发育及认知智力。同时，肥胖儿童常因体型问题遭受嘲笑、孤立，导致自尊心受挫，可能产生孤僻、抑郁等心理问题。此外，儿童期肥胖主要是由于脂肪细胞数量增多，其带来的危害具有长期持续性。研究表明，41%至80%的儿童肥胖会延续至成年，成年后患心脑血管疾病等慢性病的风险大幅增加。</p><p style=\"text-indent: 2em; text-align: justify;\">造成超重儿童越来越多的原因是多方面的。首先是“吃多动少”。由于功课安排紧张、学习压力大，孩子们普遍久坐时间长、吃饭速度快、运动量不足，造成脂肪过度堆积，进而形成“越不动就越胖，越胖越不想动”的恶性循环。其次是观念误区。一些家长认为孩子小时候胖点没关系，长大后自然会瘦下来，甚至持有“越胖越健康，越胖越有福”的错误理念，纵容甚至鼓励孩子进食甜食、肉类、油炸食品等高热量、高脂肪食物。此外是缺乏指导。部分孩子和家长虽然意识到肥胖的危害，但苦于缺乏科学运动和减肥相关知识、指导。一些家长试图通过限制进食帮助孩子减肥，却陷入了“越饿越胖”的怪圈，还引发了新的身体问题。</p><p style=\"text-indent: 2em; text-align: justify;\">解铃还须系铃人。治理儿童肥胖问题，需要家庭、学校、社会等多个层面协同配合，共同发力。</p><p style=\"text-indent: 2em; text-align: justify;\">对于家庭而言，家长作为孩子身心健康的第一责任人，亟待改变传统观念和养育方式，积极主动地参与到孩子的体重管理中。一方面，家长要以身作则，和孩子一起“管住嘴，迈开腿”，成为体重管理的表率；另一方面，要注重饮食的多样性和合理性，在确保孩子身体发育所需营养的同时，减少多余热量和脂肪的摄入。</p><p style=\"text-indent: 2em; text-align: justify;\">对于学校来说，应合理安排课程表，保障体育与健康课时，确保中小学生每天综合体育活动时间不低于2小时。同时，不断丰富体育活动形式，开展街舞、韵律操、武术操、球类运动、花式跳绳等简便易行、学生喜爱的体育活动，培养学生良好的锻炼习惯和健康的生活方式。</p><p style=\"text-indent: 2em; text-align: justify;\">对于社会而言，各地医疗卫生机构应积极开设儿童减重门诊，为孩子和家长提供专业的健康咨询服务，指导肥胖儿童量身定制科学、安全、有效的减重方案。体育场馆、文化场馆等校外活动场所应结合自身功能，为儿童体重管理提供必要支持，让孩子有地方运动、有兴趣锻炼，实现身心健康成长。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e949e4124.png', 1, 1, '2025-04-19 22:59:24');
INSERT INTO `gourmet` VALUES (41, 5, 6, '室外二手烟 这样治理', '<p style=\"text-indent: 2em; text-align: justify;\">一边走路，一边吸烟——这样的“游烟”行为，游走于城市的街头巷尾，让不少路人直呼“遇到二手烟，无处躲藏”。</p><p style=\"text-indent: 2em; text-align: justify;\">近日，上海市宣布在外滩、武康路、豫园商城、新天地、南京路步行街、陆家嘴商圈、今潮8弄、蟠龙天地等8处中外游客集中、人群密集区域，启动针对室外“游烟”的示范治理。比如，在豫园商城、外滩等地，加强控烟宣传，引入智能语音提示设备，以提升劝阻和引导效果；在陆家嘴商圈，通过陆家嘴中心绿地大屏、商务楼宇户外屏、地铁站信息屏及东方明珠周边行人指示屏滚动投播控烟宣传。</p><p style=\"text-indent: 2em; text-align: justify;\">禁烟宣传标语能起到一定的提醒作用，但主要依赖吸烟者自觉。如何更好提升“游烟”劝阻效果？一些区域引入志愿者，针对“游烟”行为进行劝导。</p><p style=\"text-indent: 2em; text-align: justify;\">张大懂是上海市普陀区的一名志愿者，主要在公交站点和菜市场门口劝导“游烟者”。“我们日常身上会有志愿者标识，只要说明上海在室外开展控烟示范行动，很多人都会自觉把烟掐了，或者走到更空旷的地方。”张大懂说。</p><p style=\"text-indent: 2em; text-align: justify;\">还有些市民自觉加入劝导队伍。上海市民艾达日常会在自家孩子就读的小学门口，自发进行控烟劝导。据她介绍，学校门口等待区时常人员聚集，往往有家长一边等待，一边吸烟。“我自身患有呼吸道疾病，二手烟对我影响很大，为此我寻求过学校和社区帮助，也曾拨打12345热线反映情况，要求在校门口贴上‘禁止吸烟’提示。学校配合贴了标识后，禁烟效果比想象中好很多。看到‘50米内禁止吸烟’的标识，一些吸烟的家长会自觉远离人群。”艾达说。</p><p style=\"text-indent: 2em; text-align: justify;\">实际上，早在2010年，上海市就颁布了公共场所控制吸烟条例；2017年修订后的版本，更是明确室内公共场所、室内工作场所和公共交通工具全面禁烟。统计显示，在严格的控烟政策下，上海的成人吸烟率从2010年的近27%下降至目前的19.2%。餐厅、办公楼等场所“烟雾缭绕”的现象得到明显改善。然而，由于人口基数庞大，很多户外场景的二手烟暴露率依旧较高，“边走边抽”的“游烟”更让不少市民诟病。根据上海市2024年对室外二手烟所做的抽样调查结果，在一万名受访者中，有约六成市民明确表示“经常遭遇‘游烟’”。此次上海市明确启动针对室外“游烟”的示范治理，就是要加大治烟力度，为市民创造良好的室内外环境。</p><p style=\"text-indent: 2em; text-align: justify;\">据悉，上海此次的“游烟”治理，在明确提出不支持人群密集区随意吸烟的同时，将更加科学规划吸烟点，以便利吸烟者并减少对他人的影响。当地管理部门、商户和志愿者团队也在努力让相关提示更显眼、更易懂，在中文标识外，还加入外文导引。</p><p style=\"text-indent: 2em; text-align: justify;\">据上海市爱国卫生运动委员会办公室信息，上海将在多个“网红”场所内持续完善室外吸烟点和提示系统，通过市、区两级部门分工合作，推进公众健康教育，让更多市民养成不在密集人群中吸烟的习惯。多位受访者表示，室内控烟过去被很多人认为“推行有难度”，但经过十余年努力，已成为公共场合常态。“游烟”治理同样不可能一蹴而就，需要坚持宣传、劝导与执法同步。从上海的实践看，无论是不断出现的志愿者队伍，还是逐渐增多的控烟海报，都显示出上海在禁烟领域做出的积极尝试。</p><p style=\"text-indent: 2em; text-align: justify;\">“要让禁止‘游烟’深入人心，既要加强宣传效果，也要加强志愿者队伍和制度支持。”艾达说，期待能形成一套可落地的“禁止游烟”机制，进一步强化取证便利性，为“游烟”治理提供更有力的保障。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=017c9f225.png', 1, 1, '2025-04-19 23:00:05');
INSERT INTO `gourmet` VALUES (42, 5, 6, '国家疾控局：水痘、手足口病这样预防', '<p style=\"text-indent: 2em; text-align: justify;\">春季是多种传染病高发季节，水痘和手足口病作为儿童青少年群体中常见的传染性疾病，受到家长关注。国家疾控局近日发布健康提示，针对两种疾病的临床表现、传播特点及科学防控措施作出权威解读，呼吁公众提高防范意识，筑牢健康屏障。</p><p style=\"text-indent: 2em; text-align: justify;\">水痘是由水痘-带状疱疹病毒引起的急性传染病，初次感染表现为水痘，病毒潜伏于神经节中，免疫力低下时可再次引发带状疱疹。</p><p style=\"text-indent: 2em; text-align: justify;\">根据国家疾控局发布的健康提示，患者感染后通常经历10至21天的潜伏期，随后出现发热、头痛、乏力等类似感冒的症状。未接种疫苗或未感染过水痘的人群均易感。病毒主要通过飞沫传播（如咳嗽、打喷嚏），也可通过直接接触水疱液或被其污染的物品传播。</p><p style=\"text-indent: 2em; text-align: justify;\">家长关心，孩子得水痘后有哪些表现？中国疾控中心病毒病所专家表示，水痘皮疹的特征包括：皮疹先发于头部和躯干，逐渐向四肢扩散；从红色斑疹迅速演变为丘疹、水疱，最终结痂；夜间瘙痒感加剧，需避免抓挠以防继发感染。</p><p style=\"text-indent: 2em; text-align: justify;\">如何做好预防与处置？专家表示，儿童可接种两剂水痘疫苗（首剂12至18月龄，第二剂4至6岁）；患者应隔离至全部结痂，需居家休息，保持皮肤清洁，避免抓挠。</p><p style=\"text-indent: 2em; text-align: justify;\">若出现高热不退、皮疹化脓或意识模糊等症状，应立即就医。孕妇、新生儿及免疫力低下者感染后需尽早接受抗病毒治疗。</p><p style=\"text-indent: 2em; text-align: justify;\">手足口病也是春夏季常见传染病。中国疾控中心2024年监测数据显示，我国手足口病流行特征发生变化：虽然流行强度较高，但重症比例明显下降。2024年我国手足口病重症比例较2009至2019年间平均水平下降97%，流行强度呈现“双峰”特征，第一个高峰为5至7月，第二个高峰为10至11月。</p><p style=\"text-indent: 2em; text-align: justify;\">中国疾控中心免疫规划首席专家王华庆介绍，手足口病由多种肠道病毒引起，以手、足、口腔等部位皮疹为典型症状，5岁以下儿童为高发人群。早期症状为发热，随后出现口腔黏膜疹及手足部红色丘疹或疱疹，部分患儿臀部、四肢亦可见皮疹。多数病例症状较轻，极少数可能引发病毒性脑炎等严重并发症。</p><p style=\"text-indent: 2em; text-align: justify;\">预防手足口病应做好以下6点，包括：避免接触患儿，尽量不要与患儿拥抱、分享玩具、共用餐具和洗浴用品等，防止交叉感染；保持手卫生，用“七步洗手法”清洁双手；减少聚集；密闭公共场所和居室要经常通风，保持空气流通；做好清洁消毒；积极接种疫苗，目前，EV71型灭活疫苗可有效预防由肠道病毒71型引发的手足口病。</p><p style=\"text-indent: 2em; text-align: justify;\">王华庆强调，水痘和手足口病均为可防可控的传染病，防控核心在于“保护易感人群、切断传播途径、控制传染源”。两类疾病均有对应疫苗，家长可积极为儿童完成接种；托幼机构需加强监测，发现疑似病例及时上报，落实晨午检制度。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=91bed7527.jpg', 1, 1, '2025-04-19 23:01:03');
INSERT INTO `gourmet` VALUES (43, 5, 1, '管好情绪就是管好身体', '<p style=\"text-indent: 2em; text-align: justify;\">情绪是人类对内外部事件或情境的心理反应，具有复杂且多样的表现形式，根据体验的不同分为正面情绪与负面情绪。正面情绪是指那些能带来积极体验和感受的情绪，通常与满足、愉悦、幸福等状态相关；负面情绪是指那些会带来不愉快或痛苦体验的情绪，通常与压力、挫折、不幸等状态相关。</p><p style=\"text-indent: 2em; text-align: justify;\">在快节奏、高压力的现代生活中，我们往往会忽视自身情绪的悄然变化。殊不知，那些焦虑、愤怒、烦躁的情绪往往会对我们的身体产生负面影响，在潜移默化中对生理和心理健康造成不小的伤害。</p><p style=\"text-indent: 2em; text-align: justify;\">情绪如何对身体健康产生影响？负面情绪对身体是百害而无一利的吗？正面情绪会给身体带来哪些益处呢？怎么合理有效地排解负面情绪？</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>正面情绪能给身体带来诸多益处</strong></p><p style=\"text-indent: 2em; text-align: justify;\">“正面情绪是心血管疾病的‘保护神’，可以通过降低交感神经兴奋性，减少儿茶酚胺释放，从而改善血管内皮功能。”江苏南京脑科医院心境障碍科（江苏省抑郁症诊疗中心）副主任史家波说，有研究表明，乐观程度高的个体冠心病发病率降低35%，且冠状动脉钙化程度更低，即使在进一步调整健康行为、健康状况和抑郁诊断等潜在混杂因素后，这种关联依然显著。乐观情绪与心血管健康的关联在女性中比男性更强。</p><p style=\"text-indent: 2em; text-align: justify;\">正面情绪可以增强机体的免疫力。史家波介绍，正面情绪可以通过激活副交感神经，降低炎症因子水平，同时提升免疫球蛋白A（IgA）分泌，增强黏膜屏障防御能力。</p><p style=\"text-indent: 2em; text-align: justify;\">一项针对334名健康成年人的研究发现，持续记录积极情绪体验的参与者在暴露于鼻病毒后，感冒风险降低了50%。</p><p style=\"text-indent: 2em; text-align: justify;\">结果表明，积极情绪体验与感冒抵抗力之间存在显著关联，这种关系在调整了多种变量（如年龄、性别、教育、种族、体重指数和季节）后依然存在。另外，研究还发现，积极情绪体验的参与者不仅感冒风险降低，而且在感冒后症状更少更轻。</p><p style=\"text-indent: 2em; text-align: justify;\">除此之外，正面情绪还可以促进内源性阿片肽（如内啡肽）释放，抑制脊髓后角痛觉信号传递，是管理疼痛的天然镇痛剂。还有研究显示，正面情绪是长寿的潜在驱动因素。一项针对1235名老年人的研究发现，生活满意度高者全因死亡风险降低29%。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>长期的、慢性的负面情绪会损害健康</strong></p><p style=\"text-indent: 2em; text-align: justify;\">前不久，山东省东营市人民医院疼痛科主治医师姜林凯接诊了一名长期饱受头疼困扰的年轻患者。他了解到该患者长时间处于高强度工作状态，睡眠不足成为常态，情绪不稳定，烦躁、易怒。经过详细问诊，姜林凯判断她的疼痛症状与长期积压的负面情绪密不可分。</p><p style=\"text-indent: 2em; text-align: justify;\">“情绪不仅是人类精神心理状态的外在高级表现，同时也是躯体健康的重要‘调节器’，反之躯体健康也会影响人的情绪，二者‘双向奔赴’，互相影响。”史家波介绍。</p><p style=\"text-indent: 2em; text-align: justify;\">史家波说，现代医学研究证实，情绪与人体多个生理系统存在双向交互作用：正面情绪可增强免疫力、促进组织修复，而长期的、慢性的负面情绪则会通过神经内分泌、免疫炎症和遗传等方面，显著增加心脑血管、消化系统疾病和肿瘤等的风险。</p><p style=\"text-indent: 2em; text-align: justify;\">不少人都会认为，只要是负面情绪必然会对身体产生危害。“并非所有负面情绪都会损害躯体健康，短期的焦虑可以激活下丘脑—垂体—肾上腺轴（HPA轴），导致皮质醇升高，短时间内提高人体各器官的功能，帮助人克服困难。”史家波介绍，但长期的、慢性的负面情绪会损害躯体的健康。</p><p style=\"text-indent: 2em; text-align: justify;\">长期焦虑是功能性胃肠疾病的重要诱因之一。例如，焦虑情绪与肠易激综合征密切相关。研究显示，焦虑情绪会导致肠道紧张，影响肠道正常蠕动和消化液分泌，从而引发肠易激综合征。</p><p style=\"text-indent: 2em; text-align: justify;\">同时，长期焦虑可使交感神经兴奋性增加，抑制副交感神经，当副交感神经被抑制时，消化道腺体的分泌功能减弱，导致唾液、胃酸和胃蛋白酶分泌减少，胃液分泌不足，胃的消化功能减弱。患者可能会出现消化不良、胃胀、胃痛等症状，这些症状不仅会影响患者的营养摄入，还可能导致体重下降、免疫力下降等问题。</p><p style=\"text-indent: 2em; text-align: justify;\">长时间处于负面情绪中会增加心血管疾病的发病率。“焦虑可导致交感神经系统过度激活，增加心率和血压，从而加重心脏负担。”史家波说，焦虑还可能影响血小板活性，促进血栓形成，进一步增加心血管事件的风险。焦虑障碍患者可能更难以遵循健康的生活方式和治疗方案，如规律服药、戒烟和健康饮食等，这也会间接影响心血管健康。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>负面情绪会对神经系统产生影响，加剧记忆功能衰退。</strong></p><p style=\"text-indent: 2em; text-align: justify;\">慢性压力引起的负面情绪导致皮质醇持续增高，会抑制海马体的突触可塑性，导致神经元死亡，还会使海马体误以为个体不需要那么多的记忆通路，从而出现大规模修剪突触的现象。史家波补充道，“负面情绪会诱发抑郁症，可能引起全身多个器官系统功能失调，被认为是促进肿瘤发生发展的高危因素。”</p><p style=\"text-indent: 2em; text-align: justify;\">“负面情绪会影响人体的免疫力和代谢能力，造成免疫力紊乱，抑制免疫系统的正常功能，进而增加患病的风险。”姜林凯说，胃肠功能也对情绪变化的感知非常敏感，受负面情绪影响，胃动力和消化液分泌会出现紊乱，“这就是很多人常说的‘气得胃疼’的缘由。”</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>合理有效地排解负面情绪</strong></p><p style=\"text-indent: 2em; text-align: justify;\">目前，公众对情绪与健康之间的关系认识仍存在不小的误区。不少人认为将情绪全部爆发出来对健康有益，但这种将情绪无限放大的做法容易使人陷入灾难化思维陷阱和情绪化旋涡，应当避免。</p><p style=\"text-indent: 2em; text-align: justify;\">也有人认为退一步海阔天空，负面情绪忍一忍就过去了，但将负面情绪压抑在心里不进行纾解的行为，不仅影响我们的感知系统，甚至还会带来生理上的不适，进而引发疾病。</p><p style=\"text-indent: 2em; text-align: justify;\">身体健康的奥秘就藏在人们的一言一行，一喜一怒之间。如何穿越情绪风暴，用科学的方式守护身心健康，姜林凯建议，每个人都应该学会调节自己的情绪，合理有效地排解负面情绪，努力成为情绪的主人。</p><p style=\"text-indent: 2em; text-align: justify;\">合理宣泄情绪至关重要，无论是在运动健身中挥洒汗水，还是向朋友家人倾诉心声，都能让心中积压的负面情绪得到有效释放和纾解。</p><p style=\"text-indent: 2em; text-align: justify;\">“还可以将自己置身于风景优美、安静闲适的环境中，配合深长缓慢的呼吸节奏，让紧绷的神经逐渐放松，让躁动的情绪恢复平静。”姜林凯介绍，负面情绪来袭时，我们可以积极走向户外，通过拥抱大自然的方式纾解情绪。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，采用积极的自我暗示、自我安慰也是对抗负面情绪的一剂“良药”。“在生活中树立对抗困难挫折的信心，多鼓励自己，为自己加油打气，‘我可以！’‘我已经很棒了！’”姜林凯说。</p><p style=\"text-indent: 2em; text-align: justify;\">当负面情绪过于强烈时，姜林凯建议采用注意力转移法，将注意力转移到自己的兴趣爱好中，让心灵找到暂时的栖息之所，“我们应当在生活中多培养一些兴趣爱好，这将成为我们抵挡负面情绪的港湾”。对于负面情绪迟迟无法排解，影响到我们的正常工作生活，甚至引发身体生理上不适感的情况，姜林凯表示，应当及时到专业医疗机构就医，通过药物治疗和心理治疗进行干预。</p><p style=\"text-indent: 2em; text-align: justify;\">“我们可以通过正向思考重塑大脑神经网络，有规律地进行有氧运动，更多地进行社会交往，向家人或朋友倾诉都可以有效地调节情绪。”史家波表示，情绪管理是健康管理的重要组成部分，也是基于神经生物学机制的疾病预防策略，通过认知行为干预、生活方式调整，每个人都能将情绪转化为健康资产。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d13c79e26.png', 1, 1, '2025-04-19 23:01:30');
INSERT INTO `gourmet` VALUES (44, 5, 6, '从环境卫生到健康管理 爱国卫生运动焕发新活力', '<p style=\"text-indent: 2em; text-align: justify;\">卫生健康是一人之事，也是国之大事。近日，从国家卫生健康委在苏州举行的新闻发布会上了解到，我国爱国卫生运动取得显著成效，未来将进一步从环境卫生治理转向全面社会健康管理，新增健康体重管理行动、健康乡村建设行动和中医药健康促进行动，并更加关注心理健康服务。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>爱国卫生运动5年来成效显著</strong></p><p style=\"text-indent: 2em; text-align: justify;\">全国爱卫办常务副主任、国家卫生健康委规划司司长庄宁介绍，自2020年《国务院关于深入开展爱国卫生运动的意见》印发实施以来，围绕各项重点任务取得了积极进展，主要体现在群众健康意识更强、城乡人居环境更美、健康服务更优、健康治理更好等方面。</p><p style=\"text-indent: 2em; text-align: justify;\">据介绍，通过广泛开展健康知识普及，引导群众养成文明健康、绿色环保的生活方式，“每个人都是自己健康第一责任人”理念深入人心，居民健康素养水平从2019年的19.17%提升至2024年的31.87%。</p><p style=\"text-indent: 2em; text-align: justify;\">在城乡人居环境方面，通过推广运用“千万工程”经验，深入开展城乡环境整治，强化病媒生物预防控制，持续改善群众身边环境。2024年，城镇生活垃圾无害化处理率达到99%，卫生厕所普及率达到75%左右。</p><p style=\"text-indent: 2em; text-align: justify;\">在健康服务方面，通过深入实施健康中国行动，聚焦儿童青少年、妇女、职业人群和老年人，强化全生命周期健康服务。加强重点传染病监测处置，重大慢病过早死亡率由2019年的16.5%下降至2023年的15%。</p><p style=\"text-indent: 2em; text-align: justify;\">庄宁介绍，下一步将持续落实健康优先发展战略，进一步加强健康科普，倡导健康生活方式，建设健康环境，促进爱国卫生运动进一步从环境卫生治理向全面社会健康管理转变。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>体重管理、乡村建设、中医药等纳入健康中国行动</strong></p><p style=\"text-indent: 2em; text-align: justify;\">2019年，国务院印发关于实施健康中国行动的意见，启动实施健康中国行动15个专项行动。全国爱卫会14日发布通知称，结合健康中国建设工作实际和健康中国行动推进情况，决定将健康体重管理行动、健康乡村建设行动和中医药健康促进行动纳入健康中国行动。</p><p style=\"text-indent: 2em; text-align: justify;\">“新增的3个行动侧重强调健康促进、医防融合，比如要正确认识体重，科学管理体重，培养健康生活方式和科学就医习惯，注重饮食养生、运动养生、调畅情志等，强调从源头控制风险因素。”庄宁说，改善群众健康需要社会各方支持，3个行动对相关部门提出具体任务，也从个人、家庭和社会等层面提出各方需要采取的行动，希望将健康融入各行各业，融入群众日常生活。</p><p style=\"text-indent: 2em; text-align: justify;\">健康不仅是身体健康，心理健康同样重要。国家卫生健康委将2025年至2027年确定为“儿科和精神卫生服务年”。庄宁说，今年正在积极推进全国统一心理援助热线“12356”应用，希望更多人重视心理健康、维护心理健康，正确对待压力和挑战。</p><p style=\"text-indent: 2em; text-align: justify;\">中医药是中华民族的瑰宝，在防治青少年近视和促进老年人健康方面具有独特作用。国家中医药管理局中西医结合与少数民族医药司司长严华国表示，下一步将推动养老机构、托育机构、产后母婴康养机构等提供中医药健康服务，拓宽中医药健康服务领域，比如聚焦青少年近视、肥胖、脊柱侧弯等问题。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>开好社会治理“大处方”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">保障14亿多人的健康，有医疗卫生的“小处方”，还有社会治理的“大处方”，爱国卫生运动正深度融入基层社会治理。</p><p style=\"text-indent: 2em; text-align: justify;\">江苏苏州，90%的社区卫生服务中心已升级为市民综合健康管理服务平台，95%以上的社区（村）建有居民健康自我管理小组。江苏省苏州市人民政府副市长季晶介绍，当地居民健康素养水平从2009年的15.3%增长到目前的43.03% 。下一步将持续在“均衡、可及上”下功夫，打造高水平“健康之城”。</p><p style=\"text-indent: 2em; text-align: justify;\">在山东省滨州市，当地把爱国卫生运动融入基层社会治理，发展多元主体的“协同治理”。截至目前，全市基层首诊率达到七成。山东省滨州市人民政府副市长潘峰介绍，当地从社区、单位和个人等层面进行全员发动，构建起“人人参与、人人负责、人人享有”的大健康格局。</p><p style=\"text-indent: 2em; text-align: justify;\">海南省将爱国卫生工作与健康海南建设融合推进，聚焦高血压、糖尿病、肺结核、肝炎、重型精神疾病等慢性病，建立一套“筛、防、治、管”全流程闭环管理体系。海南省卫生健康委主任李文秀介绍，当地还建设4个国家区域医疗中心和50个省级临床医学中心，开展77项医疗新技术填补省内空白，基本实现“小病不进城，常见病、多发病在市县，大病不出岛”</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e1c6c2828.png', 1, 1, '2025-04-19 23:04:27');
INSERT INTO `gourmet` VALUES (45, 6, 3, '谁说减肥必须饿肚子？吃货的“动态平衡”生存法则来了！吃补品治愈肿瘤？这些都是谣言！', '<p style=\"text-indent: 2em; text-align: start;\"><strong>央视网消息：</strong>最近收到读者灵魂拷问：“顿顿吃火锅还能瘦的同事是变异了吗？”今天带你看透《中国居民膳食指南（2022）》的隐藏彩蛋——原来吃和瘦真的可以兼得！</p><p style=\"text-indent: 2em; text-align: start;\"><strong>代谢存钱罐理论</strong></p><p style=\"text-indent: 2em; text-align: start;\">我们的身体就像智能存钱罐：</p><p style=\"text-indent: 2em; text-align: start;\">单日超标≠肥胖判决书。</p><p style=\"text-indent: 2em; text-align: start;\">举个栗子：周末火锅超标500大卡，只需工作日每天少喝1杯奶茶就能抹平。</p><p style=\"text-indent: 2em; text-align: start;\"><strong>中国疾控中心实锤：</strong></p><p style=\"text-indent: 2em; text-align: start;\">长期保持体重的人都有个共同点——懂得\"动态平衡\"！</p><p style=\"text-indent: 2em; text-align: start;\"><strong>3个加减法公式</strong></p><p style=\"text-indent: 2em; text-align: start;\">1. 种类做加法：每天吃够12种食材。早餐凑5种so easy：牛奶+全麦面包+鸡蛋+蓝莓+核桃。</p><p style=\"text-indent: 2em; text-align: start;\">2. 总量做减法：聚餐后三天用“211餐盘法”。2拳蔬菜+1拳蛋白质+1拳主食。</p><p style=\"text-indent: 2em; text-align: start;\">3. 时间做乘法：延长20%咀嚼时间，饱腹感立增30%。</p><p style=\"text-indent: 2em; text-align: start;\"><strong>运动彩蛋时刻</strong></p><p style=\"text-indent: 2em; text-align: start;\">《指南》悄悄说：</p><p style=\"text-indent: 2em; text-align: start;\"><span style=\"color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);\"><strong>• </strong></span>每日活动量＞6000步=自动开启代谢buff。</p><p style=\"text-indent: 2em; text-align: start;\"><span style=\"color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);\"><strong>• </strong></span>每周5次“微运动”（追剧深蹲/等电梯踮脚）效果＞周末突击2小时。</p><p style=\"text-indent: 2em; text-align: start;\"><strong>吃货保命技巧</strong></p><p style=\"text-indent: 2em; text-align: start;\">1. 火锅局先涮蔬菜垫底。</p><p style=\"text-indent: 2em; text-align: start;\">2. 奶茶点3分糖+换鲜奶。</p><p style=\"text-indent: 2em; text-align: start;\">3. 夜宵首选希腊酸奶+莓果。</p><p style=\"text-indent: 2em; text-align: start;\">烧烤趴后靠这招稳住体重！</p><p style=\"text-indent: 2em; text-align: start;\"><strong>营养师敲黑板：</strong></p><p style=\"text-indent: 2em; text-align: start;\">警惕“健康陷阱”：果蔬脆片≈薯片热量。</p><p style=\"text-indent: 2em; text-align: start;\">主食不能断！建议每天吃够3两全谷物。</p><p style=\"text-indent: 2em; text-align: start;\">每天盐＜5g（≈1啤酒瓶盖）糖＜25g（≈5块方糖）。</p><p style=\"text-indent: 2em; text-align: start;\"><strong>终极动态平衡公式：</strong></p><p style=\"text-indent: 2em; text-align: start;\">（美食享受+心理满足）x 科学调整 = 可持续的瘦。</p><p style=\"text-indent: 2em; text-align: left;\">别再跟体重秤玩命啦！根据《中国居民膳食指南（2022）》数据，只要掌握“动态平衡”，每年自动甩肉3-5斤不是梦。毕竟人生这么长，做个会吃的瘦子才划算！</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2f960ce29.png', 1, 1, '2025-04-19 23:10:45');
INSERT INTO `gourmet` VALUES (46, 6, 3, '别乱吃护肝片了 这才是养护肝脏的真正方法→', '<p style=\"text-align: start;\">　近年来，护肝片在年轻群体中颇受欢迎。此前有报道，近五成护肝片被“90后”购买，其中15%的订单产生于凌晨。一边熬夜一边服用护肝片，成为年轻人“朋克养生”的典型写照，殊不知背后隐藏着很多健康风险。　　</p><p style=\"text-align: start;\"><strong> “保肝”兴起的背后</strong></p><p style=\"text-align: start;\">　　生活方式的改变</p><p style=\"text-align: start;\">　　如今生活节奏快，很多年轻人长期熬夜、饮酒，工作压力大。肝脏作为代谢核心器官，承受着各种不良生活习惯带来的压力。</p><p style=\"text-align: start;\">　　肝病年轻化</p><p style=\"text-align: start;\">　　数据显示，我国代谢相关（非酒精性）脂肪性肝病的患病率高达29.6%，且年轻化趋势显著。</p><p style=\"text-align: start;\">　　健康意识增强</p><p style=\"text-align: start;\">　　网络平台上的健康知识越来越多，人们了解到肝脏健康的重要性，对自我健康管理的要求不断提高。</p><p style=\"text-align: start;\">　　消费文化驱动</p><p style=\"text-align: start;\">　　针对年轻人的生活方式和需求，商家的宣传策略以“熬夜不伤肝”“解酒护肝”为噱头，让人将护肝片视为“免罪金牌”。</p><p style=\"text-align: start;\"><strong> 护肝片是什么</strong></p><p style=\"text-align: start;\">　　护肝片有广义和狭义之分。广义的护肝片包括具有保肝作用的药品和保健品。狭义的护肝片是一种中成药，由柴胡、茵陈、板蓝根、五味子、猪胆粉、绿豆等中药组成，具有疏肝理气、健脾消食的功效。</p><p style=\"text-align: start;\">　　药品类护肝片</p><p style=\"text-align: start;\">　　<strong>抗炎类保肝药：</strong>这类药物具有非特异性抗炎作用，可改善肝功能，代表药物有复方甘草酸苷、甘草酸二铵等。</p><p style=\"text-align: start;\">　　<strong>肝细胞膜修复保护剂：</strong>这类药物能够增加肝细胞膜的完整性、稳定性，使受损肝功能和酶活性恢复正常，代表药物有多烯磷脂酰胆碱等。</p><p style=\"text-align: start;\">　　<strong>解毒类保肝药：</strong>这类药物分子中含有巯基，可从多方面减轻组织损伤，促进修复，保护肝细胞，代表药物有谷胱甘肽、N-乙酰半胱氨酸及硫普罗宁等。</p><p style=\"text-align: start;\">　　<strong>抗氧化类保肝药：</strong>这类药物通过抗氧化、清除自由基等方式保护肝细胞，代表药物有双环醇。</p><p style=\"text-align: start;\">　　<strong>利胆类保肝药：</strong>这类药物具有促进胆汁排泄和代谢的作用，可减轻胆汁淤积，适用于胆汁性淤积型肝病，代表药物有腺苷蛋氨酸及熊去氧胆酸。</p><p style=\"text-align: start;\">　　此外还有一些护肝作用的中成药，如上面提到的狭义的护肝片、肝爽颗粒、五酯胶囊、五灵胶囊（丸）等。</p><p style=\"text-align: start;\">　　保健品类护肝片</p><p style=\"text-align: start;\">　　护肝类保健品含有特定植物提取物或合成成分，如奶蓟草、还原型谷胱甘肽等。此类产品仅声称“辅助保护化学性肝损伤”，其产品中的有效成分含量远低于药品，无法替代药品进行治疗，且缺乏长期使用的安全性数据。<strong>需要注意的是，正规保健品都有“蓝帽子”标识，若无“蓝帽子”标识，大家一定要谨慎购买。</strong></p><p style=\"text-align: start;\">　　热门的奶蓟草（水飞蓟）护肝片，具有抗氧化和抗纤维化作用，临床用于治疗肝炎和脂肪肝。但由于保健品中有效成分的剂量远低于药品，单独使用效果有限。</p><p style=\"text-align: start;\">　　护肝茶多含有蒲公英、菊花、金银花等，长期饮用有可能加重代谢负担，甚至可能导致药物性肝损伤。</p><p style=\"text-align: start;\"><strong> 哪些人需要“护肝”</strong></p><p style=\"text-align: start;\">　　确诊为肝病（如肝炎等）或肝功能指标异常的人群，需要在医务人员的指导下选择合适的护肝产品。<strong>切忌用保健品代替药品，以免延误病情。</strong>肝功能正常的健康人无须服用护肝片，盲目使用弊大于利。</p><p style=\"text-align: start;\">　　要提醒年轻人的是，无论哪种护肝片，都不能对抗熬夜、喝酒带来的损伤。过度服用护肝片，或是服用后依然肆无忌惮地喝酒、熬夜，只会加重肝脏的负担。其实，保护肝脏的核心，在于健康的生活方式。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=79a73d930.jpg', 1, 1, '2025-04-19 23:12:23');
INSERT INTO `gourmet` VALUES (47, 6, 6, '爸妈过度沉迷手机追短剧、看直播？疏堵结合助他们健康上网', '<p style=\"text-align: start;\">随着通信技术的发展、智能手机的普及和移动应用的不断升级，越来越多的老年人跨越“数字鸿沟”，同样享受到了数字生活的便利。然而，却也有一些老年人过度依赖网络甚至沉迷其中无法自拔，不仅容易造成经济损失，而且还可能影响老年人的身心健康。</p><p style=\"text-align: start;\">　　有年轻的网友无奈地说，“爸妈玩儿手机比自己还狠”，甚至不得不通过设置“青少年模式”来防止老年人沉迷网络。如何帮助老年人健康“触网”？</p><p style=\"text-align: start;\">　　<strong>曹女士：</strong>退了休以后，她就有自己的时间了，就开始喜欢画画儿。直播间就有一些免费的老师在教，每天跟着人家开始学。后面慢慢就入迷了，一张画经常从早上醒来一直画到晚上睡觉，一天十几个小时是肯定有的。</p><p style=\"text-align: start;\">　　随着画画水平的不断提高，曹女士的母亲不满足只在一个直播间学习，开始“游走”于各个免费的教学直播间。</p><p style=\"text-align: center;\"><br></p><p style=\"text-align: start;\">　　起初，曹女士只是口头提醒母亲不要长时间看直播画画，母亲仍然每天会进行十几个小时以上的高强度创作，视力与刚退休相比也有明显的退化。</p><p style=\"text-align: start;\">　　<strong>曹女士：</strong>工笔画就是特别细，比如画一只鸟身上的毛都得一点点画出来，比较费眼睛。之前的眼睛一直到退休只是有点花眼，原来都在1.0就是5.0左右，现在可能就是个4.5、4.6左右。眼睛有非常明显的退化，原来她特别爱干净，家里的死角每天都抠，现在基本看不清。去年体检说她白内障也有了，可能老年人都会有一点，但是她用眼过度白内障会发展得比较快。</p><p style=\"text-align: start;\">　　直到母亲的眼睛有明显不适后，曹女士才不得不想办法制止。</p><p style=\"text-align: start;\">　　<strong>曹女士：</strong>平板已经换了三个，从八寸到十寸，现在是十一寸。平板是天天开着，即便不听直播她也要打开图看着画。尽量让她每天下午四点多出来溜达管个孩子，这个时间段就不让她画了，相当于把她一天的时间打乱了。如果我这两天不回去，或者不用她管孩子，她就一天都在画。</p><p style=\"text-align: start;\">　　与曹女士的母亲喜欢看直播学习不同，在北京工作的小张她妈妈平时酷爱刷短剧，甚至清早起床第一件事就是看手机。</p><p style=\"text-align: start;\">　　一些短剧在免费试看过后都会有全集打包收费的选项，虽然小张极力反对，但是她妈妈还是会欣然买单。</p><p style=\"text-align: start;\">　　<strong>小张：</strong>为那种所谓的“爽剧”充值我个人觉得没什么意义，但其实换个角度，如果我母亲非要充值，觉得看短剧过程当中能给她带来快乐，我觉得也可以。</p><p style=\"text-align: start;\">　　每天高强度刷剧，小张无意间发现妈妈买了滴眼药。</p><p style=\"text-align: start;\">　　<strong>小张：</strong>前一阵我观察到她偷偷买了滴眼睛的眼药水，我问她什么情况，她就跟我说眼干、眼涩，我说你就是刷手机刷的。肯定会适当制止，但目前作为儿女我也只能提醒她一下，没有办法太多干涉，这也是她的自由。</p><p style=\"text-align: start;\">　　记者搜索社交平台注意到，不少网友提出有必要借鉴“青少年模式”推出针对老年人的专属防沉迷模式，来有效制止老年人沉迷互联网。互联网的“适老化”是否可以作为推广的手段，北京数字经济与数字治理法治研究会副秘书长黄尹旭表示，老年人沉迷手机刷短视频、看直播、网购等现象在数字时代已较为普遍，虚拟陪伴成为他们日常生活的主要方式之一。针对老年人防沉迷，国家、社会和平台都应当有相应的对策。</p><p style=\"text-align: start;\">　　<strong>黄尹旭：</strong>确实老年人一方面休闲时间比较多，另外一方面因为退休后和社会相应存在一定脱节，相比有工作的成年人更容易沉迷到互联网信息当中。从国家层面来说，应当引导平台设立防沉迷模式，当然老年人也属于具有完全民事行为能力的成年人，更多还是以引导为主。</p><p style=\"text-align: start;\">　　对平台来说，一方面要加强内容信息的引导，包括对老年人存在一些诈骗或诱导购买的信息，要有所控制约束。</p><p style=\"text-align: start;\">　　从社会层面来说，可能整个社会适老的娱乐生态还没有搭建起来，包括扩展老年大学，社区层面举办一些针对老年人的活动，子女也应当担负起赡养义务，更多带老年人去一些休闲娱乐活动，丰富退休生活。</p><p style=\"text-align: start;\">　　如今，已有越来越多的老年人跨越“数字鸿沟”，享受数字时代带来的便利。据中国互联网络信息中心发布的第五十五次《中国互联网络发展状况统计报告》显示，截至去年12月，我国网民规模达11.08亿人，其中60岁及以上网民占比达14.1%。</p><p style=\"text-align: start;\">　　置身于数字化社会，老年人融入互联网也已经是大的趋势。黄尹旭进一步表示，在可能会影响老年人的身心健康和财产安全方面，平台作为内容输出主体，应当通过算法优化流量分配，帮助老年人健康“触网”。</p><p style=\"text-align: start;\">　　<strong>黄尹旭：</strong>我觉得平台确实应当引导创造者，针对老年群体创造一些更符合老年群体精神需求的内容。毕竟老年人他应该是自己完全做主的，包括从国家、社会，甚至他的子女来说都应当是辅助性的，各方面的力量都还是要创造一个更加适合老年人生活的“适老化”生态和社会是特别重要的。</p><p style=\"text-align: start;\">　　黄尹旭建议，老年防沉迷和互联网“适老化”是相辅相成的两个方面，要疏堵结合。</p><p style=\"text-align: start;\">　　<strong>黄尹旭：</strong>针对老年人各方面的需求，怎么服务好老年人，使他的退休生活不管是精神生活还是物质生活都丰富，其实也是国家、社会和子女全方位的责任。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1df252031.jpg', 1, 1, '2025-04-19 23:13:54');
INSERT INTO `gourmet` VALUES (48, 6, 10, '18岁脑发育成熟？未必', '<p style=\"text-indent: 2em; text-align: justify;\">从出生前到老年的全生命周期中，人类的大脑功能网络经历了从形成、发育到衰退的复杂过程，支撑着个体认知与行为的发展。构建人类生命周期脑功能网络发展图表，建立人脑功能测量的参考标准，是脑科学领域亟待解决的重大科学问题。</p><p style=\"text-indent: 2em; text-align: justify;\">日前，北京师范大学认知神经科学与学习国家重点实验室贺永教授团队联合全球100余家机构，成功构建全球首个覆盖人类全生命周期的大脑功能网络参考图谱，有望用于全年龄段的脑健康数字化评估，标志着我国在脑科学领域实现重大突破。相关成果作为封面论文发表于《自然·神经科学》。</p><p style=\"text-indent: 2em; text-align: justify;\">研究团队整合了全球最大规模的全生命周期的脑功能磁共振数据，攻克了大样本跨年龄段脑影像数据的标准化处理与质量控制难题，首次绘制出人脑功能网络从出生前到老年期的完整“生命曲线”。研究人员发现，全脑功能连接强度平均水平要在38岁左右才到达峰值点，长程连接持续优化至50岁左右，揭示中年期仍具有较强的神经网络可塑性，颠覆了“18岁脑发育成熟”的传统认知。</p><p style=\"text-indent: 2em; text-align: justify;\">“大脑在全生命周期的发展并非线性变化，而是遵循一种复杂而有规律的演化过程。”贺永说，“通过脑影像大数据，我们有机会揭示脑功能网络的关键发育里程碑。”</p><p style=\"text-indent: 2em; text-align: justify;\">这一工作为评估个体脑健康水平提供了“生长曲线”式的量化依据，有望改变当前主要依赖结构成像进行脑疾病筛查的模式，为神经发育疾病等的脑功能数字化评估提供了参考标准。研究人员或者医生可以借助该参考模型，将个体脑功能的实际情况与标准“生长曲线”进行对比，识别潜在的偏离程度，从而为脑疾病的个体化早期诊断和干预提供指导。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=373580c32.png', 1, 1, '2025-04-19 23:15:08');
INSERT INTO `gourmet` VALUES (49, 6, 10, '手劲儿小 易患心肺疾病', '<p style=\"text-indent: 2em; text-align: justify;\">中国一项研究显示，握力越小，手臂肌肉越少的人，呼吸系统疾病风险明显增加。</p><p style=\"text-indent: 2em; text-align: justify;\">研究发现，握力每降低一个标准差，呼吸系统疾病风险增加 22%。手臂肌肉质量每降低一个标准差，呼吸系统疾病风险增加14%。研究中，总体肌肉质量指数和四肢肌肉质量指数在调整生活方式和病史等因素后，与呼吸系统疾病的发生无相关性。</p><p style=\"text-indent: 2em; text-align: justify;\">无独有偶，阜外医院此前的一项研究也发现，握力较低的成年人，心血管事件发生风险明显增加。研究者称，使用不同肌肉指标评估人群呼吸系统疾病发病风险时，握力和手臂肌肉质量的相关性更强。</p><p style=\"text-indent: 2em; text-align: justify;\">研究发现，肌肉质量和力量是营养状况和身体机能的重要评估指标，在充分调整饮食和身体活动水平后，仍观察到肌肉质量和力量与呼吸系统疾病的关联。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，长期慢性炎症反应是肌少症的重要因素。研究也发现，肌少症患者血清中炎症细胞因子水平升高者，肺功能也较差。研究共分析17510名居民，平均年龄57.8岁，其中65.4%为女性。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=764d64d33.png', 1, 1, '2025-04-19 23:15:35');
INSERT INTO `gourmet` VALUES (50, 6, 10, '“电子保姆”对孩子视力危害不容忽视', '<p style=\"text-indent: 2em; text-align: justify;\">近日，一则“5岁男童近视1000度”的新闻登上热搜。家长透露，孩子每天都要花费6个多小时使用早教机。</p><p style=\"text-indent: 2em; text-align: justify;\">过早、过长时间使用电子产品，儿童过早“触屏”已成为一种普遍现象，由此引发的健康问题不容忽视。近日，在复旦大学附属儿科医院，医生也接诊了一名3岁女孩，因长时间使用电子产品，孩子患上了“斗鸡眼”。</p><p style=\"text-indent: 2em; text-align: justify;\">眼科医生发出呼吁：手机、平板等千万不能当作孩子的“电子保姆”，家长要重视儿童眼健康，特别要关注是否频繁眨眼、眯眼或出现异常头位等现象。早发现、早干预是保护孩子视力的关键。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>儿童“屏幕暴露”越来越早</strong></p><p style=\"text-indent: 2em; text-align: justify;\">近日，3岁的琪琪（化名）因突发内斜视，前往复旦大学附属儿科医院眼科就诊。这是一种发病急、病因复杂的斜视类型，内斜视不但会引起复视，长时间不治疗，还可能引发患儿弱视及立体视功能永久损伤。</p><p style=\"text-indent: 2em; text-align: justify;\">“近期接诊的多位患儿，绝大多数都是因为近距离用眼过度。长时间接触电子产品，有可能引起孩子双眼融合功能紊乱，诱发急性共同性内斜视。”儿科医院眼科主任杨晨皓为琪琪量身定制了治疗方案，通过A型肉毒毒素注射疗法，将药物注射至过度收缩的眼外肌，使肌肉张力减弱，眼球得以回归正位。次日，琪琪内斜度数直降80%，症状基本消失。</p><p style=\"text-indent: 2em; text-align: justify;\">当前，儿童“屏幕暴露”时间越来越早。上海交通大学医学院党委书记江帆教授团队的一则调研发现，上海有24%的儿童在1岁前开始接触屏幕，76%的儿童在2岁前接触屏幕，刚进幼儿园的3岁儿童中，高达78.6%的儿童视屏时间超过“每天1小时”的指南推荐标准。</p><p style=\"text-indent: 2em; text-align: justify;\"> 不仅在中国，屏幕暴露过多在全球范围也是普遍现象，同样年龄段的加拿大儿童视屏时间超标比例达85%，澳大利亚儿童也达到74%。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>远视储备不足，度数增长加快</strong></p><p style=\"text-indent: 2em; text-align: justify;\">小小的屏幕，成了孩子们探索世界的窗口，但孩子开始视屏往往是被动的。</p><p style=\"text-indent: 2em; text-align: justify;\">“不少家长把手机当作哄娃工具。”儿科医院眼科副主任医师周晓红告诉记者，手机成为“电子保姆”最直观的表现是，很多孩子早早戴上了眼镜。</p><p style=\"text-indent: 2em; text-align: justify;\">2023年国家卫健委公布数据显示，我国儿童青少年总体近视率为52.7%。从近年儿童青少年近视情况看，近视高发年龄段已从8到12岁提前至6到10岁，呈现出发病越来越早、度数越来越深、近视率居高不下等特点。</p><p style=\"text-indent: 2em; text-align: justify;\">眼科门诊上，四五岁的小孩不少见，很多刚结束校园筛查的孩子因远视储备不足前来就诊。</p><p style=\"text-indent: 2em; text-align: justify;\">所谓远视储备，是指儿童青少年对应年龄的远视度数。孩子刚出生时，眼轴平均只有16毫米，是个小远视眼，差不多300到400度。随着年龄增长，眼轴逐渐变长，远视度数降低，一般到12岁左右降到0度，变成正常视力。</p><p style=\"text-indent: 2em; text-align: justify;\">周晓红解释，远视储备相当于银行储蓄，随着储蓄逐渐消耗正视化完成，再发展就会由正视向近视转化。数据显示我国6岁儿童中，45%已失去远视储备，其中6到10岁儿童近视度数增长最快。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>“多户外”，是最具性价比的近视防控手段</strong></p><p style=\"text-indent: 2em; text-align: justify;\">“有的孩子在检查视力时总说自己能看清，但实际视力可能只有0.1、0.2，已有四五百度近视。”在医生看来，这些孩子之所以在检查视力时“撒谎”，主要是担心家长不再让他们玩电子产品，但如果孩子隐瞒，家长没有重视、及时发现，可能就会给孩子的视健康埋下隐患。</p><p style=\"text-indent: 2em; text-align: justify;\">“对于远视储备消耗殆尽的孩子，治疗目标就是让近视缓慢增长，不让他们到成年时变成高度近视。”周晓红说，目前相对有效的手段包括增加户外活动时间、低浓度阿托品、离焦镜、OK镜等。</p><p style=\"text-indent: 2em; text-align: justify;\">另一方面，社交媒体上如今充斥着各类“护眼妙招”，各路商家出于营销目的，大力鼓吹防蓝光眼镜、拉远镜或补充叶黄素等。在医生看来，这些于近视防控无益。门诊上，对于就诊的孩子，周晓红不断强调三个字：“多户外！”在临床医生眼中，近视防控手段没有什么比每天接受2小时以上户外光照更具性价比。</p><p style=\"text-indent: 2em; text-align: justify;\">“6岁是近视防控的重要转折点。”周晓红提醒家长，孩子上学后，随着学习任务增加，户外活动时间会急剧下降，一旦用眼过度，视力下降就会加快。因此，要尽量创造条件让孩子参加户外运动和活动，为孩子身心健康护航。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=678668034.png', 1, 1, '2025-04-19 23:16:11');
INSERT INTO `gourmet` VALUES (51, 6, 1, '情绪不佳时就想吃东西？小心是情绪化进食', '<p style=\"text-indent: 2em; text-align: justify;\">情绪波动大的时候就想找东西吃？尤其偏好高热量、高糖分的食物，即使撑得难受也停不下来？深圳市儿童医院心理治疗师陈俏如在接受采访时表示，这类以调节情绪为主要目的而非满足生理饥饿的进食行为，称为情绪性进食。</p><p style=\"text-indent: 2em; text-align: justify;\">陈俏如介绍，情绪性进食是指个体在体验负性或特定正性情绪时，通过进食行为来寻求心理慰藉或获得短暂情绪缓解的一种应对机制。常见诱因包括：压力、愤怒、焦虑、孤独、疲惫、无聊。甚至是愉悦、兴奋等心理状态。此时，食物已经从单纯的营养摄入工具转变为调节情绪的“替代性工具”，有着让自己开心起来或冷静下来等功能。</p><p style=\"text-indent: 2em; text-align: justify;\">“研究发现，情绪性进食者倾向于选择高糖、高脂肪、高热量的食物，如冰激凌、蛋糕、油炸食品等，这是因为此类食物可快速促使大脑释放多巴胺，从而带来即时的愉悦感与情绪安慰。”陈俏如指出，这种“情绪-进食-短暂缓解”的模式不仅无法真正解决情绪问题，还可能导致肥胖、代谢综合征等身体疾病，并加剧原有的焦虑、抑郁情绪，陷入新一轮的恶性循环。</p><p style=\"text-indent: 2em; text-align: justify;\">如何有效干预情绪性进食问题？陈俏如表示，首先可以试着觉察情绪的来源，通过情绪日记，心理反思等方式，明确触发进食的情绪诱因，如工作学业压力、人际冲突或自动性的自我否定等。接着寻找可替代的情绪调节策略。用非进食方式进行情绪调节，例如散步、运动、听音乐、冥想、绘画、与朋友聊天等。另外，可以练习正念饮食，在进食过程中保持觉察，关注食物的外观、气味、口感与咀嚼过程，培养对饱腹感和食欲的敏感性，在适当的时间场合吃让自己身心愉悦的食物，从而减少无意识进食行为。最终目标是建立规律的生活与饮食习惯，保持充足睡眠、合理膳食和规律运动有助于稳定情绪和降低进食冲动。</p><p style=\"text-indent: 2em; text-align: justify;\">“如果个体重复出现难以控制的暴饮暴食行为，限定时间内进食明显多于大多数人或伴随经常性的代偿行为（如催吐、过度运动、使用泻药），对暴食发作感到显著痛苦与功能受损，需及时寻求专业心理帮助。通过专业心理干预，可以有效帮助个体识别情绪性饥饿、调整非适应性饮食行为，从而实现情绪和饮食的良性管理。”陈俏如说。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b39851d35.png', 1, 1, '2025-04-19 23:16:48');
INSERT INTO `gourmet` VALUES (52, 6, 6, '放风筝能治颈椎病？这事靠谱！', '<p style=\"text-indent: 2em; text-align: justify;\">春天的脚步越来越近，许多人已经迫不及待地开始进行户外运动，疏散刚经历过寒冬的筋骨。春季里有一项户外运动非常适合轻中度颈椎病人，既安全、有效，又简单、有趣，那就是大家喜闻乐见的——放风筝！</p><p style=\"text-indent: 2em; text-align: justify;\">放风筝真能治颈椎病？当然是真的，听医生跟您细细道来。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>颈椎病已盯上年轻人</strong></p><p style=\"text-indent: 2em; text-align: justify;\">20多岁的人却有着50多岁的颈椎，这是怎么回事？那就得从我们的骨骼构造讲起。人体的颈椎、胸椎、腰椎、骶椎分别有向前、后、前、后的天然弯曲，大致呈一个“S”型，医学上称为“生理曲度”，具有减缓冲击力、维持肌肉平衡、维护身体平衡性和直立姿势等非常重要的作用。</p><p style=\"text-indent: 2em; text-align: justify;\">现代社会生活节奏很快，大部分人都会不知不觉长时间使用电脑、手机、写字、看电视、刷短视频、敲键盘等，这种曲背低头的不良姿势违背了颈椎正常向前凸的生理弯曲。</p><p style=\"text-indent: 2em; text-align: justify;\">久而久之，就会造成颈部周围软组织劳损、颈椎曲度变直，甚至反弓、颈椎骨质增生、颈椎间盘突出等后果——这就是许多人早早患上颈椎病的原因。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>忽视颈椎预警问题很严重</strong></p><p style=\"text-indent: 2em; text-align: justify;\">颈椎病早期大多只是脖子僵硬、酸胀等轻微症状，只要及时纠正不良姿势、充分休息，即可慢慢恢复。如果忽视身体的报警信号，继续损伤颈椎的行为，颈椎病病情会逐渐加重，出现颈部、肩部、头部等部位明显疼痛，继而出现手臂疼痛、麻木、头晕恶心、心慌多汗，甚至行走不稳、肢体瘫痪等严重症状。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>放风筝的好处多多</strong></p><p style=\"text-indent: 2em; text-align: justify;\">当风筝刚刚放飞的时候，我们会自然地抬起头颅，追踪风筝的每一个动态，随时灵活调整手中的线以保证放飞成功。随着风筝稳稳地飘在空中，我们会欢快地奔跑，双手紧握风筝线，不时地左右转动头部以观察风筝的动向。</p><p style=\"text-indent: 2em; text-align: justify;\">在这过程中，我们抬头向上的视线与日常工作中长时间低头的姿势恰恰相反，可以为长期受压迫的颈椎提供宝贵的舒展机会；颈肩部的神经和肌肉也得到了充分的伸展和锻炼，有助于缓解颈肩部软组织僵硬、劳损，增强韧带弹性，提高颈椎的灵活性和稳定性。</p><p style=\"text-indent: 2em; text-align: justify;\">同时，由于人体颈椎软骨组织、椎间盘等关键部位没有血管直接提供营养，放风筝时颈部的多角度活动、奔跑时上下起伏的震动会产生充足的压力变化，这样可以促进颈椎间盘、软骨组织进行营养交换，从而帮助预防颈椎老化、椎间盘突出。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，放风筝时人们在开阔地奔跑、欢笑，呼吸新鲜空气、接受阳光照射的同时，还可以身心愉悦，改善我们的新陈代谢，提高心肺功能，促进钙质吸收，预防骨质疏松，从而增强身体的抗病能力，对中轻度颈椎病起到良好的预防和治疗作用。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>敲黑板！安全第一！这些细节别忽略！</strong></p><p style=\"text-indent: 2em; text-align: justify;\">出门运动前，务必注意以下几点：</p><p style=\"text-indent: 2em; text-align: justify;\">1.务必在合法、安全的开阔地进行放风筝运动，避开电线、河流、高楼、农田等地段；</p><p style=\"text-indent: 2em; text-align: justify;\">2.春季气温变化快，注意随气温变化增减衣物，雷雨天气不要放风筝；</p><p style=\"text-indent: 2em; text-align: justify;\">3.运动时间以上午、下午阳光不太强烈时为宜，避免阳光暴晒，避免过长时间待在户外；</p><p style=\"text-indent: 2em; text-align: justify;\">4.放风筝运动只对轻中度颈椎病的恢复有帮助，如果您已经出现肢体麻木无力、头晕恶心、剧烈疼痛等重度颈椎病信号，请不要进行任何可能伤害颈椎的运动，即刻就医；</p><p style=\"text-indent: 2em; text-align: justify;\">5.如果您不清楚自己颈椎病的严重程度，请先咨询专业医生后再决定能不能进行放风筝等运动。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=824b92536.png', 1, 1, '2025-04-19 23:17:20');
INSERT INTO `gourmet` VALUES (53, 6, 6, '免疫力并非越强越好，平衡才是终极目标', '<p style=\"text-indent: 2em; text-align: justify;\">在人类演化的长河中，人体免疫系统犹如一座精密设计的防御工事，其运作机制既展现着生命演化的智慧，也蕴含着医学干预的启示。犹如一个“隐形盾牌”，免疫防御遵从怎样的层次？不同年龄的免疫特点有哪些？人体免疫平衡的本质又是什么？来看看它的运作奥秘。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>免疫系统如何守护我们的健康</strong></p><p style=\"text-indent: 2em; text-align: justify;\">人体由两支精锐部队——先天性免疫和适应性免疫组成。它们分工明确、协同作战，既能抵御外敌入侵，又能清理内部隐患。</p><p style=\"text-indent: 2em; text-align: justify;\">先天性免疫是人类与生俱来的防御系统，如同城堡的第一道城墙和巡逻卫兵，能在病原体入侵时迅速反应。</p><p style=\"text-indent: 2em; text-align: justify;\">第一道防御是物理屏障，比如皮肤和黏膜，像城墙一样覆盖体表，通过汗液、皮脂和黏液中的抗菌成分，直接阻挡细菌、病毒入侵；比如呼吸道纤毛，如同护城河的“清道夫”，通过摆动，将灰尘和病原体排出体外。</p><p style=\"text-indent: 2em; text-align: justify;\">第二道防御是“清道夫军团”，负责吞噬与清扫。中性粒细胞24小时在血液中“巡逻”，一旦发现病原体，立刻冲锋吞噬。巨噬细胞如同“清障车”，负责吞噬病原体并发出警报信号，召集其他免疫细胞参战。</p><p style=\"text-indent: 2em; text-align: justify;\">第三道防御是“生化武器库”，负责标记与“围剿”。如补体蛋白，就像“荧光涂料”一样标记病原体，帮助免疫细胞精准识别目标；如炎症反应，局部红肿、发热，既是战斗信号，也能抑制病原体繁殖。</p><p style=\"text-indent: 2em; text-align: justify;\">总的来说，先天性免疫的特点是反应快、无差别攻击，但缺乏“记忆功能”，无法针对特定敌人提升战斗力。</p><p style=\"text-indent: 2em; text-align: justify;\">适应性免疫，是后天训练的“智能特种兵”。如果说先天性免疫是“快速反应部队”，那么，适应性免疫就是经过特训的“智能特种兵”，能精准识别并消灭特定敌人，还能形成长期记忆。</p><p style=\"text-indent: 2em; text-align: justify;\">B细胞作为“抗体工厂”，能针对不同病原体定制特异性抗体，通过中和病毒或标记病原体协助清除机制；同时分化出的记忆B细胞可在免疫结束后保留抗体“图谱”，实现快速二次应答。</p><p style=\"text-indent: 2em; text-align: justify;\">T细胞的角色则是指挥、“杀敌”与“维稳”。比如辅助T细胞，扮演着“指挥官”角色，通过释放细胞因子，激活B细胞和其他免疫细胞；细胞毒性T细胞，扮演着“杀手”角色，直接穿透感染细胞，注入毒素将其摧毁；调节T细胞，扮演着“维稳员”角色，防止免疫反应过度，避免误伤健康组织。</p><p style=\"text-indent: 2em; text-align: justify;\">免疫系统的核心使命不是“消灭一切”，而是识别敌我、清除威胁。</p><p style=\"text-indent: 2em; text-align: justify;\">首先要识别“自我”与“非我”。通过细胞表面的特殊蛋白（如MHC分子）区分自身细胞和外来病原体。一旦误判，可能攻击自身组织，导致类风湿关节炎、1型糖尿病等疾病。</p><p style=\"text-indent: 2em; text-align: justify;\">其次是清除威胁，包括消灭细菌、病毒等外来入侵者，及时发现并清除异常细胞，防止肿瘤形成。</p><p style=\"text-indent: 2em; text-align: justify;\">最后是维持记忆，比如通过疫苗或自然感染形成长期保护，例如天花疫苗的终身免疫效果；再如调节T细胞抑制过度反应，防止免疫系统“暴走”引发过敏或炎症风暴。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>不同年龄段，免疫维护的“黄金法则”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">免疫系统如同人体的“智能防卫军”，在不同人生阶段需要差异化的战略部署。现代医学研究发现，0～3岁儿童免疫记忆形成速度约为成人的3倍，而60岁后胸腺功能每年衰退3%。因此，掌握各年龄段的免疫维护密码，才能让这道健康防线愈加坚固。</p><p style=\"text-indent: 2em; text-align: justify;\">0～18岁，筑牢免疫根基。</p><p style=\"text-indent: 2em; text-align: justify;\">免疫系统的发育如同建造一座城堡，需要从地基开始逐步完善。</p><p style=\"text-indent: 2em; text-align: justify;\">婴幼儿期（0～3岁），新生儿免疫系统像一支未经实战的“新兵部队”，先天性免疫（如中性粒细胞、巨噬细胞）活性高，但皮肤、黏膜屏障薄弱，易受病毒（如呼吸道合胞病毒、轮状病毒）侵袭。此时主要依赖母体通过胎盘和母乳传递的抗体（如IgG、IgA）提供保护。</p><p style=\"text-indent: 2em; text-align: justify;\">这一阶段的维护重点包括：母乳喂养，至少纯母乳喂养6个月，提供抗体和益生菌，降低感染风险；按时接种百白破、脊髓灰质炎等基础疫苗，建立免疫记忆；适度“练兵”，避免过度消毒，适当接触环境微生物（如户外活动），促进免疫系统发育。</p><p style=\"text-indent: 2em; text-align: justify;\">儿童至青少年期（4～18岁），随着免疫系统逐渐成熟，适应性免疫（T细胞、B细胞）开始发挥主力作用，能针对病原体产生特异性抗体。但免疫系统也可能因“经验不足”而反应过度，如对花粉、食物等无害物质过度反应，引发哮喘、湿疹；如接触外界增多，易感染手足口病、水痘等传染病。</p><p style=\"text-indent: 2em; text-align: justify;\">这一阶段的维护重点包括：接种水痘、HPV疫苗（9岁以上），强化免疫记忆；均衡饮食，多摄入蛋白质（鸡蛋、鱼肉）、维生素C（柑橘类）、锌（坚果），促进免疫细胞再生；保证8～10小时睡眠，适度运动，减少熬夜和压力对免疫力的干扰。</p><p style=\"text-indent: 2em; text-align: justify;\">19～60岁，对抗慢性炎症，稳固免疫天平。</p><p style=\"text-indent: 2em; text-align: justify;\">成年期是免疫系统的“黄金时代”，功能趋于稳定，但不良生活习惯可能引发“隐形危机”。这一时期的免疫特点主要是两个方面，一是胸腺萎缩，新生T细胞减少，依赖记忆T细胞应对病原体；二是慢性炎症，吸烟、肥胖、压力等导致低度炎症，增加糖尿病、心血管疾病风险。</p><p style=\"text-indent: 2em; text-align: justify;\">这一阶段的维护重点包括：抗炎饮食，如多吃全谷物、深色蔬菜（菠菜、西兰花）、深海鱼（富含Omega-3）；减少加工食品和反式脂肪；每年接种流感疫苗，高危人群补种乙肝疫苗；进行压力管理，通过冥想、瑜伽降低皮质醇水平，避免长期压力抑制免疫力；疾病筛查，如40岁后定期筛查乳腺癌、结直肠癌，弥补免疫监视功能下降。</p><p style=\"text-indent: 2em; text-align: justify;\">60岁以上，延缓衰退，守护免疫防线。</p><p style=\"text-indent: 2em; text-align: justify;\">老年期免疫系统如同“老兵”，经验丰富但机能衰退，需针对性维护以降低重症风险。这一时期的免疫特点，一是T细胞功能退化，记忆T细胞主导，但清除病原体能力下降；二是抗体质量降低，疫苗应答减弱，感染（如肺炎、带状疱疹）易重症化；三是衰老相关疾病发病风险上升：免疫监视功能减弱，无法及时清除突变细胞。</p><p style=\"text-indent: 2em; text-align: justify;\">这一阶段的维护重点包括：高剂量疫苗接种，选择带状疱疹疫苗、高剂量流感疫苗、肺炎球菌疫苗，提升保护效果；营养强化，补充蛋白质（鱼肉、豆类）、维生素B12、深海鱼油，维持免疫细胞合成；低强度运动，每天散步30分钟或打太极拳，延缓免疫衰老，维持肌肉和细胞活性；定期体检，关注炎症指标（如C反应蛋白），早发现感染或慢性病征兆。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>动态平衡，免疫系统的“终生任务”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">许多人误以为“免疫力越强越好”，盲目服用补品、滥用保健品，结果反而引发过敏、自身免疫病等问题。事实上，免疫系统的精髓在于“动态平衡”——既能高效防御，又不失控攻击自身。这种平衡一旦被打破，就像过度紧绷的琴弦，稍有不慎便会走音或断弦。</p><p style=\"text-indent: 2em; text-align: justify;\">还有人认为“免疫疾病=免疫力低下”，甚至将类风湿关节炎、红斑狼疮等疾病归咎于“免疫力不足”。这种误解导致人们大量服用“增强免疫力”的保健品，或注射免疫增强剂，结果适得其反。</p><p style=\"text-indent: 2em; text-align: justify;\">其实像过敏性疾病，就是免疫系统将花粉、尘螨等微害物质误判为高度危险，过度反应引发喷嚏、皮疹甚至哮喘。还有自身免疫病，属于免疫系统“敌我不分”，攻击自身关节（如类风湿关节炎）、全身各系统（如系统性红斑狼疮）或甲状腺（如桥本氏甲状腺炎）。</p><p style=\"text-indent: 2em; text-align: justify;\">准确来说，免疫系统需要的是“精准调控”，而非“盲目增强”。过度激活的免疫反应如同失控的军队，不仅无法保护健康，反而会引发内乱。</p><p style=\"text-indent: 2em; text-align: justify;\">特别要提醒的是，对于自身免疫病患者，医生常开具激素、免疫抑制剂等药物。这些药物通过抑制过度活跃的免疫系统来缓解症状，但部分患者因担心副作用而擅自停药或减量，导致病情反弹甚至加重。免疫调节药物的剂量和疗程需严格遵循医嘱，随意停药可能引发“报复性免疫攻击”。但某些宣称“增强免疫力”的产品（如灵芝孢子粉、阿胶）又可能干扰免疫平衡，使用前务必咨询医生。</p><p style=\"text-indent: 2em; text-align: justify;\">想要免疫系统稳定运行，总的来说，需从日常防护、生活习惯到健康监测全面入手。</p><p style=\"text-indent: 2em; text-align: justify;\">一是科学防护，筑牢免疫防线。如按时接种流感疫苗、肺炎球菌疫苗等，帮助免疫系统提前“记住”敌人特征。再如远离过敏原，对尘螨、花粉过敏者，可使用防螨寝具、空气净化器。</p><p style=\"text-indent: 2em; text-align: justify;\">二是生活自律，打造免疫“维稳部队”。规律作息，保证7～8小时睡眠，熬夜会抑制免疫细胞活性；适度运动，建议每周3次有氧运动（如快走、游泳），可提升免疫细胞巡逻效率，但过度运动反而消耗免疫力。</p><p style=\"text-indent: 2em; text-align: justify;\">三是定期监测，早发现、早干预。建议40岁以上的人每年体检，筛查自身抗体，关注相关指标的变化幅度。慢性病患者如糖尿病、肥胖人群，需定期监测血糖、血脂，控制慢性炎症对免疫系统的侵蚀。</p><p style=\"text-indent: 2em; text-align: justify;\">免疫系统的智慧，不在于“消灭一切”，而在于“辨明敌我”，维持“动态平衡”。它像一位经验丰富的指挥官，既能调动兵力快速歼敌，又能及时收兵避免误伤。盲目追求“增强免疫力”，只注重免疫防御，忽略免疫监视与免疫自稳，失去对免疫防御的调控，反而会打破这种微妙的平衡。人体免疫系统的伟大，就在于懂得何时进攻，何时休战。</p><p style=\"text-indent: 2em; text-align: justify;\">真正的健康之道，是尊重免疫系统的自然规律——通过科学防护、自律生活和定期监测，让免疫力在“攻守兼备”中稳定运行。正如中医所言：“正气存内，邪不可干”，这里的“正气”并非越强越好，而是“亢则害，承乃制”，需要维持身体阴阳调和、气血通畅的平衡状态。唯有如此，免疫系统才能真正成为守护健康的“隐形盾牌”。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=88da3f437.jpg', 1, 1, '2025-04-19 23:18:07');
INSERT INTO `gourmet` VALUES (54, 6, 2, '科学春练避误区 循序渐进强体魄', '<p style=\"text-indent: 2em; text-align: justify;\">春季气温回暖，人们健身热情高涨。专家提醒，春季科学运动需遵循“适度、多样、渐进、防护”原则，避免盲目锻炼导致损伤。</p><p style=\"text-indent: 2em; text-align: justify;\">北京医院内分泌科主任医师潘琦指出，春季运动需破除“大汗淋漓才有效”的认知偏差，每周至少150分钟中等强度运动即可达到锻炼效果，快走、骑行或传统养生操均适宜。</p><p style=\"text-indent: 2em; text-align: justify;\">针对都市人群时间碎片化特点，潘琦建议将运动融入生活场景，比如提前一站下车步行，办公间隙靠墙静蹲，周末放风筝、踏青等户外活动。八段锦、太极拳等兼具平衡柔韧训练的传统项目也是不错的选择，适应春季万物生发规律。</p><p style=\"text-indent: 2em; text-align: justify;\">运动防护方面，热身环节尤为重要。潘琦说，运动前要有身体的预热期，同时从短时程运动开始，慢慢适应了再循序渐进增加运动量。运动过程中，要注意强度适宜，达到微微出汗，肌肉有一点酸胀感觉即可。如果在运动过程中出现头痛、心悸等症状，要停下来休息，若症状不缓解或持续加重，要及时就医。此外，运动结束后要做拉伸运动，缓解紧张的肌肉。</p><p style=\"text-indent: 2em; text-align: justify;\">国家体育总局体育科学研究所国民体质与科学健身研究中心主任徐建方特别提醒，患有慢性疾病的老年人应根据自身状况选择运动方式。例如，心血管疾病患者要避免在低温环境下运动；高血压患者应避免需要憋气用力的运动；糖尿病患者要避免空腹锻炼，最好在餐后90至120分钟进行运动。</p><p style=\"text-indent: 2em; text-align: justify;\">专家强调，运动是长期健康投资，不必追求“立竿见影”。把握春季生长契机，科学锻炼配合充足睡眠、均衡饮食，方能实现“治未病”的养生目标。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f22a4a738.jpg', 1, 1, '2025-04-19 23:18:42');
INSERT INTO `gourmet` VALUES (55, 6, 3, '春日小心肝 多来点甜头儿', '<p style=\"text-indent: 2em; text-align: justify;\">春日养肝正当时！春天阳气生发，大地回春，气温逐渐变暖，肝在中医五行属木，肝木在春天时令旺盛。此时如能顺应自然之气让肝气条达舒畅，人就会气血平和，感觉精神饱满，心情愉悦。</p><p style=\"text-indent: 2em; text-align: justify;\">今天，中医就来推荐几款有助于养肝护肝的食物和养生茶。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>肝脏喜甜不喜酸</strong></p><p style=\"text-indent: 2em; text-align: justify;\">每一种食物都源自大自然，依据生长环境的不同，呈现出酸、苦、甘、辛、咸五种味道。而不同的味道恰恰可以调补人体的五脏。肝脏喜欢辛、甘之味，不喜酸味。唐代著名的医药学家孙思邈在他的书中就记载到：“春日宜省酸，增甘，以养脾气”。也就是说，春天时令人们要少吃点酸味的食品，多吃点甘甜的食品，以补益人体脾胃之气。</p><p style=\"text-indent: 2em; text-align: justify;\">因此，在日常生活中，大家可以减少醋等酸味食品的摄入，适度增加山药、大枣等甘味食品的摄入，日常可以将山药、大枣、粳米熬粥服用。</p><p style=\"text-indent: 2em; text-align: justify;\">虽然甘味食品可以提升脾气，但是肝病患者却不宜多吃糖。糖，药食同源之品，其性甘温，主缓主壅。肝病患者往往气机不畅，有胀满、痰湿阻滞等症状，过多吃糖会加重这些症状，饮食不香，口臭腹胀，嗳腐泛酸等。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，要想养护好肝脏还需少饮酒。酒，也为药食同源之品，性热、烈。肝脏主要负责藏血，功能表现为疏泄、升发阳气（体阴用阳），像一个将军一样多亢奋，再加上酒的升散，人体阳气更加亢盛，这将消耗人体更多阴血，导致阴虚。而且肝病患者往往夹有湿热，饮酒更易助湿、助热，所以肝病人群应当少饮酒或者忌酒。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>为自己挑杯养肝茶</strong></p><p style=\"text-indent: 2em; text-align: justify;\">虫草银杏叶茶：虫草粉10克，银杏叶15克。将银杏叶洗净，晒干或者烘干，研成粗粉，与虫草粉充分混合，一分为二，装入棉纸袋中，封口挂线，备用。每次取1袋，放入杯中，用沸水冲泡，加盖闷15分钟即可。频频饮服，一般每袋可连续冲泡3至5次。此茶可以益肾滋阴，化痰定喘，降脂养心。此茶适用于脂肪肝人群。</p><p style=\"text-indent: 2em; text-align: justify;\">二子降脂茶：枸杞子30克，女贞子30克。将以上两味药洗净，晒干，装入纱布袋，扎口后放入大杯中，用沸水冲泡，加盖闷15分钟即可代茶饮，可连续冲泡3至5次，当日饮完。该方可以滋补肝肾，散瘀降脂。此茶适用于肝肾阴虚型脂肪肝人群。</p><p style=\"text-indent: 2em; text-align: justify;\">山楂菊花茶：将山楂、白菊花、茶叶按照3：2：1比例进行调配。将山楂煎水后，用山楂水冲泡菊花、茶叶。代茶饮，当日饮完。此茶可以保肝降脂，适用于脂肪肝人群。</p><p style=\"text-indent: 2em; text-align: justify;\">泽泻乌龙茶：泽泻15克，乌龙茶3克。将泽泻加水煮沸20分钟，取药汁冲泡乌龙茶即成。一般可以冲泡3至5次，每日一剂，频频饮用。此茶可以护肝消脂，利湿减肥。适用于脂肪肝、肥胖人群。</p><p style=\"text-indent: 2em; text-align: justify;\">山楂荷叶茶：山楂30克，荷叶10克，冰糖适量。将山楂、荷叶洗净，与冰糖一起放入碗中，用开水浸泡，代茶饮，可连续冲泡3至5次，当日饮完。此茶可以消食化滞，适用于肝郁脾虚型肝硬化人群。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>春日养生按摩安排上</strong></p><p style=\"text-indent: 2em; text-align: justify;\">胸胁胀闷，梳理胁肋。双手五指略分开，从胸正中向两胁肋侧分别顺肋骨方向梳理，要求双手对称，着力和缓。此法适用于肝气郁结出现的胸胁胀痛，可以疏通经络，开胸顺气。</p><p style=\"text-indent: 2em; text-align: justify;\">消化不良，按摩腹部。以一手或者双手叠压，以接触腹部手的掌根、小鱼际。从上腹部剑突下，循胃脘部，自右至左，推运至左胁下。按摩时手掌着力深沉，推动时均匀有力，速度和缓。</p><p style=\"text-indent: 2em; text-align: justify;\">未病先防，按揉足底。肝胆的反射区在足底第四、第五跖关节肌束隆起的稍后方，一枚硬币大小的范围。坐位，以一手拇指按压对侧足底部反射区，用力按压36下。然后左右交换。最后以手掌稍稍用力拍打左右足心36下。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dcb97bf40.jpg', 1, 1, '2025-04-19 23:19:16');
INSERT INTO `gourmet` VALUES (56, 6, 6, '感冒还是过敏性鼻炎？教你3分钟自测', '<p style=\"text-indent: 2em; text-align: justify;\">“医生，我这鼻塞、打喷嚏，到底是感冒还是鼻炎？”每年换季时节，医院里常能听到患者的困惑。约40%的过敏性鼻炎患者初期误把症状当作普通感冒，导致延误治疗甚至加重病情。</p><p style=\"text-indent: 2em; text-align: justify;\">今天，医生教你如何通过科学对比和简易自测表，快速区分这两种疾病，并提供实用应对指南。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>4个关键差异锁定真凶</strong></p><p style=\"text-indent: 2em; text-align: justify;\">感冒与过敏性鼻炎的典型症状虽高度相似，但解码四个关键差异即可锁定病因。</p><p style=\"text-indent: 2em; text-align: justify;\">时间密码：普通感冒的鼻塞、流涕通常持续3-7天，随病毒清除逐渐消退；而过敏性鼻炎可能持续数周至数月，如长期接触过敏源，症状会反复发作。</p><p style=\"text-indent: 2em; text-align: justify;\">特殊信号：感冒常伴随低烧、肌肉酸痛、咽痛等全身症状；过敏性鼻炎则更多出现眼睛、耳道、咽部发痒、清水样鼻涕不断的情况。一个简单分辨技巧：若喷嚏呈连续5-10个的爆发式，大概率是过敏反应。</p><p style=\"text-indent: 2em; text-align: justify;\">诱因追踪：突然进入粉尘环境后立刻打喷嚏？晨起后症状剧烈？这些接触特定物质或时段性加重的规律，提示着过敏体质对尘螨、花粉等物质的敏感反应。</p><p style=\"text-indent: 2em; text-align: justify;\">液体证据：感冒初期可能流清鼻涕，但2-3天后转为黄稠脓涕；过敏性鼻炎则从头到尾都是透明蛋清状分泌物，量大时甚至出现“鼻涕倒流”引发咽炎。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>快速自测表计分规则</strong></p><p style=\"text-indent: 2em; text-align: justify;\">请回答以下问题：是（+2分）不确定（+1分）否（0分）</p><p style=\"text-indent: 2em; text-align: justify;\">1.症状持续超过10天仍未减轻？</p><p style=\"text-indent: 2em; text-align: justify;\">2.是否明显感觉眼睛/咽喉发痒？</p><p style=\"text-indent: 2em; text-align: justify;\">3.进入潮湿房间/花园后症状骤然加重？</p><p style=\"text-indent: 2em; text-align: justify;\">4.鼻涕始终清澈如水且流量大？</p><p style=\"text-indent: 2em; text-align: justify;\">5.家庭成员有过敏性鼻炎或哮喘病史？</p><p style=\"text-indent: 2em; text-align: justify;\">结果解析：0-3分，普通感冒可能性大；4-6分，混合型上呼吸道感染，建议就医；7-10分，过敏性鼻炎风险高，建议做过敏原检测。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>确诊感冒做好三件事</strong></p><p style=\"text-indent: 2em; text-align: justify;\">物理阻断病毒传播：出现症状后前3天传染性最强，需佩戴口罩并定时开窗通风。</p><p style=\"text-indent: 2em; text-align: justify;\">阶梯用药原则：体温＜38.5℃优先物理降温；鼻塞用伪麻黄碱药物；切忌滥用抗生素。</p><p style=\"text-indent: 2em; text-align: justify;\">病程监测重点：若7天后仍头痛/黄痰，警惕鼻窦炎等并发症。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>过敏性鼻炎管理方案</strong></p><p style=\"text-indent: 2em; text-align: justify;\">环境控制：安装HEPA滤网净化器（CADR值＞200），湿度控制在40%-50%抑制尘螨。</p><p style=\"text-indent: 2em; text-align: justify;\">轻度发作：生理盐水冲洗+二代抗组胺药（西替利嗪/氯雷他定）。</p><p style=\"text-indent: 2em; text-align: justify;\">中度以上：联合使用鼻用激素（糠酸莫米松）和白三烯受体拮抗剂（孟鲁司特）。</p><p style=\"text-indent: 2em; text-align: justify;\">免疫调节：症状持续3个月以上者，可检测过敏原后考虑舌下脱敏治疗。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>有这些症状尽快就诊</strong></p><p style=\"text-indent: 2em; text-align: justify;\">单侧鼻腔流出恶臭脓涕，这时需要警惕真菌性鼻窦炎。</p><p style=\"text-indent: 2em; text-align: justify;\">药物治疗2周仍持续鼻塞，提示可能存在鼻息肉。</p><p style=\"text-indent: 2em; text-align: justify;\">出现喘鸣音或夜间呼吸困难，提示有进展为哮喘的可能。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>长期防御指南</strong></p><p style=\"text-indent: 2em; text-align: justify;\">关注花粉浓度预报对于花粉过敏者来说，应关注当地花粉浓度预报，高峰期关闭车窗，回家后立即淋浴。</p><p style=\"text-indent: 2em; text-align: justify;\">定期清洁床品对于尘螨过敏人群，建议每周用大于55℃热水清洗床品，冷冻毛绒玩具24小时除螨。</p><p style=\"text-indent: 2em; text-align: justify;\">预防交叉感染 过敏性鼻炎患者免疫力下降期间，补充维生素D3（每日800IU）可降低合并感冒风险。通过科学辨别和精准干预，90%以上的鼻部症状都能有效控制。</p><p style=\"text-indent: 2em; text-align: justify;\">记住：正确诊断比盲目用药更重要。当自我调理效果不佳时，及时到耳鼻咽喉科进行鼻内镜和过敏原检测，才能从根本上解决问题。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=17270f039.png', 1, 1, '2025-04-19 23:20:20');
INSERT INTO `gourmet` VALUES (57, 6, 1, '您有一份春季心理防护指南，请查收', '<p style=\"text-indent: 2em; text-align: justify;\">春天，多么生机勃勃、清新明媚又充满诗意的季节！但研究发现，春天是情绪问题的高发期，甚至抑郁症患病率和自杀率也较高。为何在如此明媚的春日里，人们的心灵却容易蒙上阴霾？这背后究竟隐藏着怎样的秘密？我们要如何应对，才能真正汲取春天的希望与活力呢？</p><p style=\"text-indent: 2em; text-align: justify;\">带着这些疑问，我们迫切需要探明春季心理问题的“幕后黑手”，只有深入了解问题的根源，我们才能有的放矢，采取切实有效的应对策略，为自己和身边人筑起坚固的心理防护墙，抵御春季心理问题的侵袭，在春天里保持心理健康，尽情享受春季的美好与生机。</p><p style=\"text-indent: 2em; text-align: justify;\">为何春季容易出现心理问题？因为当春天的生机与活力悄然降临时，我们的身心却在经历无声的“风暴”：生物钟在春季的昼夜温差与光照变化中经历“过山车”，扰乱生理节律；体内激素因气温回暖爆发“小脾气”，干扰情绪的稳定；花粉与尘螨等过敏原在肆意“捣乱”，引发身体的不适；社交活动令人们“压力山大”，增加了人际紧张；而那古已有之的“伤春”情结，更是在诗意的季节里悄然滋生着感伤与惆怅。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>生物钟经历“过山车”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">由于春季昼夜温差较大，光照时间也较冬天发生了变化，人体的生物钟将面临挑战。生物钟就像身体的内部时钟，调节我们的睡眠和觉醒等生理节律。当生物钟被打乱时，血清素和褪黑素的分泌就会失衡。血清素是调节情绪、食欲和睡眠的关键物质，而褪黑素则主要负责调节睡眠周期。二者的失衡，会让人疲惫、食欲不振、嗜睡或失眠，甚至陷入抑郁情绪中难以自拔。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>激素爆发“小脾气”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">随着春天气温逐渐回暖，人体内的激素水平也会发生变化。例如，负责传递愉悦和兴奋情绪的“快乐信使”多巴胺和去甲肾上腺素等神经递质，会因气温变化和气压波动引发内分泌紊乱，无法正常工作，从而导致情绪波动、注意力难以集中，甚至出现焦虑、抑郁等情绪问题。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>过敏原肆意“捣乱”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">春天是过敏的高发季节。春季植物生长旺盛，花粉“爆炸”；气温回升、湿度增加，尘螨和霉菌在良好的繁殖条件下“狂欢”；杨絮、柳絮纷飞，过敏原在空气中肆意飘散。当人体接触到这些过敏原时，免疫系统会启动防御机制，释放组胺等物质。组胺不仅会引起打喷嚏、流鼻涕等过敏症状，还会对神经系统产生影响，加剧焦虑和抑郁情绪。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>社交活动“压力山大”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">人们常常在春暖花开之时呼朋引伴，走出家门参加各种户外活动和聚会。虽然有些人感慨着“风乎舞雩，咏而归”享受结伴踏春，但对于不擅长社交的人来说，社交活动的增加反而成为一种心理负担。他们可能会感到紧张不安，甚至会因为无法融入群体而产生负面情绪。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>古已有之的“伤春”情结</strong></p><p style=\"text-indent: 2em; text-align: justify;\">在中国古代文学作品中，文人墨客留下了许多“伤春”的诗篇。杜甫《春望》中的“感时花溅泪，恨别鸟惊心”，李煜《虞美人》中的“问君能有几多愁？恰似一江春水向东流”，苏轼《水龙吟》中的“春色三分，二分尘土，一分流水。细看来，不是杨花，点点是离人泪”……这种文化传统在一定程度上影响了我们对春天的情感认知，使人们容易在春天产生感伤情绪，陷入对过去的回忆和对未来的担忧中。</p><p style=\"text-indent: 2em; text-align: justify;\">面对春季心理问题的一众“幕后黑手”，我们要如何作好心理防护，才能真正地享受春天的美好呢？</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>给生活加点“润滑剂”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">面对春季给我们身心制造的摩擦，保持规律的作息是最基础的应对策略。我们要养成规律作息的习惯，避免熬夜和过度使用电子产品。如有必要，也可以尝试使用遮光窗帘、耳塞等工具，为自己创造一个安静、舒适的睡眠环境。此外，还要合理安排学习、工作和休息时间，避免过度劳累，让身体和心灵都有足够的休息和恢复空间。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>运动是天然“解药”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">运动是调节情绪的天然良药。在春季，我们可以选择一些适合自己的运动方式，如慢跑、瑜伽等。运动不仅能促进血液循环，增强身体的代谢功能，还能刺激大脑释放内啡肽等“快乐激素”，让人感到愉悦和放松。同时，运动还可以改善睡眠质量，帮助人们更好地应对春季的生物钟紊乱问题。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>巧设“饮食过滤网”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">饮食对情绪有着重要影响。我们可以通过均衡饮食，多吃富含维生素、矿物质和蛋白质的食物，帮助改善大脑功能，缓解抑郁情绪，增强身体免疫力。同时，要避免过度摄入高糖、高脂肪的食物，以免导致身体不适和情绪波动。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>给心灵“做按摩”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">学习一些简单的情绪调节技巧，如腹式呼吸、冥想、渐进性肌肉放松等，可以帮助缓解负面情绪。当情绪低落时，也可以尝试与朋友、家人倾诉，或者写日记，将内心的感受表达出来。还可以培养一些自己感兴趣的爱好，如绘画、音乐、阅读等，也能愉悦身心。哪怕只是坐在一个地方用你的感官去品味大自然随着时间推移展现的变化，也是在给自己做心灵“按摩”。</p><p style=\"text-indent: 2em; text-align: justify;\">春天，是一个充满希望和活力的季节，但同时也是心理问题的高发期。了解春季心理问题的成因，并积极采取应对措施，是我们守护心灵健康的关键。让我们在欣赏温暖绚烂春天的同时，也关注自己的内心世界，用科学的方法舒缓疲惫，振奋精神，谱写属于自己的无限可能和美好希望。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a1a6b8a41.png', 1, 1, '2025-04-19 23:21:05');
INSERT INTO `gourmet` VALUES (58, 6, 10, '用爱照亮“星星的孩子”', '<p style=\"text-indent: 2em; text-align: justify;\"><strong>消除认知误区 早发现早干预</strong></p><p style=\"text-indent: 2em; text-align: justify;\"><strong>用爱照亮“星星的孩子”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">2025年4月2日是第十八个“世界孤独症日”。孤独症也被称为自闭症，是一种神经发育障碍，主要特征表现为社交交流和社交互动障碍、兴趣或活动范围狭窄以及重复刻板行为。患有孤独症的孩子无法与他人建立或维系情感关系，如星星般和这个世界保持着一段距离，因此也被称为“星星的孩子”。</p><p style=\"text-indent: 2em; text-align: justify;\">对于孤独症，大众有哪些认识误区？如何尽早识别与干预孤独症？针对这些问题，记者进行了采访。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>树立对孤独症的正确认知</strong></p><p style=\"text-indent: 2em; text-align: justify;\">在四川大学华西医院心理卫生中心副主任、主任医师黄颐看来，孤独症并不是一种单一状态，而是一个谱系障碍。这意味着每个孤独症孩子的表现不尽相同，有的孩子可能症状较轻，能够正常上学、独立生活，有的则需要更多帮助。</p><p style=\"text-indent: 2em; text-align: justify;\">“孤独症并不罕见，患者也非拒绝社交，而是存在社交模式异常。”黄颐举例道，10岁女孩敏敏总在角落玩手指，但当老师用她喜欢的恐龙玩具互动时，她也会主动交流。部分患者会通过特殊方式表达需求，如拉着别人的手去拿物品，或对感兴趣的话题表现出强烈分享欲。她认为，经过社交训练、通过兴趣引导建立沟通，孤独症患者能主动发起简单对话。</p><p style=\"text-indent: 2em; text-align: justify;\">需要注意的是，孤独症并不是由父母的教养方式造成的，而是先天遗传易感性和后天环境触发共同作用的结果，其中，遗传因素占70%至95%。</p><p style=\"text-indent: 2em; text-align: justify;\">药物是否可以治愈孤独症？黄颐说，针对核心社交障碍尚无特效药，行之有效的治疗方案仍是社交技能的干预训练和个性化教育。</p><p style=\"text-indent: 2em; text-align: justify;\">黄颐认为，孤独症是人类神经发育的自然差异，从基因研究到包容教育，我们需要构建的不是“治愈框架”，而是为不同神经类型的人提供支持网络。</p><p style=\"text-indent: 2em; text-align: justify;\">很多家长对孤独症典型症状有一定认知，却容易忽视一些轻度症状，以为孩子能说话、可以表达需求就没有太大问题。实际上，孤独症患者社交障碍程度、刻板重复程度、语言能力和认知水平等方面的个体差异很大。上海市儿童医院康复医学科主任王瑜介绍，“孤独症患者更像是被一个‘罩子’包裹着，有人完全和世界隔绝，有的‘罩子’上有孔洞，可以与外界简单互动或是单向输出。”</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>早发现早干预是关键</strong></p><p style=\"text-indent: 2em; text-align: justify;\">王瑜介绍，注重早期筛查、评估、诊断，早期开展社交、语言、认知及感知觉等干预、康复训练，有利于促进孤独症儿童的社会融入，提升其生活自理能力。</p><p style=\"text-indent: 2em; text-align: justify;\">5岁的善善是一名轻度自闭的孩子。2岁多上早教班时，老师就反映他不爱说话，有什么要求都只会拉着老师指指点点，和小朋友的日常社交也有障碍。“我们以为他只是顽皮，后来做了测试才知道，他有孤独症倾向。”善善妈妈说。</p><p style=\"text-indent: 2em; text-align: justify;\">善善在上海市儿童医院及其他社会机构接受了一年多的康复治疗，最初每周五次，每次上三节课。因为评估结果越来越好，干预次数已减到每周两至三次。如今，善善在一家普通公办幼儿园就读，老师会告诉其他小朋友：“善善和大家有点不一样，对待善善要像对待弟弟一样，遇到冲突时可以找老师，由老师来纠正他。”因为康复训练效果良好，今年下半年，善善将进入家门口的公办小学随班就读。</p><p style=\"text-indent: 2em; text-align: justify;\">“对孤独症患者一定要早发现、早干预、早治疗。”王瑜说，如果能在大脑发育还没有完全定型的关键期进行抢救性干预训练，就可以减轻障碍程度，为患儿建立明确的社会意识、规则意识，从而帮助他们更好地融入社会。</p><p style=\"text-indent: 2em; text-align: justify;\">孤独症的预后取决于患者的严重程度、智力水平以及教育和治疗干预的时机和程度。患者的智力水平越高、干预年龄越小、训练程度越强，效果越好，国内外已有不少通过教育和训练使患者基本恢复正常的报告或者病例。</p><p style=\"text-indent: 2em; text-align: justify;\">孤独症儿童的干预训练，核心内容是提高社会沟通交往的能力、降低刻板重复的行为模式，千万不能事事替孩子想、替孩子办。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>构建全链条健康服务体系</strong></p><p style=\"text-indent: 2em; text-align: justify;\">近年来，为帮助孤独症患者更好融入社会，各地各部门协同合作，加快构建儿童神经发育障碍全链条健康服务体系。</p><p style=\"text-indent: 2em; text-align: justify;\">周日一早，山东省潍坊市妇幼保健院沙盘游戏室内，6岁半的欣欣正与心理健康教育老师张同清玩沙盘游戏。在张同清引导下，欣欣在沙盘上演示去动物园看小动物，室内充满了欢声笑语。</p><p style=\"text-indent: 2em; text-align: justify;\">“第一次见到欣欣的时候，她目光不对视，呼名不反应。”张同清清晰地记得欣欣初次就诊时，没有语言表达，情绪不稳定，令人十分担忧。</p><p style=\"text-indent: 2em; text-align: justify;\">欣欣两岁多的时候，对父母的注视和呼唤反应较为迟钝。潍坊市昌乐县五图镇卫生院工作人员在初筛时发现欣欣的异常，立即将其转到昌乐县妇幼保健院进行了复筛，又转到潍坊市妇幼保健院儿童康复科。通过标准化的筛查工具和评估方法，欣欣被确诊为孤独症。</p><p style=\"text-indent: 2em; text-align: justify;\">2022年以来，潍坊在全市推广实施0—6岁儿童孤独症筛查干预项目试点工作。目前，全市各镇街卫生院和社区卫生服务中心全部具备开展孤独症、智力发育迟缓等神经发育障碍的初步筛查能力。</p><p style=\"text-indent: 2em; text-align: justify;\">在母亲刘雯陪伴下，欣欣开始康复训练。潍坊市妇幼保健院组建由儿童保健科、儿童康复科、心理科、营养科等多学科专家组成的诊疗团队，为欣欣制定个性化治疗干预方案。张同清和同事们从一对一的密集训练、听觉统合训练开始，逐渐让欣欣融入小组课的训练、感觉统合训练等综合康复训练。6个月后，孩子情绪不稳定的频率慢慢减少，开始有模仿、听指令的意识。经过近一年半的康复训练，欣欣可以进行基本的交流。</p><p style=\"text-indent: 2em; text-align: justify;\">刘雯给孩子进行心理疏导的能力也在不断提升。一有时间，她就会参加医院组织的家长培训。去年以来，潍坊市妇幼保健院开展家长培训15次，吸引2000余人次参与，帮助家长了解孤独症及其共患病的相关知识，有效提升儿童社交、认知、理解、情绪调节与行为管理能力。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fe918b341.png', 1, 1, '2025-04-19 23:21:48');
INSERT INTO `gourmet` VALUES (59, 6, 10, '各地中小学改进体育教育 让年轻一代在运动中强意志、健身心', '<p style=\"text-indent: 2em; text-align: justify;\">近年来，青少年心理健康问题日益凸显。各地中小学校积极丰富体育活动内容，发挥体育对强健身心的重要作用。</p><p style=\"text-indent: 2em; text-align: justify;\">“每天一节体育课”在多地推广，让青少年在运动中舒展身心；飞盘、跑酷等项目走进成都校园，为青少年拓宽体育视野；北京校园体育热持续升温，丰富的班级体育比赛提升了孩子们的运动热情……青少年在体育锻炼中享受乐趣、增强体质、健全人格、锤炼意志，收获颇多。</p><p style=\"text-indent: 2em; text-align: justify;\">“孩子们运动流汗的时候，心里其实也在‘排汗’”</p><p style=\"text-indent: 2em; text-align: justify;\">新学期开学，北京、合肥、上海、深圳等地的多所中小学将每天一节体育课设为标配，并将课间从10分钟延长至15分钟。在安徽省合肥市青年路小学的一堂体育课上，学生们正进行跳绳比赛。几轮比拼后，孩子们脸蛋红扑扑的，额头冒汗，成绩一次比一次好。</p><p style=\"text-indent: 2em; text-align: justify;\">体育课天天见，给这所学校带来不小变化。自去年秋季学期实行每天一节体育课以来，该校学生的体质健康测试优良率提升了9%，近视率下降了3.84%。“参与标准定量的体育运动后，孩子们不仅身体棒棒的，也在一定程度上释放了情绪。”该校校长蔡敏表示，“孩子们运动流汗的时候，心里其实也在‘排汗’，他们的笑容更多了。”</p><p style=\"text-indent: 2em; text-align: justify;\">近年来，我国中小学校“重智轻体”的现象有所改善，但学生学业压力大、体育锻炼时间少、睡眠不足等问题依然存在，中小学生心理问题屡屡牵动人心。在加快建设教育强国和体育强国的进程中，青少年“身心并重”显得尤为重要。</p><p style=\"text-indent: 2em; text-align: justify;\">“科学研究表明，体育运动能够促进大脑释放内啡肽等神经递质，有效缓解压力和焦虑，提升人的情绪状态。”全国政协委员、中国首枚冬奥金牌获得者杨扬提出，应深刻认识体育运动的综合价值，充分发挥其在培养学生健全人格方面的作用。</p><p style=\"text-indent: 2em; text-align: justify;\">重庆市涪陵外国语学校创新课程内容，针对不同体质和兴趣的学生因材施教。减重专项体能课、心理韧性提升训练营等课程受到学生欢迎，得到家长认可；抗挫折训练、球类比赛心理辅导等特色课程也发挥了重要作用。该校校长魏昌龙表示：“学校近3年身心双育成果显著，学生自评‘运动后情绪改善’的比例达到94%。”</p><p style=\"text-indent: 2em; text-align: justify;\">体教深度融合，促进了学生体质与心智共同成长，也为校园体育工作带来启示。中国科学院心理研究所研究员魏高峡认为，将体育课安排在上午第一节课，有助于激发学生的创新性思维，提升其学业表现。</p><p style=\"text-indent: 2em; text-align: justify;\">“好的体育教育犹如阳光雨露，既强健体魄，也润泽心灵”</p><p style=\"text-indent: 2em; text-align: justify;\">在森林里上体育课是什么感觉？“鲜！”有学生大声喊出答案。</p><p style=\"text-indent: 2em; text-align: justify;\">湖南省长沙市雨花区砂子塘天华小学校长欧阳爱湘介绍，学校将森林体能课设在湖南省植物园，每月一次，学生们在绿意盎然中奔跑、跳跃，十分惬意。“好的体育教育犹如阳光雨露，既强健体魄，也润泽心灵。”欧阳爱湘说。</p><p style=\"text-indent: 2em; text-align: justify;\">“要多鼓励孩子们到阳光下锻炼。”教育部基础教育质量监测中心体育与健康组组长、北京师范大学教授李佑发表示，每周进行1至2次户外绿地体育活动，可以显著减少青少年的抑郁和焦虑情绪。</p><p style=\"text-indent: 2em; text-align: justify;\">兴趣是最好的老师。在陕西省西咸新区沣西实验学校，星卡制校园乒乓球微比赛火热进行。每个少年口袋中有一张星卡，赢球场次达标后可以升级。看着卡片上乒乓球奥运冠军的照片，六年级学生刘洋说：“榜样的力量激励着我，希望我每天都进步一点！”</p><p style=\"text-indent: 2em; text-align: justify;\">在山东省青岛西海岸新区弘德学校，校园打卡万步行、亲子共跳一根绳、“快乐周四”社团日等活动持续开展，体育锻炼已充分融入师生的日常生活。该校校长徐全宝表示：“近两年，被特色高中录取的学生人数连续刷新纪录，多名跳绳、空手道市级冠军以优异成绩考入重点高中，学校师生的精气神提升不少！”</p><p style=\"text-indent: 2em; text-align: justify;\">武术场上拳脚生风，球场上激情四溢……每逢周末，上海市第十五中学校园里人头攒动。该校整合资源，围绕足球、篮球、网球、羽毛球、乒乓球、跆拳道等项目打造周末营，供本校及周边学校的学生和家长免费参与，目前已为2000多人次提供服务。</p><p style=\"text-indent: 2em; text-align: justify;\">“越来越多的学生从‘要我练’向‘我要练’转变。”全国政协委员、中国奥委会副主席周进强表示，要不断挖掘学生的运动天赋，帮助他们掌握运动技能、养成终身运动的习惯，以健康的身心拥抱生活。</p><p style=\"text-indent: 2em; text-align: justify;\">“在比赛中学会面对输赢，这是宝贵的人生观教育”</p><p style=\"text-indent: 2em; text-align: justify;\">“节奏很好！”“坚持住！”“不要断！”北京师范大学实验小学操场上热闹非凡，跳绳比赛如火如荼。全校所有班级参加、超1800人次积极参赛，多名学生在多个项目中刷新学校纪录。</p><p style=\"text-indent: 2em; text-align: justify;\">跳绳比赛是该校的传统特色活动，学生们为此训练了好几个月。三年级学生孙吴潼赢得比赛后，与同学们拥抱庆祝。“这段时间的努力训练没有白费！”她兴奋地说，“我们都发挥得很好，真的是拧成了一股绳！”</p><p style=\"text-indent: 2em; text-align: justify;\">“在比赛中学会面对输赢，这是宝贵的人生观教育。”北京师范大学实验小学校长吴建民说，随着天气转暖，全校师生都将积极参与到班级赛中。他一一列举：4月下旬将举办全员运动会，5月启动篮球赛、三对三足球赛和啦啦操展演，6月还有排球赛……“我们希望每个学生都能找到适合自己的体育项目，尽情享受运动带来的快乐。”吴建民说。</p><p style=\"text-indent: 2em; text-align: justify;\">今年2月，北京市教委与北京市体育局联合印发《关于进一步加强新时代中小学体育工作的若干措施》，其中明确规定：中小学校每学期都要开展至少一场班级联赛。“体育比赛要从少数人参与向全员参与拓展，确保时长和质量。”北京市教委副主任、新闻发言人王攀表示，北京市教委新学期已经制定了班级赛管理办法，并拨付了支持经费，期待各校充分挖掘潜力、精心设计活动，实现“班班有比赛、人人都参与”。</p><p style=\"text-indent: 2em; text-align: justify;\">“促进青少年心理健康，校园体育赛事有重要作用。”杨扬表示，学生在赛事中互相鼓励、体验成功与挫折，不仅增强了集体荣誉感，更磨炼了他们的意志品质。在她看来，参加校园体育赛事能够促进“以体强心”，彰显了体育的育人功能。</p><p style=\"text-indent: 2em; text-align: justify;\">“校园赛事的形式需要不断创新，内容也应更加丰富。”李佑发介绍，例如可以让学生担任裁判，允许跨年级、跨班级组队等，“此外，家长也应积极参与孩子的体育生活，家校社携手营造爱运动的氛围，共同呵护青少年健康成长。”</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fa181b642.jpg', 1, 1, '2025-04-19 23:22:24');
INSERT INTO `gourmet` VALUES (60, 6, 2, '化体育“流量”为消费“增量”', '<p style=\"text-indent: 2em; text-align: justify;\">在经济社会快速发展的当下，体育消费呈快速增长态势，成为城市经济发展的新动能。在这一背景下，如何进一步拓展体育消费空间，推动体育消费潜力释放呢？我们山东青岛西海岸新区找到了自己的答案——做强“体育+”，开辟文旅体融合新赛道。</p><p style=\"text-indent: 2em; text-align: justify;\">4月6日七点半，2025青岛西海岸新区半程马拉松赛在西海岸金沙滩啤酒城鸣枪起跑，来自全国各地的15000名马拉松爱好者相聚西海岸。今年是青岛西海岸新区第八次举办半程马拉松赛，这几年，我亲眼见证了赛事从最开始不足千人到逾万人报名参与，感受到越来越多游客对这座城市的认可。</p><p style=\"text-indent: 2em; text-align: justify;\">如何进一步将这场全区规模最大的路跑赛事办出新意、办出特色？我和同事们早早就开始讨论、策划。</p><p style=\"text-indent: 2em; text-align: justify;\">我们在2024年马拉松赛中设置了新区农特产品、非物质文化遗产展示区等，丰富了参赛者的文化体验，收到了不错的反响。今年，我们不仅延续了这一亮点环节，还在现场积极推介特色旅游线路，所有参赛选手可凭借参赛证明免费或优惠游览新区各大旅游景点。</p><p style=\"text-indent: 2em; text-align: justify;\">我们深知，一场足球赛不仅是90分钟的竞技，更可以成为探索城市魅力、提振消费的新起点。近年来，赛艇、青岛时尚体育节等高水平体育赛事也如雨后春笋般在新区出现，借着一系列体育赛事的“东风”，我们积极拓展“体育+旅游”“体育+购物”“体育+夜市”等“体育+”消费场景，深入探索文化、体育、旅游融合的新场景、新体验、新赛道，有效释放体育赛事的溢出效应。比如，在中超青岛西海岸队主场附近，我们建设打造了乔家洼夜市，进一步盘活当地“夜市经济”。自2024年3月启用以来，乔家洼夜市共吸引客流量168万人次，累计销售额达3000余万元。</p><p style=\"text-indent: 2em; text-align: justify;\">不懈努力换来可喜成果，2024年新区承办各类赛事活动80余项，累计参与人数30万人次，拉动消费超1.5亿元。作为省级体育消费试点区，我们还成立了省内首个区级体育产业联合会，推出2025年“赛事100”计划，真正化体育“流量”为<span style=\"color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);\">消费“增量”。</span></p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d77086043.jpg', 1, 1, '2025-04-19 23:23:14');
INSERT INTO `gourmet` VALUES (61, 6, 2, '运动防不住血栓？警惕这三个形成因素', '<p style=\"text-indent: 2em; text-align: justify;\">篮球运动员达米安·利拉德被诊断出右小腿深静脉血栓，将无限期休战；前不久，球星文班亚马因右肩深静脉血栓，而无缘赛季剩余比赛。这两起事件引发了大众对深静脉血栓疾病的关注。</p><p style=\"text-indent: 2em; text-align: justify;\">在人们的印象里，老年人以及久坐、久卧、久站人群是深静脉血栓的主要患病群体。有着良好运动基础的职业运动员，竟然也会被深静脉血栓“栓”住，且血栓还发生在了并不常见的肩膀部位，超出了许多人的认知。</p><p style=\"text-indent: 2em; text-align: justify;\">深静脉血栓究竟是如何形成的？对患者身体有何危害？又该如何预防？记者就此采访了北京大学人民医院血管外科副主任、主任医师张韬。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>好发于下肢 偶见于上肢</strong></p><p style=\"text-indent: 2em; text-align: justify;\">张韬表示，深静脉血栓是临床最常见的血栓种类之一，指血液在深静脉中出现不正常凝结，阻塞静脉腔等，导致静脉回流障碍，继而引起的临床症状。深静脉血栓好发于下肢，临床表现为单腿肿胀、疼痛和浅静脉曲张。</p><p style=\"text-indent: 2em; text-align: justify;\">他进一步解释道，由于双腿的静脉距离心脏最远，其静脉血要克服重力回到心脏，因此下肢的深静脉最容易形成血栓。人们常说的经济舱综合征和麻将综合征，就是由于长时间保持一个坐姿且进水少等原因，导致了下肢深静脉血栓的形成。</p><p style=\"text-indent: 2em; text-align: justify;\">“静脉血流淤滞、静脉血管壁损伤和血液高凝是深静脉血栓形成的三大因素。只要满足其中任何一个或两个要素，即使是运动员也会发生深静脉血栓，甚至发病部位可能是上肢。”张韬表示。</p><p style=\"text-indent: 2em; text-align: justify;\">静脉血流淤滞指静脉血流滞缓，会增加激活的血小板和凝血因子与静脉壁接触的时间，继而形成血栓；静脉血管壁有三层，其内皮具有抗凝和抑制血小板黏附聚集的作用，静脉血管壁损伤后，便会引起血小板聚集继而形成血栓；而血液高凝则是血液在静脉系统内凝固，若还伴有静脉血流淤滞或静脉血管壁损伤，会大大增加深静脉血栓形成的概率。</p><p style=\"text-indent: 2em; text-align: justify;\">张韬认为，一方面，运动员在长期剧烈运动下，可能发生摔伤、扭伤或拉伤，一旦造成静脉血管壁损伤，血管会立即启动凝血瀑布反应，反应过激便会产生血栓。比如，一些爱好举重、攀登、网球等运动的人群，会发生上肢深静脉血栓，如腋—锁骨下血栓等。另一方面，运动员大量运动后，出汗过多且无法及时补水，会导致血液浓缩甚至是血液高凝状态，从而加剧深静脉血栓形成的风险。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>病情发展迅速 高危人群需警惕</strong></p><p style=\"text-indent: 2em; text-align: justify;\">按照血栓形成时间长短，深静脉血栓可分为急性期、亚性期以及慢性期三期。急性期深静脉血栓是指血栓形成时间不超过一周，通常处于最佳治疗时期。血栓形成时间在一个月内的，为亚性期深静脉血栓；超过一个月，则为慢性期深静脉血栓。</p><p style=\"text-indent: 2em; text-align: justify;\">“深静脉血栓一旦形成，不仅不会自行消失，还会继续生长。可能今天做检查时血栓很小，过了几天就长到十几厘米。因此，确诊深静脉血栓后，越早治疗效果越好。”张韬强调。</p><p style=\"text-indent: 2em; text-align: justify;\">张韬表示，在深静脉血栓早期阶段，首选口服药物、皮下注射等抗凝治疗方案，阻止血栓继续形成，同时要避免揉搓按摩肢体；其次，将已经形成的血栓除掉，也是常见的治疗方法。</p><p style=\"text-indent: 2em; text-align: justify;\">张韬提醒到，若深静脉血栓已发展至慢性期，患者可能会出现色素沉着，疼痛肿胀等明显症状，并伴有湿疹和溃疡。更有甚者，可能会发生血栓脱落并随血液迁移回流至肺部，造成肺栓塞，导致呼吸心脏骤停等危害生命健康。因此，久坐者、卧床者、孕妇以及有过深静脉血栓病史的人群，患血栓风险高于普通人，更应高度警惕，避免症状进一步恶化。</p><p style=\"text-indent: 2em; text-align: justify;\">那么应如何预防深静脉血栓的形成呢？张韬建议，日常饮食上，可选择清淡、新鲜食物，常吃山楂、燕麦、茄子、红薯、洋葱等有助于血管健康的食物，保持血管壁的弹性。对高危人群来说，可通过静脉足泵、间歇充气加压装置及梯度压力弹力袜等物理方法，压迫肌肉组织被动活动，促进血液循环，防止血液淤滞。</p><p style=\"text-indent: 2em; text-align: justify;\">“运动爱好者们也不必因运动员确诊深静脉血栓，而不敢运动。”张韬表示，在运动前后做好热身和放松，运动过程中保证适量补水，使血液处于相对稀释的状态，可以有效预防深静脉血栓的发生。此外，若发生运动损伤，应及时进行专业治疗，避免血栓形成。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4430fee44.jpg', 1, 1, '2025-04-19 23:23:49');
INSERT INTO `gourmet` VALUES (62, 6, 3, '疏肝健脾过清明', '<p style=\"text-indent: 2em; text-align: justify;\">春风拂面，细雨绵绵，清明节气悄然而至。清明时节气温回暖、雨水增多，自然界呈现“清气上升、浊气下降”的特点。首都医科大学附属北京中医医院耳鼻咽喉科副主任医师闫新宇介绍，此时人体肝气旺盛，易出现肝火偏旺、脾胃虚弱等问题，养生需疏肝健脾、祛湿防病，同时调节情绪，避免“悲春”伤身。</p><p style=\"text-indent: 2em; text-align: justify;\">“清明期间，饮食宜清淡，少吃油腻、生冷食物，避免加重脾胃负担。”闫新宇说，可多吃山药、薏米、茯苓等健脾食材，搭配荠菜、菠菜等春季时令蔬菜，帮助清肝火。民间有清明吃青团的习俗，但青团黏腻难消化，建议搭配陈皮茶或山楂水助消化，老人、儿童浅尝辄止即可。</p><p style=\"text-indent: 2em; text-align: justify;\">清明踏青是传统民俗。中医认为“动则生阳”，散步、放风筝等轻度运动可舒展筋骨，促进气血流通，缓解春季肝气郁结。此外，推荐练习太极拳或八段锦的“调理脾胃须单举”“五劳七伤往后瞧”招式，调和肝脾。</p><p style=\"text-indent: 2em; text-align: justify;\">在二十四节气中，只有清明兼具节气和节日双重身份。清明节是中国传统的祭祀节日，每逢清明，人们祭奠逝去的亲人，也以各种形式缅怀英烈。闫新宇介绍，清明祭扫，怀旧悼亡，有利于疏泄情志、消除不良情绪，但需遵循“哀而不伤”的原则，切勿悲伤过度。中医认为“悲伤肺，怒伤肝”，建议群众在祭奠后及时调整情绪，通过踏青赏花等户外活动感受自然生机、冲淡郁结，还可按压太冲穴，每日揉按3分钟，有助于疏肝理气。</p><p style=\"text-indent: 2em; text-align: justify;\">“清明期间，过敏与湿气困脾是常见问题，表现为花粉过敏、湿疹频发，或出现头重身困、食欲不振。”闫新宇说，建议室内勤通风除湿，可以艾灸足三里穴增强脾胃运化；也可以用防风、荆芥煮水代茶饮，祛风除湿。如因食用冷食等引发肠胃不适，可艾灸中脘穴温中散寒；腹泻时可以煮苹果水（连皮带肉煮15分钟）收敛止泻。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=84b113745.jpg', 1, 1, '2025-04-19 23:24:29');
INSERT INTO `gourmet` VALUES (63, 6, 3, '科学喂养新标杆 宝宝辅食添加更新国家标准配方', '<p style=\"text-indent: 2em; text-align: justify;\">母乳仍然是婴儿6月龄后的重要营养来源，但此时单一的母乳喂养已无法满足其全部的生长发育需求，必须逐步添加辅食。科学合理地添加婴幼儿辅助食品，不仅能提供必需的能量和营养素，还能促进婴幼儿味觉、消化系统及认知能力的发展。 《食品安全国家标准 婴幼儿谷类辅助食品》 （GB10769-2025）和《食品安全国家标准婴幼儿罐装辅助食品》（GB10770-2025）两项新国标日前出台，不仅有助于企业更好地满足消费者对高品 质、安全可靠的婴幼儿辅助食品的需求，提升婴幼儿食品市场的整体水平，也为整个行业的技术创新和可持续发展奠定了坚实基础，有助于行业长期稳定发展。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>辅食添加实现婴幼儿进食与促进感知双发育</strong></p><p style=\"text-indent: 2em; text-align: justify;\">《健康中国行动（2019-2030 年）》的合理膳食行动明确提出，完善食品安全标准体系，制定基于食品安全的营养健康标准，推动食品营养标准体系建设。《国民营养计划（2017-2030 年）》则强调，提高婴幼儿食品质量与安全水平，及时修订完善婴幼儿配方食品及辅助食品标准。</p><p style=\"text-indent: 2em; text-align: justify;\">家长们对婴幼儿的健康成长寄予厚望，所以在给宝宝添加辅食时，会选择种类丰富多样的食材。《2024年中国婴幼儿辅食行业市场发展状况及消费行为研究数据》显示，辅食种类包括婴儿营养米粉（41.13%）、 水果泥（36.26%）、蔬菜泥（33.92%）、粥（32.94%）、鸡蛋 （31.97%）、蛋黄（31.77%）、米汤或菜汁（31.38%）、肉泥 （29.82%）以及家庭自制米粉（26.12%）等。这一多样化的辅食选择趋势，不仅反映出消费者对宝宝营养均衡成长的重视，也体现出现代育儿观念的多元化和精细化。</p><p style=\"text-indent: 2em; text-align: justify;\">国家食品安全风险评估中心营养一室副研究员屈鹏峰指出，婴儿辅食添加是一个从全部乳类食物逐渐转化到食物多样化的平衡膳食的过渡阶段。首 先，婴儿满6月龄起，母乳仍然是婴儿重要的营养来源，但随着婴儿生长发育和体重的增加，婴儿胃肠道及消化器官相对发育成熟，纯母乳喂养不能完全满足婴儿对能量及营养素的全部需求，需要通过母乳以外的食物来满足能量和营养素的需要，比如，纯母乳喂养的较大婴儿，30%-50%的能量、97%的铁需要来自辅食。因此，添加辅食可以满足和补充婴儿能量和营养素需要。其次，经过最初6个月的生长发育，及时引入形态、质地相适应的食物，能有效锻炼婴儿啃咬、咀嚼、吞咽等口腔功能发展，促进婴儿进食技能发育。最后，婴儿通过进食行为，能有效促进手-眼、手-唇以及唇-舌协调等精细化运动功能的锻炼，以及促进感知觉、心理及认知和行为能力的发展。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>婴幼儿食品形态标准精细化程度再升级</strong></p><p style=\"text-indent: 2em; text-align: justify;\">随着婴幼儿营养素需要量以及婴幼儿喂养研究不断深入，此次修订在广泛借鉴国际食品标准经验的同时，充分考虑了我国婴幼儿的生长发育特点和营养素需求，存在以下主要变化。</p><p style=\"text-indent: 2em; text-align: justify;\">一是为了丰富市场婴幼儿食品品类，增加了即食婴幼儿谷类辅助食品，取消了幼儿罐装辅助食品形态大小的限制。</p><p style=\"text-indent: 2em; text-align: justify;\">二是为充分保障婴幼儿营养的安全性，增加了婴幼儿谷类辅助食品中营养素含量的最大值。</p><p style=\"text-indent: 2em; text-align: justify;\">三是为保障婴幼儿营养健康需求和我国婴幼儿营养健康状况，调整或增加了婴幼儿谷类辅助食品基本营养成分和可选择成分部分指标。</p><p style=\"text-indent: 2em; text-align: justify;\">四是防止肉毒杆菌毒素中毒，增加了不应使用蜂蜜要求。</p><p style=\"text-indent: 2em; text-align: justify;\">五是为了婴幼儿近期和远期健康，降低了婴幼儿谷类辅助食品中添加糖的供能比。</p><p style=\"text-indent: 2em; text-align: justify;\">六是污染物、真菌毒素和致病菌限量要求统一引用相关基础标准。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，新修订的标准中删除了其他食品安全国家标准基础标准中已涵盖的相关内容。同时，明确预包装婴幼儿辅助食品有婴幼儿谷类辅助食品和婴幼儿罐装辅食食品2大类。其中，婴幼儿谷类辅助食品包括婴幼儿谷物辅助食品、婴幼儿高蛋白谷物辅助食品、婴幼儿生制类谷物辅食食品和其他婴幼儿谷物辅助食品；婴幼儿罐装辅食食品包括婴幼儿汁类罐装辅食食品、婴幼儿泥糊状罐装辅助食品和婴幼儿颗粒、片（块）状罐装辅助食品。</p><p style=\"text-indent: 2em; text-align: justify;\">营养成分指标的调整是本次修订的重点。屈鹏峰指出，依据《中国居民营养与健康状况监测》等报告， 6-12月龄婴幼儿贫血率较高。考虑到婴幼儿米粉在辅食中的主导地位和庞大的消费量，修订工作将维生素C由可选择成分变为必需添加成分，以促进植物性食物中铁的吸收率，改善婴幼儿贫血状况。同时，基于现行标准，修订制定了营养素上限值。此外，基于婴幼儿辅食添加喂养原则，参照国际组织、发达国家关于婴幼儿食品中添加糖管理规定，我国将婴幼儿谷类辅助食品中的添加糖比例从30%下调至10%。</p><p style=\"text-indent: 2em; text-align: justify;\">屈鹏峰还提到，标准还对一些细节进行了优化。“婴 幼儿谷类辅助食品生产类产品，从原规定的必须煮熟食用，调整为熟制后即可食用；新研发的婴幼儿面条质地细密，既可以煮，也可以蒸，为家长带来更多便捷选择。”</p><p style=\"text-indent: 2em; text-align: justify;\">市场上食品标签上画宝宝的图片产品很多，消费者如何判断一款食品是婴幼儿辅助食品？屈鹏峰介绍：“对于消费者来讲，最简单的办法就是查看该食品的标准代号，如婴幼儿谷类辅助食品，应执行GB10769标准；婴幼儿罐装辅助食品，应执行GB10770。”</p><p style=\"text-indent: 2em; text-align: justify;\">谈及行业下一步的发展，屈鹏峰表示，新修订的婴幼儿辅助食品系列标准，对婴幼儿辅助食品市场和整个行业的发展都具有积极影响。</p><p style=\"text-indent: 2em; text-align: justify;\">一是新标准通过调整基本营养成分指标、制定营养成分最大值、下调添加糖的供能比，确保产品能够满足婴幼儿的营养健康需求，保障产品的营养充足性与安全性。</p><p style=\"text-indent: 2em; text-align: justify;\">二是新标准修订总体上扩大了产品种类，有助于企业开发更多符合市场需求的多样化产品，给消费者提供更多选择空间，满足人民群众对美好生活的需求。</p><p style=\"text-indent: 2em; text-align: justify;\">三是新标准的实施将促使企业加大在技术研发、生产工艺改进等方面的投入，推动行业技术创新和行业整体水平的提升。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=99e396f46.png', 1, 1, '2025-04-19 23:24:57');
INSERT INTO `gourmet` VALUES (64, 6, 3, '吃肉多易患糖尿病', '<p style=\"text-indent: 2em; text-align: justify;\">研究发现，吃肉可增加患2型糖尿病的风险，特别是加工肉类和未加工的红肉。</p><p style=\"text-indent: 2em; text-align: justify;\">柳叶刀子刊上发表的一项汇总分析表明，每天摄入50克加工肉类，2型糖尿病风险增加15%；每天摄入100克未加工红肉，2型糖尿病风险增加10%。每天摄入100克禽肉，糖尿病风险增加8%。</p><p style=\"text-indent: 2em; text-align: justify;\">进一步分析发现，禽肉与2型糖尿病的关联较弱，而加工肉类和未加工红肉与2型糖尿病的相关性较强。用未加工红肉或家禽肉类代替加工肉能降低2型糖尿病风险。</p><p style=\"text-indent: 2em; text-align: justify;\">研究分析了20个国家的31个研究队列的数据，共纳入近197万名成年人。在10年的中位随访期间发生107271例2型糖尿病。研究者称这是迄今为止关于肉类与2型糖尿病之间关系的最全面的证据。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=920d78c47.png', 1, 1, '2025-04-19 23:25:33');
INSERT INTO `gourmet` VALUES (65, 6, 10, '孤独症家庭的突围', '<p style=\"text-indent: 2em; text-align: justify;\">北京儿童医院8楼诊室，当11岁男孩被确诊为孤独症时，他父亲痛苦地捶打窗台，抱头大哭。一纸诊断书让他几乎丧失了生活的勇气。</p><p style=\"text-indent: 2em; text-align: justify;\">“孤独症孩子的父母要付出非常艰辛的努力，很多人都心力交瘁，感到孤立无援。”北京儿童医院精神科医生汤欣舟说，“希望全社会给予孤独症家庭更多关注。”</p><p style=\"text-indent: 2em; text-align: justify;\">4月2日，世界孤独症日。孤独症又称自闭症，医学上称之“孤独症谱系障碍”。研究显示，2017—2023年我国孤独症患病率约为7‰。截至目前，我国有超过1300万孤独症患者。近年来，随着发病率不断上升，孤独症成为备受关注的社会公共卫生问题。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>无助：被“锁死”的社交功能</strong></p><p style=\"text-indent: 2em; text-align: justify;\">张里尘是心理咨询师，跟人聊天是他的职业，也是他的特长。在成为父亲前，他想象过父子对话的场景：儿子坐在身旁，听他聊人生经历和感悟。一场又一场深度对话，编织出父子之间的精神脐带。</p><p style=\"text-indent: 2em; text-align: justify;\">命运偏偏开了玩笑。张里尘的儿子不会跟人对视，说话颠三倒四。他会忽然扔掉玩具，又眼泪巴巴地捡回，再扔出去……在北京大学第六医院，张里尘6岁的儿子被确诊为孤独症。</p><p style=\"text-indent: 2em; text-align: justify;\">“他的世界跟普通人的世界有一堵墙。”张里尘说，无法与儿子交谈，让他很失落，随即变得暴躁易怒，就像汽油桶，一点就燃。“我感觉自己的每根头发丝都竖了起来。”回忆儿子刚确诊的头两年，张里尘难掩忧伤，“我想象儿子的未来有无限可能，没想到他的某些部分早就被‘锁死’了。”</p><p style=\"text-indent: 2em; text-align: justify;\">孤独症的核心症状包括社交障碍、兴趣刻板。北京儿童医院精神科主任崔永华介绍，孤独症谱系障碍分为典型孤独症、不典型孤独症。典型孤独症更严重，不典型孤独症包括高功能孤独症、阿斯伯格综合征等，症状相对较轻。</p><p style=\"text-indent: 2em; text-align: justify;\">“典型孤独症患者毫无跟人交流的兴趣，他们完全沉浸在自己的世界，看似离我们很近，实际又很遥远，是真正的‘星星的孩子’。不典型孤独症患者可能想要社交，但又不懂社交规则，让人觉得言行怪异。”崔永华说，“实际上，不典型孤独症患者占孤独症患者数量50%以上。”</p><p style=\"text-indent: 2em; text-align: justify;\">一位家长质疑医生给出的阿斯伯格综合征诊断书，理由是孩子很聪明，能背出圆周率很多位。“判断孤独症的关键在于社交功能，而不是智商高低。”汤欣舟说。</p><p style=\"text-indent: 2em; text-align: justify;\">在一些缺乏儿童精神科医生的地区，孤独症容易被误诊为发育迟缓、精神分裂、多动症、抑郁症、焦虑症，甚至是智障等。汤欣舟在门诊遇到过许多孩子——他们用了很多药物没效果，多次检查后才发现其实患有孤独症。</p><p style=\"text-indent: 2em; text-align: justify;\">美国企业家埃隆·马斯克、中国台湾漫画家朱德庸，都自曝患有阿斯伯格综合征。“很多人以为阿斯伯格综合征是‘天才病’，这其实是很大的误解。在这些患者中，只有15%可能有某种天赋。”崔永华介绍。</p><p style=\"text-indent: 2em; text-align: justify;\">儿子会不会是被误诊？会不会随着发育完善病情好转？在儿子被确诊孤独症的第3年，张里尘抱着一丝希望又去了医院，结果还是一样。“其实，我知道我儿子跟别的孩子不同，但我不想承认。”张里尘说。</p><p style=\"text-indent: 2em; text-align: justify;\">“大部分家长的反应都是震惊、怀疑，有的互相埋怨，还有的羞愧难当。只有少数家长了解过孤独症，在来医院前就做好了心理准备。”汤欣舟说。</p><p style=\"text-indent: 2em; text-align: justify;\">也有一些家长很自责：是不是怀孕时哪里没做好，是不是养育出了问题？北京大学第六医院精神科医生赵梦婕安慰他们：“孤独症是发育性的、多因素作用的结果，不是家长行为导致的。能带孩子来精神科问诊，你们已经做了很多。”</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>解码：把交往规则变成“语法”</strong></p><p style=\"text-indent: 2em; text-align: justify;\">严重的孤独症患者，可申请智力残疾人证或精神残疾人证，领取国家补贴和相应救助福利。如果孤独症伴有多动症、癫痫、焦虑等共病，医生会根据具体情况判断是否需要用药。</p><p style=\"text-indent: 2em; text-align: justify;\">“目前，还没有方法治愈孤独症，只能通过康复训练慢慢改善。这是一个长期过程，一般至少要做1—2年的康复。只要存在症状，康复就应该继续。”崔永华说。</p><p style=\"text-indent: 2em; text-align: justify;\">幸运的是，高功能孤独症或阿斯伯格综合征患者，经过正规康复训练，很大概率可融入社会生活。</p><p style=\"text-indent: 2em; text-align: justify;\">孤独症康复训练的方法是应用行为分析疗法（ABA疗法）。这种方法就是把社交规则一步步分解，通过情景模拟让孤独症患者学习社交规则，就像教外星人学习地球人的“语法”。</p><p style=\"text-indent: 2em; text-align: justify;\">“比如，把打招呼分解成‘走近对方、在距离大约1米处暂停、说话’几个动作，然后教孩子一个个执行，就像给机器人输入一串指令。执行正确就获得奖励。”崔永华说。</p><p style=\"text-indent: 2em; text-align: justify;\">艰难的康复非常考验家长的耐心。“这些孩子不会举一反三。如果站在对面的人换了，他们可能又会手足无措。所以，要不断创造各种场景，教给他们各种社交‘答案’。”崔永华说，“等孩子们成年后，经常觉得自己的人生像在表演。”</p><p style=\"text-indent: 2em; text-align: justify;\">张里尘儿子在一年级下学期时休学，被送到一家机构做脑神经发育不全康复训练。几个月后，张里尘发现不对劲。“那儿的孩子生活几乎不能自理，完全不跟人互动。我儿子没这么严重。”</p><p style=\"text-indent: 2em; text-align: justify;\">张里尘的儿子是阿斯伯格综合征，属于不典型孤独症。多次打听后，他最终找到一家适合儿子的机构。经过几年康复治疗，他儿子终于学会了如何“得体”地接打电话。</p><p style=\"text-indent: 2em; text-align: justify;\">近年来，我国出台了《残疾预防和残疾人康复条例》《国务院关于建立残疾儿童康复救助制度的意见》等助残惠残法规政策，为孤独症患者康复提供了重要保障。</p><p style=\"text-indent: 2em; text-align: justify;\">“但是，从整体来看，孤独症的康复资源还很有限。突出问题是康复机构分布不均、专业能力参差不齐。”崔永华说。</p><p style=\"text-indent: 2em; text-align: justify;\">两年前的一条新闻，对汤欣舟的刺激很大。王先生3岁的儿子被确诊孤独症后，家人到处求医问药，最后花了50多万元才发现上当受骗。</p><p style=\"text-indent: 2em; text-align: justify;\">汤欣舟遇到过一对夫妻，为了帮孤独症孩子康复，夫妻俩带孩子尝试一些热门疗法，花了几十万元，仍然没效果。</p><p style=\"text-indent: 2em; text-align: justify;\">“孤独症家庭本来就很难，有些机构还借各种名目骗家长钱，真让人气愤。”看到孤独症家长屡屡被骗，汤欣舟决定采取行动。</p><p style=\"text-indent: 2em; text-align: justify;\">2023年11月，她和北京大学第六医院精神科医生徐凌子成立了心理咨询工作坊，引入PEERS社交训练理念。汤欣舟工作日在医院接诊，周末给孤独症家庭做康复训练和咨询。截至目前，工作坊已经帮助100多个阿斯伯格综合征患者家庭，有些孩子逐渐恢复社交功能。</p><p style=\"text-indent: 2em; text-align: justify;\">PEERS社交训练体系由美国加州大学洛杉矶分校精神医学和行为科学教授伊丽莎白·劳格松首创，是目前唯一有循证证据支持的孤独症康复训练课。其核心是通过真实情景互动锻炼社交技能，让孤独症患者在团体活动中学会社交规范。</p><p style=\"text-indent: 2em; text-align: justify;\">“为了给孤独症儿童真实的生活环境，我们越来越强调，康复训练时要营造生活化场景，做捆绑式、沉浸式训练。”崔永华说。</p><p style=\"text-indent: 2em; text-align: justify;\">“孤独症的康复治疗，越早开始效果越好。”赵梦婕强调。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>融合：“怪小孩”的求学之路</strong></p><p style=\"text-indent: 2em; text-align: justify;\">最近几次考试，张里尘的儿子都没有按时参加。“学校让我们别参加，免得拉低平均成绩。”张里尘说。</p><p style=\"text-indent: 2em; text-align: justify;\">严重的孤独症患者无法上学，有些可以去特殊学校。让家长头疼的是，智商大于70的高功能孤独症儿童和阿斯伯格综合征儿童——他们的智商可以在普通学校就读，但言行又与其他学生格格不入。</p><p style=\"text-indent: 2em; text-align: justify;\">“要么被孤立，要么被认为是找茬、没教养，影响教学秩序。最后其他家长写联名信，孩子被学校劝退。”张里尘说。</p><p style=\"text-indent: 2em; text-align: justify;\">小豆就是在普通学校就读的高功能孤独症患者。他智商正常，渴望跟人交流，但他不与人对视，跟人打招呼的方式也很“怪”，不是冒出一句动画片台词，就是不停地问：“7加4等于9，对吗？”</p><p style=\"text-indent: 2em; text-align: justify;\">上课时，小豆会突然站起来，绕教室走一圈再坐回去。不到半年，小豆被3所学校劝退。</p><p style=\"text-indent: 2em; text-align: justify;\">从事了多年儿童教育、“口袋计划”创始人吴文雄改变了小豆的求学之路。经人牵线搭桥，吴文雄成了小豆的“影子老师”，相当于特教助理、陪读老师。他陪小豆上课，提醒小豆听讲、做笔记、不要乱跑。小豆的同学好奇地问吴文雄：“叔叔，你为什么陪着他呀？”吴文雄笑着答：“因为他现在需要我。”</p><p style=\"text-indent: 2em; text-align: justify;\">小豆初中毕业的那个夏天，吴文雄陪他参加了毕业班会。小豆的班长是个女生，成绩优异。她在发言时说：“因为班里有一位孤独症的同学。我读了一本关于孤独症的小说，从而理解了这个世界的丰富和多种可能。”</p><p style=\"text-indent: 2em; text-align: justify;\">在吴文雄耐心陪读8年后，小豆考上了大学。“智商正常的孤独症孩子，也可以在普通学校顺利毕业。”回顾那漫长的8年，吴文雄语气坚定地说。</p><p style=\"text-indent: 2em; text-align: justify;\">崔永华接诊孤独症患者已有20多年。他的很多孤独症患者学业有成，有的读大学，有的读职业高中，还有的出国留学了。“他们后来从事汽修、音乐创作、软件开发等各种各样的工作。”崔永华说。</p><p style=\"text-indent: 2em; text-align: justify;\">在吴文雄做“影子老师”的这些年，大部分学校对他很关照，也有些学校不太配合。他建议有关部门出台相关举措，为“影子老师”在校内陪读提供一些政策依据。“比如，允许我们在特定时间入校，开设在学校食堂用餐的绿色通道。”</p><p style=\"text-indent: 2em; text-align: justify;\">“我们最容易忽略的就是不典型孤独症儿童。他们智商没问题，可以在普通学校上学。但经常被忽视甚至被误解，变成大家眼中的怪小孩、捣蛋鬼。”崔永华希望在全社会普及孤独症知识，争取更多包容、理解和共识。“学校和社会共同关注孤独症小孩，多帮助他们，不要否定他们的未来。”</p><p style=\"text-indent: 2em; text-align: justify;\">赵梦婕呼吁，社区应为孤独症家庭提供一些照料服务和心理支持，让孤独症儿童的家长“喘口气”。</p><p style=\"text-indent: 2em; text-align: justify;\">汤欣舟不定期举办“孤独症家长互助营”公益活动。“我们想让家长的需求被看见、情绪被释放，彼此鼓励和支持，让孤独症孩子的家长不孤独。”</p><p style=\"text-indent: 2em; text-align: justify;\">在儿子被确诊的第六年，张里尘成为家长互助营的讲师，用心理知识为焦虑的家长们纾解情绪。“因为自己淋过雨，所以想为别人撑一把伞。”张里尘说。</p><p style=\"text-indent: 2em; text-align: justify;\">最近，张里尘时常收到孤独症少年的来信，他会仔细阅读、认真回复。“给孤独症孩子做心理咨询的人太少了。我想以后开个解忧杂货铺，带孤独症孩子去路边摆摊，做体力劳动，体验简简单单的生活。”张里尘说。</p><p style=\"text-indent: 2em; text-align: justify;\">吴文雄发起的“口袋计划”，每周日举办一场公益读书会，邀请孤独症孩子和普通孩子一起阅读。“除了严重的孤独症，大多数孤独症孩子和普通孩子并非截然不同，他们就像海水和沙滩，交汇成海岸线，共同构成了人间的潮起潮落。”吴文雄说。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=55d336f48.png', 1, 1, '2025-04-19 23:25:55');
INSERT INTO `gourmet` VALUES (66, 6, 10, '关于孤独症，我有太多的“不是”想告诉你', '<p style=\"text-indent: 2em; text-align: justify;\">最近，记者在孤独症儿童康复机构蹲点调研了几周，很想说说这个群体。我发现最需要帮助的，不是孩子，而是孩子身后的妈妈，我感受到她们无声地呐喊。</p><p style=\"text-indent: 2em; text-align: justify;\">每一个孤独症患儿的背后，都有一个心如刀绞、坚强守护的母亲。关于孤独症，我有太多的“不是”想告诉你：</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>孩子确诊孤独症不是妈妈的错</strong></p><p style=\"text-indent: 2em; text-align: justify;\">被自己朝夕相处的孩子踢打、抓、咬的情况，对于孩子妈妈来说，可能是家常便饭。37岁的刘婷（化名）撩起衣袖，手臂上留着几道已经模糊的抓痕。“孩子哭闹时候抓的，不疼。”她低头搓着胳膊，“真正疼的是孩子确诊那天，亲属翻出我怀孕时点过的外卖记录，说酸辣粉里的味精影响了孩子的健康。”这3年来，她经常会因为这个场景，从梦里哭醒。</p><p style=\"text-indent: 2em; text-align: justify;\">在国内一个的孤独症“家长互助群”中，有1742位成员，群公告是“群里都是苦命的孩子，请骗子绕行”。群里是妈妈们的呼声：“喊她，也不回应，会重复问你一个问题”“孩子完全不理解别人的情绪，别人生气、生病也无所谓，没有人帮我，我发着烧孩子照样让我讲故事，不讲就满地打滚哭闹，哭到喘不过来气”“一个孩子大病，对于家庭来说就是无底洞，我常常在想，都是我的错。”</p><p style=\"text-indent: 2em; text-align: justify;\">有的孩子十几岁了，还不会叫“妈妈”，有的孩子交流时从来不看对方的眼睛；有的孩子出门如果不走直线，就会尖叫；康复到一定程度后，到达了天花板，没有办法再进步；听到有“特效疗法”时燃起希望，希望破灭后更大的失望；常常自我怀疑，究竟自己做错了什么……每一位被确诊的孩子背后，都有一位默默承受重压而陷入自我怀疑的母亲。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>孤独症不是因为家庭养育不当</strong></p><p style=\"text-indent: 2em; text-align: justify;\">过去人们常以为孤独症是由于父母养育方式不当而引起的一种儿童精神心理类疾病，甚至归类于精神分裂症。就像它以前的名字，“自闭症”，给人一种误解。</p><p style=\"text-indent: 2em; text-align: justify;\">比如历史上曾存在“冰箱母亲”（冷漠导致孤独症）的错误理论，曾给无数母亲带来痛苦，现代科学虽然已彻底否定这种归因，但在现实中，偏见仍未消除，总有人会通过多种方式暗示母亲的基因、性格、育儿技能与病因有关，让患儿母亲陷入深深自责。</p><p style=\"text-indent: 2em; text-align: justify;\">孩子确诊后，家庭内部往往会陷入相互指责。大米和小米儿童康复机构督导黄玲告诉我，不是所有的孤独症家庭都能相互支撑。到最后，可能只有妈妈一个人在努力。在孩子确诊孤独症之后，超过一半的妈妈都会受到家里长辈的责怪。职业生涯中断、夫妻关系破裂的屡见不鲜，所以康复机构一边要帮助孩子康复，一边要帮助孩子的妈妈联系妇联的救助。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>不是所有的孤独症儿童都是天才</strong></p><p style=\"text-indent: 2em; text-align: justify;\">经常可以看到，在影视作品和新闻报道中，孤独症儿童有演奏乐器、绘画、记忆、计算及日历运算能力。可数据显示，仅有不到10%的谱系儿童属于学者症候群，拥有特殊天赋，更多孩子的生活自理面临巨大困难，连系鞋带都需要分解成十几个步骤练习。总有亲戚拍着胸脯：“没关系，说不定哪天变成数学家！”对于患儿母亲来说，“天才”就像一种讽刺，让她面对生活不能自理的孩子时，有说不出的痛。</p><p style=\"text-indent: 2em; text-align: justify;\">当孩子确诊为孤独症后，往往就要有一位家庭成员被“绑定”。内地的商业保险并没有把孤独症列为报销对象，每月近万元的康复费用，年复一年不是个小数字。确诊为孤独症的人士虽然可以申请残疾证，并获得每年数万元的康复课程费用额度，但很多家庭出于各种考虑没有去办证。相比家长肩头经济压力的“巨石”，他们更担心社会歧视会压在孩子身上。</p><p style=\"text-indent: 2em; text-align: justify;\">“这些年，像捧起一团被命运揉皱又展开的锡纸，在褶皱深处寻找未被磨蚀的光斑。”一位患儿妈妈这样写道。</p><p style=\"text-indent: 2em; text-align: justify;\">她每天必须要在第7站下车，陪孩子数栏杆上的圆圈。那些被反复摩挲的铁圈，像极了评估表上“语言能力：12月龄水平”旁的星星。她知道，有些星星永远无法摘下，但至少她学会了接纳。</p><p style=\"text-indent: 2em; text-align: justify;\">4月2日是世界提高孤独症意识日。我们需要朋友圈刷屏的蓝丝带，但也希望这种温暖从4月2日延续开来，给孤独症家庭特别是苦苦支撑的患儿妈妈更多的支持；希望我们也告诉身边的孩子，不要用有色眼镜去看待这些孩子，他们和我们一样，也值得拥有灿烂的人生。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=58813b549.png', 0, 1, '2025-04-19 23:26:19');
INSERT INTO `gourmet` VALUES (67, 6, 6, '“春燥”？找到“降燥”好方法', '<p style=\"text-indent: 2em; text-align: justify;\">“最近总感觉心里烦躁，动不动就想发脾气，可能是春天到了。”这样的感叹在春季特别常见。这种现象在中医看来并非偶然，是与人体五脏与四季变化的对应有一定关系。</p><p style=\"text-indent: 2em; text-align: justify;\">进入春天，自然界经历着阴消阳长的转折期，万物开始旺盛生发，人体作为自然界的一部分，也在经历着这种调节过程。然而，现代人作息不规律、生活压力大，容易打破这种自然平衡，导致肝气郁结、阴阳失调，表现为烦躁易怒、睡眠欠佳等问题。《黄帝内经》中说：“春三月，此谓发陈，天地俱生”。春季可以配合自然界阳气生发的特点调节作息，比如适当早起，让人体阳气随着清晨的阳光而生发，起床后可以在空气流通的地方进行3~5分钟的深呼吸，既能帮助疏肝理气，又能平和心神，减少疲惫感。对于习惯晚睡或作息不规律的人群，不必操之过急，可以先从减少咖啡、茶等提神饮品入手，以固定起床时间为目标，不必过分追求早睡，循序渐进地调整作息规律。这个过程就像适应时差一样，要给予身体足够的适应时间，切忌因追求立竿见影的效果而陷入焦虑和自责。</p><p style=\"text-indent: 2em; text-align: justify;\">“动以养形，静以养神”是中医养生的重要法则，养生贵在动静结合，形神共养。在保证夜间充足优质的睡眠后，白天宜通过适度运动来调养身心。晨起可以练习10~20分钟的太极拳或八段锦，傍晚则适宜进行20~40分钟的徐缓散步。运动时以微微汗出为度，切勿过于劳累，这样既能促进气血运行，又不会耗伤阴气，这也是中医养生动静结合、阴阳调和的良好体现。</p><p style=\"text-indent: 2em; text-align: justify;\">春季饮食应遵循“春夏养阳”的原则，此时阳气虽盛于外，但内里尚虚，饮食上宜选择辛甘微温的食材，如山药、莲子、大枣等，可适量食用葱、姜、豆芽等食材，助阳气生发舒展。应当减少苦寒之品，节制冷饮冷食，以免损伤脾胃阳气。可以适当饮用一些疏肝理气的茶饮，如菊花茶、玫瑰花茶等，帮助维持肝气条达，气血通畅。</p><p style=\"text-indent: 2em; text-align: justify;\">日常穴位按摩是中医情志调节的重要手段。可每日用5~10分钟的时间，依次轻揉疏肝理气的穴位，如太冲穴（位于足背前方跖骨间隙处）、合谷穴（手掌第一、二掌骨间隙虎口处）和内关穴（腕横纹上二寸，两筋之间）等。按摩时以指腹轻柔揉按，每个穴位1~2分钟，以局部有酸胀感为度，日常多按摩这些穴位有助于舒肝解郁，宁心安神。</p><p style=\"text-indent: 2em; text-align: justify;\">居室环境的调节同样重要。保持室内温度湿度适宜，每天开窗通风，保持空气新鲜，还可以在室内摆放一些绿色植物，既能调节空气，又能养目舒心。也可以适当使用淡雅的香薰或芳香精油等，既能解郁醒脑，又可宁心安神，对调节情志、舒缓心境大有裨益。但要注意的是，如果出现持续性失眠、情绪剧烈波动或明显的身体不适，应及时就医。</p><p style=\"text-indent: 2em; text-align: justify;\">春天是一个充满活力和愉悦的季节，顺应自然规律，保持平和心态、良好生活习惯，才能让身心更好地享受这个万物复苏的时节！</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6af7b4f50.jpg', 1, 1, '2025-04-19 23:26:51');
INSERT INTO `gourmet` VALUES (68, 6, 8, 'LVA术为阿尔茨海默病治疗带来曙光？', '<p style=\"text-indent: 2em; text-align: justify;\">近日，西安交通大学第一附属医院陆港院区血管外科团队为78岁的阿尔茨海默病患者成功实施了颈深淋巴管—静脉吻合术（以下简称“LVA术”），引发广泛关注。LVA术效果怎样？治疗阿尔茨海默病是否迎来新曙光？对此，记者采访了有关专家。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>传统治疗方法效果不甚理想</strong></p><p style=\"text-indent: 2em; text-align: justify;\">阿尔茨海默病是一种复杂的神经退行性疾病，是痴呆症中最常见的形式，主要发生在老年或老年前期，因此又称“老年痴呆”。</p><p style=\"text-indent: 2em; text-align: justify;\">随着人口老龄化进程的加快和人均预期寿命的延长，我国阿尔茨海默病患者数量持续增长。根据《中国阿尔茨海默病报告2024》，我国现有阿尔茨海默病及其他痴呆症患者近1700万，其中阿尔茨海默病患者约占70%。数据显示，在60岁以上的老年人中，阿尔茨海默病的发病率超过5%；而在85岁以上的老年人中，这一比例则攀升至30%。</p><p style=\"text-indent: 2em; text-align: justify;\">阿尔茨海默病不是简单的“老糊涂”，它的本质是大脑病变，导致患者的记忆、思维、认知能力下降。其早期症状主要包括记忆力减退；逐渐出现视空间障碍，导致找不到回家的路；性格也会发生较大改变，原本好脾气的人可能会变得易怒、暴躁，原本爱干净的人可能会变得不爱整洁、不修边幅等。这不仅给患者自身带来极大痛苦，也给家庭和社会带来沉重的负担。</p><p style=\"text-indent: 2em; text-align: justify;\">国际血管外科协会委员、西安交通大学第一附属医院血管外科主任禄韶英介绍道，在阿尔茨海默病的治疗方面，传统方法主要依赖药物和心理治疗。但很多患者即便长期服药，病情依旧不断恶化，生活质量持续下降。而认知训练、行为干预等心理治疗，虽然在一定程度上能延缓认知衰退，但也无法从根本上改变疾病进程。因此，阿尔茨海默病需要新的治疗手段。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>LVA术直击“脑内毒素淤积”问题</strong></p><p style=\"text-indent: 2em; text-align: justify;\">LVA术通过在颈部建立淋巴管与静脉的吻合通道，改善脑脊液淋巴引流，降低颅内压力，促进致病蛋白排出，从而延缓甚至逆转阿尔茨海默病病情进展，为该病的中晚期患者提供了手术干预的可能。</p><p style=\"text-indent: 2em; text-align: justify;\">“研究发现，阿尔茨海默病与脑内β-淀粉样蛋白和tau蛋白异常沉积密切相关，而脑淋巴系统功能障碍则会导致清除异常蛋白能力下降，从而致病。这一点越来越受到临床医师和相关科学领域专家的关注。”航空总医院神经外二科主任王林指出，LVA术从病理机制入手，直击“脑内毒素淤积”核心问题。</p><p style=\"text-indent: 2em; text-align: justify;\">王林介绍，LVA术最初并非用于治疗阿尔茨海默病，而是针对颈部淋巴水肿的治疗方法。医生在治疗面部淋巴水肿患者时，意外发现患者的阿尔茨海默病症状得到了缓解。这一现象引发了医学界对LVA术治疗阿尔茨海默病的探索。</p><p style=\"text-indent: 2em; text-align: justify;\">“我们发现，采用淋巴结与静脉的大口径吻合方式（如颈内静脉），效果更稳定且安全性较高。”禄韶英介绍说。国内多中心数据显示，LVA术后患者简明精神状态量表（MMSE）评分提升30%—50%，部分患者认知功能较术前明显改善，术后次日即可恢复活动，住院周期缩短至5—7天。</p><p style=\"text-indent: 2em; text-align: justify;\">“LVA术不仅为患者及其家庭带来了希望，也为医学界治疗阿尔茨海默病提供了新的思路，有望成为传统药物治疗的重要补充，可能为药物疗效不佳的中重度患者，带来更为显著的临床获益。”中国微循环学会神经变性病专业委员会副主任委员兼秘书长、航空总医院神经内一科主任邢岩说。此外，LVA术需要神经内科与神经外科等多学科的深度协作，这为其他复杂疾病的综合治疗提供了有益借鉴。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>新技术大范围推广仍需谨慎</strong></p><p style=\"text-indent: 2em; text-align: justify;\">尽管LVA术对阿尔茨海默病展现出令人期待的治疗效果，但受访医生对此均持谨慎态度。他们认为LVA术仍处于临床探索阶段，并非适用于所有阿尔茨海默病患者，同时也存在一定风险。</p><p style=\"text-indent: 2em; text-align: justify;\">最大的挑战来自技术层面，LVA术对医生显微外科技术和解剖经验要求极高。禄韶英坦言，颈部解剖结构复杂，淋巴管透明纤细，直径仅为0.3毫米至0.5毫米。在密集的血管、神经丛中精准定位并吻合，这极为考验医生的技术水平，稍有不慎就可能引发大出血或神经损伤。</p><p style=\"text-indent: 2em; text-align: justify;\">同时，开展LVA术存在较为严重的设备依赖。荧光显微镜等专用设备不可或缺。然而，一台国产设备成本超百万元，进口设备更是高达四五百万元，多数基层医院难以负担。</p><p style=\"text-indent: 2em; text-align: justify;\">“关键在于，有关手术的核心操作尚未统一学术共识。”禄韶英详细解释说，以吻合部位（淋巴管、淋巴结或淋巴瓣）及静脉选择为例，各医院标准不一，仍处于各自探索阶段。</p><p style=\"text-indent: 2em; text-align: justify;\">同时，不少受访医生也表达了自己的担忧：关于阿尔茨海默病的病理机制研究仍存在空白。LVA术的疗效源于偶然发现，虽推测与加速脑内淋巴引流、清除淀粉样蛋白相关，但具体机制并不明朗，缺乏严谨科学验证。</p><p style=\"text-indent: 2em; text-align: justify;\">“并非所有患者都适合接受LVA术。”禄韶英直言，LVA术主要适用于中重度阿尔茨海默病患者，且常规药物治疗无效、心肺功能良好、预期寿命超过5年的患者。</p><p style=\"text-indent: 2em; text-align: justify;\">“对于药物治疗有效的轻症患者，手术带来的潜在风险可能大于收益。”禄韶英并不建议这类病人进行此项手术。他表示，与其他外科手术一样，LVA术可能会出现出血、感染、麻醉意外、心跳呼吸骤停等常规并发症，对患者的生命健康造成威胁。手术效果也因人而异，存在不可预测的术后反应。</p><p style=\"text-indent: 2em; text-align: justify;\">此外，缺乏完整检查或无法配合评估的患者也不适合手术。这类患者无法准确判断身体状况和手术风险，可能在手术过程中出现意外情况。</p><p style=\"text-indent: 2em; text-align: justify;\">“目前LVA术仍处于临床探索阶段，其长期疗效和适用范围仍需进一步验证。”邢岩提醒，患者、家属和医生都应对LVA术保持理性和谨慎的态度。未来，仍需要更多的临床研究和病例积累，结合基础研究，以明确手术的最佳适应证，优化手术流程，进一步降低手术风险。</p><p style=\"text-indent: 2em; text-align: justify;\">“总体而言，LVA术作为新兴疗法，需要更多规范化的多中心研究和临床实践支撑。”邢岩说。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=974f75851.png', 0, 1, '2025-04-19 23:27:26');
INSERT INTO `gourmet` VALUES (69, 6, 10, '将运动营养学融入高校体育教育教学', '<p style=\"text-indent: 2em; text-align: justify;\">20世纪80年代，我国提出体育强国战略，国民对自身健康水平的关注度不断提高，社会各界人士都十分重视体育运动与锻炼。高校亦是如此，对大学生开展更加科学健康的体育教育来提高学生身体素质成为学校的重点关注课题。高校不仅仅要重视体育教学中的运动锻炼，还应重视运动营养的补充，将运动营养学理论融入体育教学，指导学生根据运动项目明确自身所需的营养，并及时采取合理措施进行营养补充，以确保获取营养满足自身运动需求。</p><p style=\"text-indent: 2em; text-align: justify;\">人体在运动时主要消耗水分、电解质、脂肪、糖类、蛋白质等营养物质。其中水是人体运动时消耗最大的物质，尤其在长时间高强度剧烈运动下；脂肪、糖类等营养物质通过氧化分解作用来释放能量，为人体运动供能，一般优先糖类分解，只有当身体内糖类储备不足时，脂肪才会发生分解；蛋白质会被分解为氨基酸等物质，但这一营养物质很少参与能量代谢，主要用于维持人体肌肉、骨骼等组织的正常功能，是人体进行体育运动的关键。研究发现，高校体育教学中，大学生对体育运动后消耗营养的正确补充缺乏重视，部分学生存在缺乏营养补充行为，还有部分学生则滥用营养补充，这些行为都会影响大学生体质健康。为此，笔者认为，高校应将运动营养学理论纳入体育教学，指导学生正确进行营养补充，并从以下几方面开展相关工作。</p><p style=\"text-indent: 2em; text-align: justify;\">第一，优化高校体育教学课程体系。运动营养学理论适用于不同运动场景，为提高教学效果，真正帮助学生强化身体机能，高校需将运动营养学课程与具体运动项目相结合，构建运动项目+营养模块的课程，打造体育课程矩阵。如田径专项教学模块中，田径运动多为中短距离运动，对学生爆发力、速度及耐力要求较高，其能量代谢方式主要为有氧代谢，整体以糖类、脂肪等营养物质的消耗为主，教师不仅要重视相关田径运动技能的教学，也应重视田径运动中的运动营养补充理论与实践教学。其中理论教学主要告知学生可将该运动项目的运动营养补充重点放在糖类和脂肪上，并向学生说明其运动营养补充的具体原理，如运动前补充葡萄糖可提高机体的肌糖原和肝糖原储备，运动后补糖可以促进机体糖原储备尽快恢复，从而消除疲劳；实践教学中则需要制定具体的营养补充方案，指导学生科学补充此类营养物质，以快速恢复提升体力并提高运动速度与耐力，如学生可在田径运动前20分钟内和运动后立即进行补糖，通过合理补充营养物质来增强体质，提高田径运动能力。</p><p style=\"text-indent: 2em; text-align: justify;\">第二，构建专业教练+营养师的师资队伍。为更好地指导体育教学中运动营养学的开展与实践，高校应加强体育教师队伍建设，组建一支包括专业体育训练员+营养师的教学队伍，二者协同提高学生体育运动水平与营养补充质量。如高校开展游泳教学课程时，除游泳教练外，还应聘请专业的营养师，其中教练专注于学生游泳技能教学，帮助学生提高游泳水平；营养师则专注于运动营养教学，让学生充分理解游泳运动涉及的营养基本知识，并为其进行日常训练及比赛前后的饮食与营养提供实际指导。在二者的共同努力下，学生的游泳水平与身体机能得以大幅提升。另外，高校应建立学生营养健康档案，详细记录学生日常体育运动的营养数据。结合运动营养学课程教学评价及学生营养健康档案管理，学校可充分了解学生的成长发育及体育锻炼情况，并及时调整医疗营养资源分配及体育教学规划。</p><p style=\"text-indent: 2em; text-align: justify;\">第三，建设运动营养学课程实践平台。为促进运动营养学在高校体育教学中的深度融合，高校可开发建设运动营养学课程实践平台，指导学生更好地进行营养补充。如高校可为学生配备智能化可穿戴设备，将运动营养学课程教学融入其中，通过精确检测学生运动前后的能量与营养物质消耗，来指导营养师为学生规划更加合理的营养补充方案。高校还可利用虚拟现实技术等先进信息技术构建虚拟教学平台，让学生在虚拟环境下体验不同运动项目的膳食营养搭配，掌握更多运动营养学相关知识。此外，学校还可组织学生参与运动膳食调查、食谱编制等社会实践活动，让学生通过制作动画视频、展示图片等方式进行学习，提高学生对运动营养学理论的认识，鼓励学生通过运动营养补充来提高身体机能及健康水平。</p><p style=\"text-indent: 2em; text-align: justify;\">总之，运动营养学在高校体育教学中的融入具有重要意义。高校应结合课程教学内容和学生实际需求来开展运动营养教学，以提高学生运动营养学知识储备，并引导学生将理论知识应用于实际生活来有效提升身体素质。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b0e0e0052.jpg', 0, 1, '2025-04-19 23:28:12');
INSERT INTO `gourmet` VALUES (70, 6, 6, '钙化：人体的一把双刃剑', '<p style=\"text-indent: 2em; text-align: justify;\">近期，一位知名演员因身体疑似出现肌腱钙化导致右臂活动受限的消息登上微博热搜，引发热议。“钙化”这个原本较为专业的医学术语，也借此走进大众视野。</p><p style=\"text-indent: 2em; text-align: justify;\">其实，“钙化”一词是检查报告上的“常客”，如血管钙化、结节钙化、肌腱钙化、肿瘤钙化等。身体器官组织的钙化是如何形成的？不同部位的钙化有何症状？应如何应对？记者就上述问题采访了相关专家。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>钙盐异常沉积致病理性钙化</strong></p><p style=\"text-indent: 2em; text-align: justify;\">钙是人身体含量最多、最重要的矿物质之一，主要以磷酸钙、碳酸钙等钙盐的形式存在，90%分布在骨骼中，1%在血管内，其余在牙齿中。所谓钙化，通常指钙盐在身体内某些组织或器官的沉积，这一过程通常被学者分为“生理性钙化”和“病理性钙化”。</p><p style=\"text-indent: 2em; text-align: justify;\">生理性钙化是一种必要且正常的生理现象，如婴幼儿成长过程中骨骼的增长、牙齿的形成等。</p><p style=\"text-indent: 2em; text-align: justify;\">以骨生长为例，“骨骼由有机质和无机质构成，有机质包括蛋白组织、胶原蛋白等，无机质包括磷酸钙等钙盐。如果将骨骼看成一根水泥柱，纤维状的胶原蛋白就像是钢筋，为‘柱子’提供结构支撑。而磷酸钙等钙盐的不断沉积就像是附着在钢筋上的、逐渐增厚的水泥，让骨骼坚硬起来。”航空总医院骨关节外科副主任王冉东给科技日报记者打了个形象的比方。</p><p style=\"text-indent: 2em; text-align: justify;\">病理性钙化，顾名思义，即体内钙盐的异常沉积。“临床上提及的绝大部分钙化是病理性的。”中日友好医院骨关节外科主任王卫国在接受采访时表示，很多病理性钙化是在人体病变修复过程中形成的，整个过程和伤口愈合结痂类似。</p><p style=\"text-indent: 2em; text-align: justify;\">王卫国以肩袖钙化举例，进一步解释了病理性钙化的形成过程。肩袖由肩部的4根肌腱组成，对肩关节的旋转功能和维持稳定起重要作用。当肩袖由于运动不当或老化退变等原因受损时，它的表面就会变得毛糙或局部出现致炎因子。这些“变量”就像卤水点豆腐似的，让体内原本“安安分分”的钙盐在此处析出、沉积，严重时会给患处带来灼伤般的剧烈疼痛。</p><p style=\"text-indent: 2em; text-align: justify;\">“在X线或CT等医学影像中，钙化部位往往表现为高密度的亮白斑块。”王卫国补充道。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>可发生于多种组织器官</strong></p><p style=\"text-indent: 2em; text-align: justify;\">病理性钙化并非特指某一种疾病，可以发生于多种组织和器官。它出现在身体不同的部位，可能会带来不一样的麻烦。</p><p style=\"text-indent: 2em; text-align: justify;\">文章开头提到的肌腱钙化，又称钙化性肌腱炎，是骨科中最为常见的一种病理性钙化。其主要包括前文提及的肩袖钙化、肘关节钙化和跟腱钙化，临床症状包括肩肘或足跟部剧烈疼痛、患处压痛明显、患肢无力、手臂上举困难、活动受限等。</p><p style=\"text-indent: 2em; text-align: justify;\">王卫国指出，病理性钙化还常出现在血管壁、肺结节、感染坏死灶、良恶性肿瘤、肌腱末端等器官或组织中。</p><p style=\"text-indent: 2em; text-align: justify;\">血管钙化是动脉粥样硬化、高血压、糖尿病血管病变、血管损伤、衰老等普遍存在的共同的病理表现，症状主要表现为血管壁僵硬性增加，易引发血栓形成、斑块破裂，是心脑血管疾病高发病率和高死亡率的重要因素之一。</p><p style=\"text-indent: 2em; text-align: justify;\">有些感染性疾病，如肺结核和骨结核，在感染灶中的结核肉芽肿或坏死骨内也可能发生钙化。</p><p style=\"text-indent: 2em; text-align: justify;\">一些良性或恶性肿瘤在增殖的过程中，其内部组织会因营养“供不上”而出现大量坏死，从而诱使肿瘤内部钙化。众多研究认为，钙化组织越大，肿瘤恶性程度可能越低。反之，针尖样、颗粒样、点状等微小钙化组织则可能提示肿瘤恶性程度较高。另外，软骨来源的骨肿瘤，如软骨瘤、内生软骨瘤和软骨肉瘤等，钙化也是其显著的病变特征之一。</p><p style=\"text-indent: 2em; text-align: justify;\">病理性钙化带来的也并非都是坏消息。肺结节有良性和恶性之分。钙化多出现于良性肺结节中，而恶性肺结节很可能不会出现钙化症状，如不及时干预，或将发展为肺癌。从这一角度来看，肺结节中的钙化是一个难得的利好信号。</p><p style=\"text-indent: 2em; text-align: justify;\">并非所有病理性钙化都有症状，有的病理性钙化是没有症状的。王卫国告诉记者，在腰腹部的软组织中，钙化灶外围易形成一层坚韧的软组织壁，就像松子的外壳一样将钙化灶这颗“松子仁”紧密包裹起来，不与其他组织器官接触，从而不会造成不适感觉。因此，这种情况很难预知，通常是在体检等影像学检查中查出，一般也无需采取干预措施。</p><p style=\"text-indent: 2em; text-align: justify;\"><strong>病因多样且存在个体差异</strong></p><p style=\"text-indent: 2em; text-align: justify;\">除了症状不一外，病理性钙化的病因也复杂多样，且不同钙化的高危人群、治疗方式也不尽相同。王冉东告诉记者，理论上，凡是能够引发细胞或组织器官损伤的病因都可能诱发相应组织的病理性钙化，如感染和炎症、组织器官老化、肿瘤等。</p><p style=\"text-indent: 2em; text-align: justify;\">谈及高危人群，王冉东指出，经常进行羽毛球、网球等投掷运动的人更容易患上肩袖钙化，经常打乒乓球、做家务等进行关节旋转运动的人更容易患上肘关节钙化，经常跑步、跳绳的人更容易患上跟腱钙化。老年人或长期高盐饮食人群患血管钙化的风险更高。痛风患者更容易出现肌腱钙化。甲状旁腺功能亢进、糖尿病等基础病患者由于体内钙磷代谢紊乱异常，更容易出现骨骼相关的钙化。</p><p style=\"text-indent: 2em; text-align: justify;\">谈及治疗方式，王冉东告诉记者，血管钙化、肿瘤钙化等需针对其原发病采取干预措施。对于肌腱钙化等，轻症可采取理疗、推拿按摩等保守方式治疗，或采用布洛芬、扶他林等消炎镇痛、活血化瘀药物缓解不适感；若以上方式不奏效，则可采用超声波将钙化组织打散、让身体重新吸收；更有甚者，如剧烈的疼痛感已经严重影响到睡眠者，或需利用手术将钙化组织取出。</p><p style=\"text-indent: 2em; text-align: justify;\">两位受访者都提到，病理性钙化很难精准预防。原因就在于它病因多样，且个体差异性强。</p><p style=\"text-indent: 2em; text-align: justify;\">“建议大家尽量减少高盐、高脂、高糖摄入，保持健康饮食。”王冉东提醒，运动时注意使用正确的姿势，保持良好的习惯，秉持适度适量的原则。如运动前做好热身、运动后进行拉伸，跑步时鞋内垫上缓冲鞋垫、打球时戴上相应护具，运动后对酸胀部位进行适当热敷等。如果运动后某些部位总是出现酸胀感，就应适当减少运动时长或运动强度，找到身体与运动量的最佳平衡点。也可以有针对性地强化该部位的肌肉力量后，再适当增加运动量。如果出现剧烈疼痛或其他不适症状，建议及时就医。</p>', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=aa8f89453.png', 1, 1, '2025-04-19 23:29:04');

-- ----------------------------
-- Table structure for health_model_config
-- ----------------------------
DROP TABLE IF EXISTS `health_model_config`;
CREATE TABLE `health_model_config`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '健康模型自增主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置名',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置图标',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置单位',
  `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置符号',
  `is_global` tinyint(1) NULL DEFAULT NULL COMMENT '是否是全局模型',
  `value_range` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '正常值范围',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '健康模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of health_model_config
-- ----------------------------
INSERT INTO `health_model_config` VALUES (1, 1, '身高', '身高模型，选择该模型可记录身高', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=00437b2c8379f0身高.png', 'cm', 'Height', 1, '0,500');
INSERT INTO `health_model_config` VALUES (2, 1, '体重', '该模型为体重参数，记录时选中即可', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=43b337eb2888c7体重.png', 'KG', 'Weight', 1, '0,500');
INSERT INTO `health_model_config` VALUES (3, 1, '每日喝水量', '记录一日的饮水量', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a0aa6cbsharpicons_water-bottle.png', 'ml', '毫升', 1, '1000,2000');
INSERT INTO `health_model_config` VALUES (4, 1, '谷丙转氨酶', '专属记录转氨酶', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6ca8bef04d7bcf转氨酶.png', 'U/L', 'ALT', 1, '108,258');
INSERT INTO `health_model_config` VALUES (5, 1, '每日睡眠时长', '记录一日睡眠时长', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dabda1e健康数据.png', '小时', 'h', 1, '5,10');
INSERT INTO `health_model_config` VALUES (6, 1, '刷牙记录', '记录每日刷牙次数', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ac252c4健康牙齿.png', '次', NULL, 1, '1,2');
INSERT INTO `health_model_config` VALUES (7, 1, '运动心率', '运动时心率', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b8cb9108db294f心率.png', '次/分', 'Bpm', 1, '75,197');
INSERT INTO `health_model_config` VALUES (8, 1, '夜间血压', '夜间血压测量值', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=47b7422536807e血压.png', '毫米汞柱', 'mmHg', 1, '72,145');
INSERT INTO `health_model_config` VALUES (9, 1, '夜跑步数', '记录夜跑步数', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e1e0560icon_健康打卡.png', '步', '暂无', 1, '422,17990');
INSERT INTO `health_model_config` VALUES (10, 1, '晨跑步数', '记录晨跑时的步数', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c7331201cd680d步数.png', '步', '暂无', 1, '3000,10000');
INSERT INTO `health_model_config` VALUES (11, 1, '空腹血糖', '预防糖尿病', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=003fe13皮肤.png', '毫摩尔/升', NULL, 1, '4,6');
INSERT INTO `health_model_config` VALUES (12, 1, '心率', '预防冠心病、高血压', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8df5afe心脏.png', '次/分', NULL, 1, '60,100');
INSERT INTO `health_model_config` VALUES (13, 1, '血脂', '预防疾病', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=27c2ff1肝脏.png', '毫摩尔/升', 'mol/L', 1, '2,5');
INSERT INTO `health_model_config` VALUES (14, 1, '体温', '记录体温', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=178dde2温度计.png', '℃', '摄氏度', 1, '36,38');
INSERT INTO `health_model_config` VALUES (15, 2, '硒酵母', '每日硒酵母摄入', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c406bb5药物.png', 'mcg', NULL, 0, '200,300');
INSERT INTO `health_model_config` VALUES (20, 29, '身体总水分', '身体总水分指人体内所含水分的总量', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=aae9ad8绘制身体总水分小图标.png', '千克', 'TBW', 1, '40,60');
INSERT INTO `health_model_config` VALUES (21, 29, '脂肪', '身体脂肪是能量储备、体温调节的重要物质', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=38704b1生成脂肪图片.png', '克/百分比', 'BF', 1, '7000,20000');
INSERT INTO `health_model_config` VALUES (22, 29, '蛋白质', '蛋白质是构成人体细胞、组织的重要成分', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7e9b19b生成脂肪图片 (1).png', '克', 'PRO', 1, '65,180');
INSERT INTO `health_model_config` VALUES (23, 29, '肌肉', '肌肉是人体运动、代谢的核心组织，参与力量支撑、基础代谢维持', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=99367e5绘制肌肉图标.png', '千克', 'MM', 1, '20,60');
INSERT INTO `health_model_config` VALUES (24, 29, '基础代谢率', '基础代谢率指人体清醒静息状态下（无运动、消化等额外消耗 ），维持心跳、呼吸、体温等基本生理功能的能量消耗', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=01778a1生成二次元图标.png', '千卡', 'BMR', 1, '1200,2000');
INSERT INTO `health_model_config` VALUES (25, 29, '内脏脂肪等级', '内脏脂肪等级反映腹腔内内脏周围脂肪堆积程度', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b422a4dQQ截图20250619221352.png', '级', 'VFL', 1, '1,9');

-- ----------------------------
-- Table structure for health_plan
-- ----------------------------
DROP TABLE IF EXISTS `health_plan`;
CREATE TABLE `health_plan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_date` date NOT NULL,
  `target_calories` int NOT NULL,
  `exercise_minutes` int NOT NULL,
  `sleep_hours` decimal(3, 1) NOT NULL,
  `water_cups` int NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of health_plan
-- ----------------------------
INSERT INTO `health_plan` VALUES (2, 2, '2025-03-06', 2000, 32, 9.0, 10, '2025-03-05 20:15:38', '2025-03-05 21:45:38');
INSERT INTO `health_plan` VALUES (4, 2, '2025-03-07', 2000, 33, 8.0, 8, '2025-03-05 21:46:08', '2025-04-16 20:29:52');
INSERT INTO `health_plan` VALUES (5, 2, '2025-04-16', 2000, 30, 8.0, 8, '2025-04-16 20:08:20', '2025-04-16 20:08:20');
INSERT INTO `health_plan` VALUES (6, 2, '2025-04-16', 2012, 30, 8.0, 8, '2025-04-16 20:30:03', '2025-04-16 20:30:02');
INSERT INTO `health_plan` VALUES (7, 2, '2025-05-16', 2000, 30, 8.0, 8, '2025-05-16 18:55:14', '2025-05-16 18:55:13');
INSERT INTO `health_plan` VALUES (8, 2, '2025-05-16', 2000, 30, 8.0, 8, '2025-05-16 19:22:40', '2025-05-16 19:22:40');
INSERT INTO `health_plan` VALUES (9, 2, '2025-05-17', 2000, 30, 8.0, 8, '2025-05-17 09:00:41', '2025-06-20 09:42:35');

-- ----------------------------
-- Table structure for interaction
-- ----------------------------
DROP TABLE IF EXISTS `interaction`;
CREATE TABLE `interaction`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '互动表主键ID',
  `type` int NULL DEFAULT NULL COMMENT '互动类型（1：点赞；2：收藏；3：浏览；4：评分）',
  `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型，表示的就是互动属于哪一个模块的东西',
  `content_id` int NULL DEFAULT NULL COMMENT '内容ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `score` int NULL DEFAULT NULL COMMENT '评分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '互动时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '互动信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of interaction
-- ----------------------------
INSERT INTO `interaction` VALUES (1, 3, 'VIEW', 17, 2, NULL, '2025-04-19 20:59:30');
INSERT INTO `interaction` VALUES (2, 3, 'VIEW', 1, 2, NULL, '2025-04-19 20:59:35');
INSERT INTO `interaction` VALUES (3, 3, 'VIEW', 18, 2, NULL, '2025-04-19 21:00:47');
INSERT INTO `interaction` VALUES (4, 4, 'RATING', 18, 2, 5, '2025-04-19 22:01:58');
INSERT INTO `interaction` VALUES (5, 1, 'UPVOTE', 18, 2, NULL, '2025-04-19 22:02:32');
INSERT INTO `interaction` VALUES (6, 2, 'COLLECTION', 18, 2, NULL, '2025-04-19 22:02:33');
INSERT INTO `interaction` VALUES (7, 3, 'VIEW', 23, 4, NULL, '2025-04-19 22:17:24');
INSERT INTO `interaction` VALUES (8, 3, 'VIEW', 4, 4, NULL, '2025-04-19 22:40:32');
INSERT INTO `interaction` VALUES (9, 1, 'UPVOTE', 4, 4, NULL, '2025-04-19 22:40:35');
INSERT INTO `interaction` VALUES (10, 2, 'COLLECTION', 4, 4, NULL, '2025-04-19 22:40:36');
INSERT INTO `interaction` VALUES (11, 3, 'VIEW', 5, 4, NULL, '2025-04-19 22:41:40');
INSERT INTO `interaction` VALUES (12, 1, 'UPVOTE', 5, 4, NULL, '2025-04-19 22:41:42');
INSERT INTO `interaction` VALUES (13, 2, 'COLLECTION', 5, 4, NULL, '2025-04-19 22:41:42');
INSERT INTO `interaction` VALUES (14, 4, 'RATING', 5, 4, 5, '2025-04-19 22:41:51');
INSERT INTO `interaction` VALUES (15, 3, 'VIEW', 11, 4, NULL, '2025-04-19 22:41:54');
INSERT INTO `interaction` VALUES (16, 4, 'RATING', 11, 4, 5, '2025-04-19 22:41:55');
INSERT INTO `interaction` VALUES (17, 3, 'VIEW', 14, 4, NULL, '2025-04-19 22:41:57');
INSERT INTO `interaction` VALUES (18, 4, 'RATING', 14, 4, 4, '2025-04-19 22:41:58');
INSERT INTO `interaction` VALUES (19, 3, 'VIEW', 2, 4, NULL, '2025-04-19 22:42:03');
INSERT INTO `interaction` VALUES (20, 4, 'RATING', 2, 4, 4, '2025-04-19 22:42:04');
INSERT INTO `interaction` VALUES (21, 1, 'UPVOTE', 2, 4, NULL, '2025-04-19 22:42:06');
INSERT INTO `interaction` VALUES (22, 2, 'COLLECTION', 2, 4, NULL, '2025-04-19 22:42:07');
INSERT INTO `interaction` VALUES (23, 3, 'VIEW', 1, 4, NULL, '2025-04-19 22:42:12');
INSERT INTO `interaction` VALUES (24, 4, 'RATING', 1, 4, 4, '2025-04-19 22:42:14');
INSERT INTO `interaction` VALUES (25, 1, 'UPVOTE', 1, 4, NULL, '2025-04-19 22:42:17');
INSERT INTO `interaction` VALUES (26, 2, 'COLLECTION', 1, 4, NULL, '2025-04-19 22:42:18');
INSERT INTO `interaction` VALUES (27, 3, 'VIEW', 15, 3, NULL, '2025-04-19 22:43:01');
INSERT INTO `interaction` VALUES (28, 4, 'RATING', 15, 3, 4, '2025-04-19 22:43:03');
INSERT INTO `interaction` VALUES (29, 1, 'UPVOTE', 15, 3, NULL, '2025-04-19 22:43:05');
INSERT INTO `interaction` VALUES (30, 2, 'COLLECTION', 15, 3, NULL, '2025-04-19 22:43:06');
INSERT INTO `interaction` VALUES (31, 3, 'VIEW', 4, 3, NULL, '2025-04-19 22:43:10');
INSERT INTO `interaction` VALUES (32, 4, 'RATING', 4, 3, 5, '2025-04-19 22:43:11');
INSERT INTO `interaction` VALUES (33, 1, 'UPVOTE', 4, 3, NULL, '2025-04-19 22:43:13');
INSERT INTO `interaction` VALUES (34, 2, 'COLLECTION', 4, 3, NULL, '2025-04-19 22:43:14');
INSERT INTO `interaction` VALUES (35, 3, 'VIEW', 12, 3, NULL, '2025-04-19 22:43:29');
INSERT INTO `interaction` VALUES (36, 4, 'RATING', 12, 3, 4, '2025-04-19 22:43:31');
INSERT INTO `interaction` VALUES (37, 1, 'UPVOTE', 12, 3, NULL, '2025-04-19 22:43:32');
INSERT INTO `interaction` VALUES (38, 3, 'VIEW', 5, 3, NULL, '2025-04-19 22:43:37');
INSERT INTO `interaction` VALUES (39, 4, 'RATING', 5, 3, 4, '2025-04-19 22:43:39');
INSERT INTO `interaction` VALUES (40, 1, 'UPVOTE', 5, 3, NULL, '2025-04-19 22:43:40');
INSERT INTO `interaction` VALUES (41, 2, 'COLLECTION', 5, 3, NULL, '2025-04-19 22:43:40');
INSERT INTO `interaction` VALUES (42, 3, 'VIEW', 1, 3, NULL, '2025-04-19 22:43:45');
INSERT INTO `interaction` VALUES (43, 4, 'RATING', 1, 3, 4, '2025-04-19 22:43:47');
INSERT INTO `interaction` VALUES (45, 2, 'COLLECTION', 1, 3, NULL, '2025-04-19 22:43:49');
INSERT INTO `interaction` VALUES (46, 3, 'VIEW', 14, 3, NULL, '2025-04-19 22:43:54');
INSERT INTO `interaction` VALUES (47, 4, 'RATING', 14, 3, 4, '2025-04-19 22:43:55');
INSERT INTO `interaction` VALUES (48, 1, 'UPVOTE', 14, 3, NULL, '2025-04-19 22:43:56');
INSERT INTO `interaction` VALUES (49, 3, 'VIEW', 36, 3, NULL, '2025-04-19 22:51:15');
INSERT INTO `interaction` VALUES (50, 3, 'VIEW', 35, 3, NULL, '2025-04-19 22:51:18');
INSERT INTO `interaction` VALUES (51, 1, 'UPVOTE', 35, 3, NULL, '2025-04-19 22:51:20');
INSERT INTO `interaction` VALUES (52, 4, 'RATING', 35, 3, 4, '2025-04-19 22:51:23');
INSERT INTO `interaction` VALUES (53, 3, 'VIEW', 11, 3, NULL, '2025-04-19 22:51:35');
INSERT INTO `interaction` VALUES (54, 1, 'UPVOTE', 11, 3, NULL, '2025-04-19 22:51:36');
INSERT INTO `interaction` VALUES (55, 3, 'VIEW', 2, 3, NULL, '2025-04-19 22:51:40');
INSERT INTO `interaction` VALUES (56, 4, 'RATING', 2, 3, 5, '2025-04-19 22:51:42');
INSERT INTO `interaction` VALUES (57, 1, 'UPVOTE', 2, 3, NULL, '2025-04-19 22:51:44');
INSERT INTO `interaction` VALUES (58, 2, 'COLLECTION', 2, 3, NULL, '2025-04-19 22:51:45');
INSERT INTO `interaction` VALUES (59, 3, 'VIEW', 34, 3, NULL, '2025-04-19 22:51:50');
INSERT INTO `interaction` VALUES (60, 4, 'RATING', 34, 3, 4, '2025-04-19 22:51:51');
INSERT INTO `interaction` VALUES (61, 3, 'VIEW', 16, 3, NULL, '2025-04-19 22:51:57');
INSERT INTO `interaction` VALUES (62, 4, 'RATING', 16, 3, 4, '2025-04-19 22:51:59');
INSERT INTO `interaction` VALUES (63, 1, 'UPVOTE', 16, 3, NULL, '2025-04-19 22:52:00');
INSERT INTO `interaction` VALUES (64, 3, 'VIEW', 3, 3, NULL, '2025-04-19 22:52:04');
INSERT INTO `interaction` VALUES (65, 4, 'RATING', 3, 3, 5, '2025-04-19 22:52:05');
INSERT INTO `interaction` VALUES (66, 1, 'UPVOTE', 3, 3, NULL, '2025-04-19 22:52:08');
INSERT INTO `interaction` VALUES (67, 3, 'VIEW', 36, 5, NULL, '2025-04-19 22:52:54');
INSERT INTO `interaction` VALUES (68, 4, 'RATING', 36, 5, 4, '2025-04-19 22:52:56');
INSERT INTO `interaction` VALUES (69, 3, 'VIEW', 34, 5, NULL, '2025-04-19 22:52:59');
INSERT INTO `interaction` VALUES (70, 4, 'RATING', 34, 5, 4, '2025-04-19 22:53:00');
INSERT INTO `interaction` VALUES (71, 3, 'VIEW', 4, 5, NULL, '2025-04-19 22:53:03');
INSERT INTO `interaction` VALUES (72, 4, 'RATING', 4, 5, 4, '2025-04-19 22:53:04');
INSERT INTO `interaction` VALUES (73, 1, 'UPVOTE', 4, 5, NULL, '2025-04-19 22:53:22');
INSERT INTO `interaction` VALUES (74, 2, 'COLLECTION', 4, 5, NULL, '2025-04-19 22:53:23');
INSERT INTO `interaction` VALUES (75, 3, 'VIEW', 15, 5, NULL, '2025-04-19 22:53:26');
INSERT INTO `interaction` VALUES (76, 4, 'RATING', 15, 5, 4, '2025-04-19 22:53:26');
INSERT INTO `interaction` VALUES (77, 3, 'VIEW', 2, 5, NULL, '2025-04-19 22:53:32');
INSERT INTO `interaction` VALUES (78, 4, 'RATING', 2, 5, 5, '2025-04-19 22:53:33');
INSERT INTO `interaction` VALUES (79, 1, 'UPVOTE', 2, 5, NULL, '2025-04-19 22:53:35');
INSERT INTO `interaction` VALUES (80, 2, 'COLLECTION', 2, 5, NULL, '2025-04-19 22:53:36');
INSERT INTO `interaction` VALUES (81, 3, 'VIEW', 1, 5, NULL, '2025-04-19 22:53:55');
INSERT INTO `interaction` VALUES (82, 4, 'RATING', 1, 5, 5, '2025-04-19 22:53:57');
INSERT INTO `interaction` VALUES (83, 3, 'VIEW', 5, 5, NULL, '2025-04-19 22:54:03');
INSERT INTO `interaction` VALUES (84, 4, 'RATING', 5, 5, 4, '2025-04-19 22:54:04');
INSERT INTO `interaction` VALUES (85, 1, 'UPVOTE', 5, 5, NULL, '2025-04-19 22:54:07');
INSERT INTO `interaction` VALUES (86, 3, 'VIEW', 33, 5, NULL, '2025-04-19 22:54:14');
INSERT INTO `interaction` VALUES (87, 4, 'RATING', 33, 5, 4, '2025-04-19 22:54:16');
INSERT INTO `interaction` VALUES (88, 1, 'UPVOTE', 36, 5, NULL, '2025-04-19 22:54:26');
INSERT INTO `interaction` VALUES (89, 3, 'VIEW', 40, 6, NULL, '2025-04-19 23:05:48');
INSERT INTO `interaction` VALUES (90, 3, 'VIEW', 41, 6, NULL, '2025-04-19 23:05:51');
INSERT INTO `interaction` VALUES (91, 3, 'VIEW', 36, 6, NULL, '2025-04-19 23:05:54');
INSERT INTO `interaction` VALUES (92, 3, 'VIEW', 12, 6, NULL, '2025-04-19 23:06:04');
INSERT INTO `interaction` VALUES (93, 3, 'VIEW', 34, 6, NULL, '2025-04-19 23:06:08');
INSERT INTO `interaction` VALUES (94, 4, 'RATING', 34, 6, 4, '2025-04-19 23:06:10');
INSERT INTO `interaction` VALUES (95, 3, 'VIEW', 42, 6, NULL, '2025-04-19 23:06:12');
INSERT INTO `interaction` VALUES (96, 4, 'RATING', 42, 6, 3, '2025-04-19 23:06:14');
INSERT INTO `interaction` VALUES (97, 3, 'VIEW', 38, 6, NULL, '2025-04-19 23:06:16');
INSERT INTO `interaction` VALUES (98, 4, 'RATING', 38, 6, 5, '2025-04-19 23:06:17');
INSERT INTO `interaction` VALUES (99, 3, 'VIEW', 16, 6, NULL, '2025-04-19 23:06:21');
INSERT INTO `interaction` VALUES (100, 4, 'RATING', 16, 6, 5, '2025-04-19 23:06:23');
INSERT INTO `interaction` VALUES (101, 3, 'VIEW', 35, 6, NULL, '2025-04-19 23:06:27');
INSERT INTO `interaction` VALUES (102, 3, 'VIEW', 2, 6, NULL, '2025-04-19 23:06:30');
INSERT INTO `interaction` VALUES (103, 4, 'RATING', 2, 6, 5, '2025-04-19 23:06:32');
INSERT INTO `interaction` VALUES (104, 1, 'UPVOTE', 2, 6, NULL, '2025-04-19 23:06:34');
INSERT INTO `interaction` VALUES (105, 3, 'VIEW', 4, 6, NULL, '2025-04-19 23:06:36');
INSERT INTO `interaction` VALUES (106, 4, 'RATING', 4, 6, 5, '2025-04-19 23:06:37');
INSERT INTO `interaction` VALUES (107, 1, 'UPVOTE', 4, 6, NULL, '2025-04-19 23:06:39');
INSERT INTO `interaction` VALUES (108, 3, 'VIEW', 5, 6, NULL, '2025-04-19 23:06:44');
INSERT INTO `interaction` VALUES (109, 4, 'RATING', 5, 6, 4, '2025-04-19 23:06:45');
INSERT INTO `interaction` VALUES (110, 1, 'UPVOTE', 5, 6, NULL, '2025-04-19 23:06:46');
INSERT INTO `interaction` VALUES (111, 3, 'VIEW', 1, 6, NULL, '2025-04-19 23:07:09');
INSERT INTO `interaction` VALUES (112, 4, 'RATING', 1, 6, 5, '2025-04-19 23:07:11');
INSERT INTO `interaction` VALUES (113, 1, 'UPVOTE', 1, 6, NULL, '2025-04-19 23:07:12');
INSERT INTO `interaction` VALUES (114, 2, 'COLLECTION', 1, 6, NULL, '2025-04-19 23:07:14');
INSERT INTO `interaction` VALUES (115, 3, 'VIEW', 67, 2, NULL, '2025-04-19 23:37:19');
INSERT INTO `interaction` VALUES (116, 4, 'RATING', 67, 2, 4, '2025-04-19 23:37:21');
INSERT INTO `interaction` VALUES (117, 4, 'RATING', 1, 2, 5, '2025-04-19 23:39:34');
INSERT INTO `interaction` VALUES (120, 3, 'VIEW', 16, 4, NULL, '2025-04-20 00:18:35');
INSERT INTO `interaction` VALUES (121, 3, 'VIEW', 63, 2, NULL, '2025-04-24 13:28:53');
INSERT INTO `interaction` VALUES (122, 3, 'VIEW', 4, 2, NULL, '2025-04-24 13:29:13');
INSERT INTO `interaction` VALUES (123, 4, 'RATING', 4, 2, 4, '2025-04-24 13:29:17');
INSERT INTO `interaction` VALUES (124, 3, 'VIEW', 58, 2, NULL, '2025-04-24 13:30:17');
INSERT INTO `interaction` VALUES (125, 3, 'VIEW', 33, 2, NULL, '2025-04-24 13:30:24');
INSERT INTO `interaction` VALUES (126, 4, 'RATING', 33, 2, 5, '2025-04-24 13:30:28');
INSERT INTO `interaction` VALUES (127, 1, 'UPVOTE', 33, 2, NULL, '2025-04-24 13:30:34');
INSERT INTO `interaction` VALUES (128, 2, 'COLLECTION', 33, 2, NULL, '2025-04-24 13:30:35');
INSERT INTO `interaction` VALUES (129, 1, 'UPVOTE', 1, 3, NULL, '2025-04-24 15:38:19');
INSERT INTO `interaction` VALUES (130, 3, 'VIEW', 11, 2, NULL, '2025-04-26 13:41:50');
INSERT INTO `interaction` VALUES (131, 1, 'UPVOTE', 67, 2, NULL, '2025-04-26 13:52:38');
INSERT INTO `interaction` VALUES (133, 3, 'VIEW', 5, 2, NULL, '2025-05-16 18:54:05');
INSERT INTO `interaction` VALUES (134, 4, 'RATING', 5, 2, 4, '2025-05-16 19:16:24');
INSERT INTO `interaction` VALUES (135, 1, 'UPVOTE', 5, 2, NULL, '2025-05-16 19:16:32');
INSERT INTO `interaction` VALUES (136, 2, 'COLLECTION', 5, 2, NULL, '2025-05-16 19:16:33');
INSERT INTO `interaction` VALUES (138, 2, 'COLLECTION', 1, 2, NULL, '2025-05-16 19:20:24');
INSERT INTO `interaction` VALUES (139, 1, 'UPVOTE', 1, 2, NULL, '2025-05-17 08:57:29');
INSERT INTO `interaction` VALUES (140, 3, 'VIEW', 65, 29, NULL, '2025-06-17 09:24:00');
INSERT INTO `interaction` VALUES (141, 3, 'VIEW', 70, 29, NULL, '2025-06-17 17:39:44');
INSERT INTO `interaction` VALUES (142, 3, 'VIEW', 64, 2, NULL, '2025-06-19 11:12:52');
INSERT INTO `interaction` VALUES (144, 1, 'UPVOTE', 4, 2, NULL, '2025-06-19 23:14:35');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息表的自增主键ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '消息内容（消息体）',
  `message_type` int NULL DEFAULT NULL COMMENT '消息类型（指标数据、互动、系统消息...）',
  `receiver_id` int NULL DEFAULT NULL COMMENT '接收者ID',
  `sender_id` int NULL DEFAULT NULL COMMENT '发送者ID',
  `is_read` tinyint(1) NULL DEFAULT NULL COMMENT '消息是否已经阅读',
  `content_id` int NULL DEFAULT NULL COMMENT '关联的内容ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '消息的发送时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, '欢迎来到我的健康管理系统~', 4, 20, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (2, '欢迎来到我的健康管理系统~', 4, 19, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (3, '欢迎来到我的健康管理系统~', 4, 18, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (4, '欢迎来到我的健康管理系统~', 4, 17, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (5, '欢迎来到我的健康管理系统~', 4, 16, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (6, '欢迎来到我的健康管理系统~', 4, 15, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (7, '欢迎来到我的健康管理系统~', 4, 14, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (8, '欢迎来到我的健康管理系统~', 4, 13, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (9, '欢迎来到我的健康管理系统~', 4, 12, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (10, '欢迎来到我的健康管理系统~', 4, 11, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (11, '欢迎来到我的健康管理系统~', 4, 10, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (12, '欢迎来到我的健康管理系统~', 4, 9, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (13, '欢迎来到我的健康管理系统~', 4, 8, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (14, '欢迎来到我的健康管理系统~', 4, 7, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (15, '欢迎来到我的健康管理系统~', 4, 6, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (16, '欢迎来到我的健康管理系统~', 4, 5, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (17, '欢迎来到我的健康管理系统~', 4, 4, NULL, 0, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (18, '欢迎来到我的健康管理系统~', 4, 3, NULL, 1, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (19, '欢迎来到我的健康管理系统~', 4, 2, NULL, 1, NULL, '2025-04-19 00:23:42');
INSERT INTO `message` VALUES (20, '你记录的【体温】超标了！正常值范围:[36,38]，请注意休息。必要时请就医!', 3, 2, NULL, 1, NULL, '2025-04-19 00:31:36');
INSERT INTO `message` VALUES (21, '你记录的【心率】偏低了！正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 1, NULL, '2025-04-19 00:31:57');
INSERT INTO `message` VALUES (22, '你记录的【心率】偏低了！当前值：58.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 1, NULL, '2025-04-19 01:03:54');
INSERT INTO `message` VALUES (24, '13;1;你好', 1, 2, 4, 1, 1, '2025-04-20 00:19:00');
INSERT INTO `message` VALUES (25, '13;1;噜噜噜', 1, 4, 2, 0, 1, '2025-04-20 00:19:47');
INSERT INTO `message` VALUES (30, '你记录的【心率】偏低了！当前值：56.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-04-27 09:50:28');
INSERT INTO `message` VALUES (31, '你记录的【心率】偏低了！当前值：58.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-02 18:14:50');
INSERT INTO `message` VALUES (32, '你记录的【谷丙转氨酶】超标了！当前值：259.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-02 18:14:50');
INSERT INTO `message` VALUES (33, '你记录的【每日喝水量】超标了！当前值：2100.0，正常值范围:[1000,2000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-02 18:14:50');
INSERT INTO `message` VALUES (34, '你记录的【心率】偏低了！当前值：57.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-02 23:18:48');
INSERT INTO `message` VALUES (35, '你记录的【谷丙转氨酶】超标了！当前值：268.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-02 23:18:48');
INSERT INTO `message` VALUES (36, '你记录的【谷丙转氨酶】超标了！当前值：260.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-03 22:02:31');
INSERT INTO `message` VALUES (37, '你记录的【谷丙转氨酶】超标了！当前值：259.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-07 18:06:29');
INSERT INTO `message` VALUES (38, '你记录的【心率】偏低了！当前值：56.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-14 15:42:33');
INSERT INTO `message` VALUES (39, '你记录的【谷丙转氨酶】超标了！当前值：260.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-14 15:42:33');
INSERT INTO `message` VALUES (40, '你记录的【心率】偏低了！当前值：59.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 18:51:15');
INSERT INTO `message` VALUES (41, '你记录的【晨跑步数】偏低了！当前值：333.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 18:51:15');
INSERT INTO `message` VALUES (42, '你记录的【谷丙转氨酶】超标了！当前值：267.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 18:51:15');
INSERT INTO `message` VALUES (43, '你记录的【心率】偏低了！当前值：59.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 19:15:41');
INSERT INTO `message` VALUES (44, '你记录的【谷丙转氨酶】超标了！当前值：260.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 19:15:41');
INSERT INTO `message` VALUES (45, '你记录的【心率】偏低了！当前值：59.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 19:19:37');
INSERT INTO `message` VALUES (46, '你记录的【谷丙转氨酶】超标了！当前值：260.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-16 19:19:37');
INSERT INTO `message` VALUES (47, '你好', 4, 27, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (48, '你好', 4, 26, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (49, '你好', 4, 20, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (50, '你好', 4, 19, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (51, '你好', 4, 18, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (52, '你好', 4, 17, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (53, '你好', 4, 16, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (54, '你好', 4, 15, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (55, '你好', 4, 14, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (56, '你好', 4, 13, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (57, '你好', 4, 12, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (58, '你好', 4, 11, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (59, '你好', 4, 10, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (60, '你好', 4, 9, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (61, '你好', 4, 8, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (62, '你好', 4, 7, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (63, '你好', 4, 6, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (64, '你好', 4, 5, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (65, '你好', 4, 4, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (66, '你好', 4, 3, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (67, '你好', 4, 2, NULL, 0, NULL, '2025-05-16 19:25:13');
INSERT INTO `message` VALUES (68, '你记录的【心率】偏低了！当前值：40.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-17 08:57:00');
INSERT INTO `message` VALUES (69, '你记录的【谷丙转氨酶】超标了！当前值：260.0，正常值范围:[108,258]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-05-17 08:57:00');
INSERT INTO `message` VALUES (70, '你记录的【心率】超标了！当前值：120.0，正常值范围:[60,100]，请注意休息。必要时请就医!', 3, 29, NULL, 1, NULL, '2025-06-17 17:39:15');
INSERT INTO `message` VALUES (71, '你记录的【晨跑步数】偏低了！当前值：0.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 29, NULL, 1, NULL, '2025-06-17 17:39:15');
INSERT INTO `message` VALUES (72, '你记录的【夜跑步数】偏低了！当前值：0.0，正常值范围:[422,17990]，请注意休息。必要时请就医!', 3, 29, NULL, 1, NULL, '2025-06-17 17:39:15');
INSERT INTO `message` VALUES (73, '你记录的【运动心率】超标了！当前值：230.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 29, NULL, 1, NULL, '2025-06-17 17:39:15');
INSERT INTO `message` VALUES (74, '你记录的【每日喝水量】偏低了！当前值：500.0，正常值范围:[1000,2000]，请注意休息。必要时请就医!', 3, 29, NULL, 1, NULL, '2025-06-17 17:39:15');
INSERT INTO `message` VALUES (75, '你记录的【夜跑步数】超标了！当前值：54242.0，正常值范围:[422,17990]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-19 22:22:35');
INSERT INTO `message` VALUES (76, '你记录的【夜间血压】超标了！当前值：150.0，正常值范围:[72,145]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-19 22:22:35');
INSERT INTO `message` VALUES (77, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-19 22:22:35');
INSERT INTO `message` VALUES (78, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:35');
INSERT INTO `message` VALUES (79, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:39');
INSERT INTO `message` VALUES (80, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:44');
INSERT INTO `message` VALUES (81, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:50');
INSERT INTO `message` VALUES (82, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:50');
INSERT INTO `message` VALUES (83, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:54');
INSERT INTO `message` VALUES (84, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:54');
INSERT INTO `message` VALUES (85, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:59');
INSERT INTO `message` VALUES (86, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:40:59');
INSERT INTO `message` VALUES (87, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:03');
INSERT INTO `message` VALUES (88, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:04');
INSERT INTO `message` VALUES (89, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:10');
INSERT INTO `message` VALUES (90, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:10');
INSERT INTO `message` VALUES (91, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:15');
INSERT INTO `message` VALUES (92, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:15');
INSERT INTO `message` VALUES (93, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:21');
INSERT INTO `message` VALUES (94, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:21');
INSERT INTO `message` VALUES (95, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:23');
INSERT INTO `message` VALUES (96, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:23');
INSERT INTO `message` VALUES (97, '你记录的【晨跑步数】偏低了！当前值：2000.0，正常值范围:[3000,10000]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:29');
INSERT INTO `message` VALUES (98, '你记录的【运动心率】超标了！当前值：200.0，正常值范围:[75,197]，请注意休息。必要时请就医!', 3, 2, NULL, 0, NULL, '2025-06-20 09:41:29');

-- ----------------------------
-- Table structure for nutriment
-- ----------------------------
DROP TABLE IF EXISTS `nutriment`;
CREATE TABLE `nutriment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '营养素主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '名称',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '描述',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '单位',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否公开',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '营养素信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nutriment
-- ----------------------------
INSERT INTO `nutriment` VALUES (1, 2, '蛋白质', '人体必须摄入项', '克', 1, '2024-11-27 13:19:40');
INSERT INTO `nutriment` VALUES (3, 2, '脂肪', '脂肪的单位‌通常是指脂肪的含量或重量，通常以百分比或克数来表示。', '克', 1, '2024-11-29 15:27:59');
INSERT INTO `nutriment` VALUES (4, 2, '碳水化合物', '是人体最经济、最直接的能量来源', '克', 1, '2024-11-29 15:28:58');
INSERT INTO `nutriment` VALUES (5, 2, '钾', '‌钾含量的单位通常是mmol/L‌。血清钾的单位是mmol/L，正常值范围通常为3.5mmol/L-5.3mmol/L', 'mmol/L‌', 1, '2024-11-29 15:56:14');
INSERT INTO `nutriment` VALUES (6, 2, '钙', '毫克(mg)是计量钙等营养素的常用单位,而克(g)是更大的单位,通常用于表示食品或补充剂中含量较高的营养素。', '毫克(mg)', 1, '2024-11-29 15:56:58');
INSERT INTO `nutriment` VALUES (7, 2, '纤维素', '促进消化健康，帮助维持血糖水平', '克', 0, '2024-11-30 15:39:57');
INSERT INTO `nutriment` VALUES (8, 2, '维生素 A', '支持视力、免疫功能和皮肤健康。', '毫克(mg)', 0, '2024-11-30 15:40:26');
INSERT INTO `nutriment` VALUES (9, 2, '维生素 D', '促进钙的吸收，支持骨骼健康', '毫克(mg)', 0, '2024-11-30 15:40:47');
INSERT INTO `nutriment` VALUES (14, 29, '热量', '维持人体正常生理功能方面发挥着至关重要的作用', '千卡', 1, '2025-06-19 14:49:03');
INSERT INTO `nutriment` VALUES (15, 29, '维生素B1', '维生素 B₁助力碳水化合物分解供能', '毫克(mg)', 1, '2025-06-19 14:59:24');
INSERT INTO `nutriment` VALUES (16, 29, '维生素B2', 'B₂参与氧化还原反应；维护皮肤、黏膜健康，像 B₂可防口角炎等', '毫克(mg)', 1, '2025-06-19 14:59:49');
INSERT INTO `nutriment` VALUES (17, 29, '维生素B12', 'B₁₂、叶酸参与造血，助红细胞生成；还能调节神经系统，改善精神状态，缓解焦虑、疲劳 。', '毫克(mg)', 1, '2025-06-19 15:00:11');
INSERT INTO `nutriment` VALUES (18, 29, '烟酸', '除作为人体必需营养成分，还是重要医药原料（用于治疗高胆固醇血症等，不过剂量过大有腹泻、头晕等不良反应，需遵医嘱 ）', '毫克(mg)', 1, '2025-06-19 15:02:21');
INSERT INTO `nutriment` VALUES (19, 29, '维生素C', '抗氧化，清除自由基，延缓衰老、防慢性病；促进胶原蛋白合成，利伤口愈合、维持皮肤弹性；增强免疫力，助白细胞功能、促进抗体生成；促进铁吸收，防缺铁性贫血；还能辅助解毒，减轻重金属等对身体的伤害 。', '毫克(mg)', 1, '2025-06-19 15:03:06');
INSERT INTO `nutriment` VALUES (20, 29, '铁', '是血红蛋白、肌红蛋白重要组成，参与氧的运输与储存，保障组织供氧；参与能量代谢，助力细胞产生能量；对免疫功能有影响，缺铁易致免疫力下降；还参与酶的合成，对细胞生长、分化和代谢意义重大 。', '毫克(mg)', 1, '2025-06-19 15:05:05');
INSERT INTO `nutriment` VALUES (21, 29, '叶酸', '叶酸参与造血，助红细胞生成', '微克', 1, '2025-06-19 15:06:33');

-- ----------------------------
-- Table structure for recipe
-- ----------------------------
DROP TABLE IF EXISTS `recipe`;
CREATE TABLE `recipe`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '食谱名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '食谱描述',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '食谱图片',
  `meal_type` tinyint NOT NULL COMMENT '1:早餐 2:午餐 3:晚餐',
  `region_id` int NOT NULL COMMENT '地区ID',
  `season_id` int NOT NULL COMMENT '季节ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_region_season`(`region_id` ASC, `season_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recipe
-- ----------------------------
INSERT INTO `recipe` VALUES (1, '蒸山药', '鲜山药【毛重】*80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5299b47蒸山药.webp', 1, 2, 1, '2025-04-19 11:13:00', '2025-04-19 20:20:42');
INSERT INTO `recipe` VALUES (2, '脱脂牛奶', '200ml', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=00094e3牛奶.webp', 1, 2, 1, '2025-04-19 11:13:00', '2025-04-19 18:51:18');
INSERT INTO `recipe` VALUES (3, '香菜水炒蛋', '鸡蛋55g, 香菜10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0861021香菜水炒蛋.webp', 1, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:51:49');
INSERT INTO `recipe` VALUES (4, '拍黄瓜', '黄瓜80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a9e5899拍黄瓜.webp', 1, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:52:02');
INSERT INTO `recipe` VALUES (5, '樱桃番茄', '80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f3ed790樱桃番茄.webp', 1, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:52:19');
INSERT INTO `recipe` VALUES (6, '杂粮饭', '藜麦20g, 薏苡仁*20g, 大米30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ea1b06c杂粮饭.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-04-19 19:10:24');
INSERT INTO `recipe` VALUES (7, '蒜香草头', '草头130g, 大蒜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a6cebcd蒜香草头.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:47:53');
INSERT INTO `recipe` VALUES (8, '春笋肉片', '春笋80g, 瘦肉15g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4926a98春笋肉片.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:48:09');
INSERT INTO `recipe` VALUES (9, '盐水虾', '明虾【毛重】50g, 生姜*5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7696294盐水虾.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:48:25');
INSERT INTO `recipe` VALUES (10, '紫菜汤', '紫菜【干】5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=67bff8f紫菜汤.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:48:49');
INSERT INTO `recipe` VALUES (11, '草莓', '80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=92e579c草莓.webp', 2, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:49:09');
INSERT INTO `recipe` VALUES (12, '燕麦饭', '燕麦30g, 大米30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=22178c9燕麦饭.webp', 3, 2, 1, '2025-04-19 11:13:00', '2025-04-19 18:58:17');
INSERT INTO `recipe` VALUES (13, '清炒平菇', '平菇【鲜】80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=86f6b35清炒平菇.webp', 3, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:49:24');
INSERT INTO `recipe` VALUES (14, '凉拌马兰头', '香干10g, 马兰头100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d3a979d凉拌马兰头.webp', 3, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:49:41');
INSERT INTO `recipe` VALUES (15, '豆豉蒸鲈鱼', '鲈鱼60g, 生姜*5g, 淡豆豉*8g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e8c826f豆豉蒸鲈鱼.webp', 3, 2, 1, '2025-04-19 11:13:00', '2025-05-14 21:49:54');
INSERT INTO `recipe` VALUES (16, '西红柿汤', '西红柿25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=67cfa0e西红柿豆腐汤.webp', 3, 2, 1, '2025-04-19 11:13:00', '2025-04-19 20:21:01');
INSERT INTO `recipe` VALUES (17, '三明治', '全麦吐司80g，鸡蛋50g，生菜20g，紫甘蓝20g，西红柿20g，低脂沙拉酱5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a38faeb三明治.webp', 1, 2, 2, '2025-04-19 11:13:00', '2025-04-19 19:21:52');
INSERT INTO `recipe` VALUES (18, '脱脂牛奶', '200mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b8fb216牛奶.webp', 1, 2, 2, '2025-04-19 11:13:00', '2025-04-19 18:51:22');
INSERT INTO `recipe` VALUES (19, '猕猴桃', '毛重70g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=23980cc猕猴桃.webp', 1, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:50:03');
INSERT INTO `recipe` VALUES (20, '燕麦黑米饭', '梗米25g，黑米10g，燕麦米15g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=eaf1ff2黑米饭.webp', 2, 2, 2, '2025-04-19 11:13:00', '2025-04-19 18:55:21');
INSERT INTO `recipe` VALUES (21, '草菇西兰花', '草菇【鲜】50g，西兰花60g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=263351c草菇西兰花.webp', 2, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:50:19');
INSERT INTO `recipe` VALUES (22, '芹菜香干', '芹菜50g，香干20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3cdfd42芹菜香干.webp', 2, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:50:36');
INSERT INTO `recipe` VALUES (23, '彩椒牛里脊', '柿子椒40g，牛里脊肉45g，黑胡椒1g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=de7c9dd彩椒牛里脊.webp', 2, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:50:55');
INSERT INTO `recipe` VALUES (24, '薏苡仁冬瓜汤', '薏苡仁5g，冬瓜80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=48ed465薏苡仁冬瓜汤.webp', 2, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:51:13');
INSERT INTO `recipe` VALUES (25, '山竹', '毛重80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a096ebe山竹.webp', 3, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:51:29');
INSERT INTO `recipe` VALUES (26, '小米红薯饭', '小米10g，红薯20g，梗米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=aab4d50红薯饭.webp', 3, 2, 2, '2025-04-19 11:13:00', '2025-04-19 18:57:51');
INSERT INTO `recipe` VALUES (27, '蒜泥空心菜', '空心菜130g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=36b2be4蒜泥空心菜.webp', 3, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:43:53');
INSERT INTO `recipe` VALUES (28, '荷塘月色', '鲜虾仁30g，木耳【干】5g，荷兰豆30g，芦笋30g，白果【干】*10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5ab82a3荷塘月色.webp', 3, 2, 2, '2025-04-19 11:13:00', '2025-05-14 21:44:41');
INSERT INTO `recipe` VALUES (29, '馒头', '45g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5e91cf0馒头.jpg', 1, 2, 3, '2025-04-19 11:13:00', '2025-04-19 19:21:41');
INSERT INTO `recipe` VALUES (30, '煮鸡蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=126cc09鸡蛋.webp', 1, 2, 3, '2025-04-19 11:13:00', '2025-04-19 19:13:02');
INSERT INTO `recipe` VALUES (31, '热胶银耳牛奶羹', '桃胶【干】5g，银耳【干】5g，莲子*【干】5g，牛奶200mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bdd6ba7热胶银耳牛奶羹.webp', 1, 2, 3, '2025-04-19 11:13:00', '2025-04-19 18:51:54');
INSERT INTO `recipe` VALUES (32, '鸭梨', '毛重100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0fac6ed鸭梨.webp', 2, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:44:54');
INSERT INTO `recipe` VALUES (33, '黑米饭', '黑米20g，梗米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6ca8422黑米饭.webp', 2, 2, 3, '2025-04-19 11:13:00', '2025-04-19 18:55:25');
INSERT INTO `recipe` VALUES (34, '蒜泥木耳菜', '木耳菜120g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9ffef1f蒜泥木耳菜.webp', 2, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:45:12');
INSERT INTO `recipe` VALUES (35, '西芹百合虾', '西芹50g，百合*【鲜】20g，鲜虾仁30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=600c75d西芹百合虾.webp', 2, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:45:27');
INSERT INTO `recipe` VALUES (36, '竹荪黄瓜汤', '竹荪【干】10g，黄瓜30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d031cb9竹荪黄瓜汤.webp', 2, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:45:41');
INSERT INTO `recipe` VALUES (37, '板栗', '毛重50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=32592a9板栗.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:45:54');
INSERT INTO `recipe` VALUES (38, '板粟饭', '板栗15g，梗米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f2de39c板粟饭.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-04-19 18:57:41');
INSERT INTO `recipe` VALUES (39, '清炒红薯藤叶', '红薯藤叶120g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7416e4a清炒红薯藤叶.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:46:09');
INSERT INTO `recipe` VALUES (40, '洋葱香芹牛肉丝', '牛里脊肉40g，洋葱40g，香芹40g，黑胡椒*2g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=194b914洋葱香芹牛肉丝.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:46:29');
INSERT INTO `recipe` VALUES (41, '葱油蛏子', '蛏子【毛重】150g，生姜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c04b5ca葱油蛏子.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:46:44');
INSERT INTO `recipe` VALUES (42, '三鲜汤', '香菇【鲜】20g，嫩豆腐10g，牡蛎肉【鲜】*10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4f20701三鲜汤.webp', 3, 2, 3, '2025-04-19 11:13:00', '2025-05-14 21:47:02');
INSERT INTO `recipe` VALUES (43, '花卷', '55g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e32b1f1花卷.webp', 1, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:47:27');
INSERT INTO `recipe` VALUES (44, '豆腐脑', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9630b1a豆腐脑.webp', 1, 2, 4, '2025-04-19 11:13:00', '2025-04-19 19:16:10');
INSERT INTO `recipe` VALUES (45, '茶叶蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4325785鸡蛋.webp', 1, 2, 4, '2025-04-19 11:13:00', '2025-04-19 19:12:58');
INSERT INTO `recipe` VALUES (46, '脱脂牛奶', '150mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 2, 4, '2025-04-19 11:13:00', '2025-04-19 18:52:27');
INSERT INTO `recipe` VALUES (47, '凤梨', '60g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0ebb2a2凤梨.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:39:15');
INSERT INTO `recipe` VALUES (48, '藜麦薏米饭', '薏苡仁*15g，藜麦10g，梗米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1cd1d6e藜麦薏米饭.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-04-19 18:59:12');
INSERT INTO `recipe` VALUES (49, '醋溜辣白菜', '大白菜110g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=517141c醋溜辣白菜.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:39:47');
INSERT INTO `recipe` VALUES (50, '香菇冬笋', '冬笋50g，香菇【鲜】60g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=12c5167香菇冬笋.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:40:07');
INSERT INTO `recipe` VALUES (51, '萝卜炖羊肉', '白萝卜60g，羊后腿肉30g，生姜*10g，小茴香*5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8236cf4萝卜炖羊肉.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:40:25');
INSERT INTO `recipe` VALUES (52, '黄瓜紫菜汤', '黄瓜40g，紫菜【干】3g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b6c1737黄瓜紫菜汤.webp', 2, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:40:43');
INSERT INTO `recipe` VALUES (53, '文旦', '70g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1a8a4d2文旦.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:41:00');
INSERT INTO `recipe` VALUES (54, '黑米饭', '黑米15g，小米20g，梗米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6097130黑米饭.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-04-19 18:55:31');
INSERT INTO `recipe` VALUES (55, '鸭血豆腐', '鸭血30g，豆腐20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7837d72鸭血豆腐.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-04-19 19:16:40');
INSERT INTO `recipe` VALUES (56, '蒜苔牛肉', '蒜苔60g，牛瘦肉25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=54adbb6蒜苔牛肉.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:41:16');
INSERT INTO `recipe` VALUES (57, '柠香鸡腿肉', '鸡腿肉【去皮】30g，洋葱10g，香菜5g，柠檬10g，小米辣3g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=04b99de柠香鸡腿肉.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:41:39');
INSERT INTO `recipe` VALUES (58, '菠菜蘑菇汤', '蘑菇20g，菠菜20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4c4c789菠菜蘑菇汤.webp', 3, 2, 4, '2025-04-19 11:13:00', '2025-05-14 21:41:58');
INSERT INTO `recipe` VALUES (59, '山药粉鸡蛋软饼', '山药粉50g，全麦面粉10g，脱脂牛奶50mL，鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=09f1af7山药粉鸡蛋软饼.webp', 1, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:42:17');
INSERT INTO `recipe` VALUES (60, '桔梗香葱拌春笋', '桔梗20g，香葱10g，春笋100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1255ad9桔梗香葱拌春笋.webp', 1, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:42:33');
INSERT INTO `recipe` VALUES (61, '脱脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 3, 1, '2025-04-19 11:13:00', '2025-04-19 18:52:26');
INSERT INTO `recipe` VALUES (62, '黄心猕猴桃', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=86b26a0黄心猕猴桃.webp', 1, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:42:54');
INSERT INTO `recipe` VALUES (63, '芡实玉米饭', '玉米粒20g，芡实10g，大米50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=975ee93芡实玉米饭.webp', 2, 3, 1, '2025-04-19 11:13:00', '2025-04-19 18:58:46');
INSERT INTO `recipe` VALUES (64, '肉丝炒茭白', '猪肉25g，仔姜80g，青蒜10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c90d043肉丝炒茭白.webp', 2, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:43:17');
INSERT INTO `recipe` VALUES (65, '蒜蓉炒娃娃菜', '娃娃菜150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=56a5c16蒜蓉炒娃娃菜.webp', 2, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:43:32');
INSERT INTO `recipe` VALUES (66, '虾皮冬瓜海带汤', '虾皮3g，冬瓜100g，海带30g，香菜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=03ee552虾皮冬瓜海带汤.webp', 2, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:35:35');
INSERT INTO `recipe` VALUES (67, '紫薯馒头', '紫薯30g，全麦面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dad74c3馒头.jpg', 3, 3, 1, '2025-04-19 11:13:00', '2025-04-19 19:21:36');
INSERT INTO `recipe` VALUES (68, '虾仁炒西兰花', '鲜虾仁50g，西兰花70g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f9c3803虾仁炒西兰花.webp', 3, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:35:53');
INSERT INTO `recipe` VALUES (69, '鸡毛菜汆丸子', '猪瘦肉30g，鸡毛菜50g，蟹味菇20g，枸杞子5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=47a7be8鸡毛菜汆丸子.webp', 3, 3, 1, '2025-04-19 11:13:00', '2025-05-14 21:36:12');
INSERT INTO `recipe` VALUES (70, '香葱鸡蛋软饼', '全麦面粉25g，牛奶100mL，鸡蛋50g，香葱10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=980007c香葱鸡蛋软饼.webp', 1, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:36:27');
INSERT INTO `recipe` VALUES (71, '胡萝卜炒青笋', '胡萝卜20g，杏鲍菇50g，青笋80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8683f91胡萝卜炒青笋.webp', 1, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:36:47');
INSERT INTO `recipe` VALUES (72, '水果奶昔', '红心火龙果1个，无糖酸奶150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=cbebe5a奶昔.webp', 1, 3, 2, '2025-04-19 11:13:00', '2025-04-19 19:22:07');
INSERT INTO `recipe` VALUES (73, '芡实燕麦糙米饭', '黑米40g，芡实10g，燕麦米10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=83e3aaf芡实燕麦糙米饭.webp', 2, 3, 2, '2025-04-19 11:13:00', '2025-04-19 18:57:16');
INSERT INTO `recipe` VALUES (74, '肉末豆腐蒸槐花', '猪肉20g，北豆腐20g，槐花100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fa0d5f2肉末豆腐蒸槐花.webp', 2, 3, 2, '2025-04-19 11:13:00', '2025-04-19 19:17:07');
INSERT INTO `recipe` VALUES (75, '蒜蓉拍黄瓜', '嫩黄瓜150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d529f2e蒜蓉拍黄瓜.webp', 2, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:37:08');
INSERT INTO `recipe` VALUES (76, '虾皮冬瓜紫菜汤', '虾皮3g，冬瓜150g，紫菜3g，香菜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4da86c7虾皮冬瓜紫菜汤.webp', 2, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:37:23');
INSERT INTO `recipe` VALUES (77, '蒸土豆南瓜', '黄瓤土豆100g，栗面南瓜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8b034fc蒸南瓜.webp', 3, 3, 2, '2025-04-19 11:13:00', '2025-04-19 20:20:47');
INSERT INTO `recipe` VALUES (78, '仔姜桔梗拌西葫芦', '泡仔姜20g，桔梗20g，西葫芦100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9cc7b04仔姜桔梗拌西葫芦.webp', 3, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:37:40');
INSERT INTO `recipe` VALUES (79, '香菇蒸仔鸡', '鸡腿肉70g，香菇20g，莲子20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bc3d75f香菇蒸仔鸡.webp', 3, 3, 2, '2025-04-19 11:13:00', '2025-05-14 21:37:56');
INSERT INTO `recipe` VALUES (80, '奶香馒头', '脱脂牛奶20g，全麦面粉40g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ca44217馒头.jpg', 1, 3, 3, '2025-04-19 11:13:00', '2025-04-19 19:21:31');
INSERT INTO `recipe` VALUES (81, '金针菇炒豆芽', '绿豆芽50g，黄瓜30g，金针菇50g，香菜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c09726a金针菇炒豆芽.webp', 1, 3, 3, '2025-04-19 11:13:00', '2025-05-14 21:38:13');
INSERT INTO `recipe` VALUES (82, '脱脂牛奶', '230mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 3, 3, '2025-04-19 11:13:00', '2025-04-19 18:52:28');
INSERT INTO `recipe` VALUES (83, '艾实紫米饭', '紫米45g，芡实10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=950f371艾实紫米饭.webp', 2, 3, 3, '2025-04-19 11:13:00', '2025-04-19 18:56:45');
INSERT INTO `recipe` VALUES (84, '清炒虾仁', '鲜虾仁50g，黄瓜40g，胡萝卜10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=20d3b39清炒虾仁.webp', 2, 3, 3, '2025-04-19 11:13:00', '2025-05-14 21:38:35');
INSERT INTO `recipe` VALUES (85, '清炒南瓜尖', '嫩南瓜尖100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=51c429b清炒南瓜尖.webp', 2, 3, 3, '2025-04-19 11:13:00', '2025-05-14 21:38:52');
INSERT INTO `recipe` VALUES (86, '枸杞酸奶', '枸杞子10g，无糖酸奶150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a60a684酸奶.webp', 2, 3, 3, '2025-04-19 11:13:00', '2025-04-19 20:18:48');
INSERT INTO `recipe` VALUES (87, '猪肉菌香包子', '全麦面粉40g，苗香苗50g，猪瘦肉20g，香菇10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=43d9a9c猪肉菌香包子.webp', 3, 3, 3, '2025-04-19 11:13:00', '2025-05-14 21:32:48');
INSERT INTO `recipe` VALUES (88, '小白菜炖豆腐', '小白菜100g，北豆腐30g，香菇20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1331c57小白菜炖豆腐.webp', 3, 3, 3, '2025-04-19 11:13:00', '2025-04-19 19:17:42');
INSERT INTO `recipe` VALUES (89, '凉拌马齿苋', '马齿苋120g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ae00094凉拌马齿苋.webp', 3, 3, 3, '2025-04-19 11:13:00', '2025-05-14 21:33:03');
INSERT INTO `recipe` VALUES (90, '桂花山药软饼', '桂花干1g，山药泥80g，全麦面粉35g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ffa3f37桂花山药软饼.webp', 1, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:33:32');
INSERT INTO `recipe` VALUES (91, '肉丝炒萝卜丝', '白萝卜100g，猪里脊肉丝15g，香菜5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7fd94d0肉丝炒萝卜丝.webp', 1, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:33:48');
INSERT INTO `recipe` VALUES (92, '脱脂牛奶', '200mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 3, 4, '2025-04-19 11:13:00', '2025-04-19 18:52:29');
INSERT INTO `recipe` VALUES (93, '赤豆黄精紫米饭', '紫米45g，黄精10g，赤小豆10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=99de2c9赤豆黄精紫米饭.webp', 2, 3, 4, '2025-04-19 11:13:00', '2025-04-19 18:44:47');
INSERT INTO `recipe` VALUES (94, '彩椒炒鸡丁', '鸡肉30g，香菇10g，柿子椒100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5915b71彩椒炒鸡丁.webp', 2, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:34:04');
INSERT INTO `recipe` VALUES (95, '白灼西兰花', '西兰花100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1f20203白灼西兰花.webp', 2, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:34:19');
INSERT INTO `recipe` VALUES (96, '无糖黑豆浆', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=621ba6e无糖黑豆浆.webp', 2, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:34:53');
INSERT INTO `recipe` VALUES (97, '白菜烧豆腐', '白菜100g，北豆腐30g，鲜辣椒5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=051f325白菜烧豆腐.webp', 3, 3, 4, '2025-04-19 11:13:00', '2025-04-19 19:18:44');
INSERT INTO `recipe` VALUES (98, '豆芽海带汤', '黄豆芽30g，海带50g，金针菇25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8f223c1豆芽海带汤.webp', 3, 3, 4, '2025-04-19 11:13:00', '2025-05-14 21:35:10');
INSERT INTO `recipe` VALUES (99, '馒头', '面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=21e3eac馒头.jpg', 1, 6, 1, '2025-04-19 11:13:00', '2025-04-19 19:21:19');
INSERT INTO `recipe` VALUES (100, '煮鸡蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0422f11鸡蛋.webp', 1, 6, 1, '2025-04-19 11:13:00', '2025-04-19 19:12:52');
INSERT INTO `recipe` VALUES (101, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 6, 1, '2025-04-19 11:13:00', '2025-04-19 18:52:15');
INSERT INTO `recipe` VALUES (102, '凉拌菠菜', '菠菜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c50b5b1凉拌菠菜.webp', 2, 6, 1, '2025-04-19 11:13:00', '2025-05-14 21:27:43');
INSERT INTO `recipe` VALUES (103, '苹果', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=98d931a苹果.webp', 2, 6, 1, '2025-04-19 11:13:00', '2025-04-19 18:48:46');
INSERT INTO `recipe` VALUES (104, '二米饭', '大米30g，小米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=722366b二米饭.webp', 3, 6, 1, '2025-04-19 11:13:00', '2025-04-19 18:44:42');
INSERT INTO `recipe` VALUES (105, '铁锅炖鱼', '草鱼50g，北豆腐50g，白菜100g，黄芪5g，八角茴香3g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c138374铁锅炖鱼.webp', 3, 6, 1, '2025-04-19 11:13:00', '2025-05-14 21:27:25');
INSERT INTO `recipe` VALUES (106, '菜包饭', '生菜100g，大米30g，小米20g，猪里脊肉50g，土豆30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5b5492e菜包饭.webp', 2, 6, 1, '2025-04-19 11:13:00', '2025-04-19 18:56:03');
INSERT INTO `recipe` VALUES (107, '西兰花虾皮萝卜汤', '西兰花100g，白萝卜30g，虾皮10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=61ddd61西兰花虾皮萝卜汤.webp', 1, 6, 1, '2025-04-19 11:13:00', '2025-05-14 21:27:01');
INSERT INTO `recipe` VALUES (108, '煮玉米', '玉米【带棒】150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e9b5b42煮玉米.webp', 1, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:29:27');
INSERT INTO `recipe` VALUES (109, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 6, 2, '2025-04-19 11:13:00', '2025-04-19 18:52:11');
INSERT INTO `recipe` VALUES (110, '煮鸡蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bb3d12c鸡蛋.webp', 1, 6, 2, '2025-04-19 11:13:00', '2025-04-19 19:12:46');
INSERT INTO `recipe` VALUES (111, '西瓜', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=46f43ce西瓜.webp', 2, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:30:01');
INSERT INTO `recipe` VALUES (112, '沙葱猪肉水饺', '面粉100g，沙葱100g，猪里脊肉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=43f6df6沙葱猪肉水饺.webp', 3, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:32:06');
INSERT INTO `recipe` VALUES (113, '凉拌秋葵', '秋葵100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7d659fb凉拌秋葵.webp', 3, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:31:51');
INSERT INTO `recipe` VALUES (114, '桑椹枸杞玫瑰茶', '桑椹干10g，枸杞子10颗，玫瑰干5朵', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9e72b50桑椹枸杞玫瑰茶.webp', 2, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:31:35');
INSERT INTO `recipe` VALUES (115, '莲子百合粥', '大米50g，百合10g，莲子15g，枸杞子10颗', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1abcdbe莲子百合粥.webp', 1, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:31:18');
INSERT INTO `recipe` VALUES (116, '蒜泥茄子', '茄子100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=adba7c9蒜泥茄子.webp', 2, 6, 2, '2025-04-19 11:13:00', '2025-05-14 21:30:58');
INSERT INTO `recipe` VALUES (117, '无糖酸奶', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9e558ed酸奶.webp', 3, 6, 2, '2025-04-19 11:13:00', '2025-04-19 20:18:36');
INSERT INTO `recipe` VALUES (118, '椒盐花卷', '面粉50g，花椒5g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1a4b755椒盐花卷.webp', 1, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:29:15');
INSERT INTO `recipe` VALUES (119, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 6, 3, '2025-04-19 11:13:00', '2025-04-19 18:52:10');
INSERT INTO `recipe` VALUES (120, '凉拌藕片', '藕片50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3b2b530凉拌藕片.webp', 1, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:28:58');
INSERT INTO `recipe` VALUES (121, '鸭梨', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dd1ac2f鸭梨.webp', 2, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:28:43');
INSERT INTO `recipe` VALUES (122, '二米饭', '大米30g，小米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=18e15d6二米饭.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-04-19 18:44:54');
INSERT INTO `recipe` VALUES (123, '小鸡炖蘑菇', '鸡肉50g，红菇20g，生姜10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7ff62d8小鸡炖蘑菇.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:28:24');
INSERT INTO `recipe` VALUES (124, '炝炒西葫芦', '西葫芦100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2a98196炝炒西葫芦.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:28:10');
INSERT INTO `recipe` VALUES (125, '无糖酸奶', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=033e523酸奶.webp', 2, 6, 3, '2025-04-19 11:13:00', '2025-04-19 20:18:24');
INSERT INTO `recipe` VALUES (126, '玉米饼', '玉米面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c257c27玉米饼.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:15:53');
INSERT INTO `recipe` VALUES (127, '大拌凉皮', '面皮50g，黄瓜50g，胡萝卜50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3033db8大拌凉皮.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:15:42');
INSERT INTO `recipe` VALUES (128, '清蒸鲈鱼', '鲈鱼50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5673ec7清蒸鲈鱼.webp', 3, 6, 3, '2025-04-19 11:13:00', '2025-05-14 21:15:39');
INSERT INTO `recipe` VALUES (129, '蒸山药', '鲜山药50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5299b47蒸山药.webp', 1, 6, 4, '2025-04-19 11:13:00', '2025-04-19 20:20:43');
INSERT INTO `recipe` VALUES (130, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 6, 4, '2025-04-19 11:13:00', '2025-04-19 18:52:14');
INSERT INTO `recipe` VALUES (131, '茶叶蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=302a5ec鸡蛋.webp', 1, 6, 4, '2025-04-19 11:13:00', '2025-04-19 19:12:42');
INSERT INTO `recipe` VALUES (132, '芝麻菠菜', '菠菜50g，白芝麻10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5978f06芝麻菠菜.webp', 2, 6, 4, '2025-04-19 11:13:00', '2025-05-14 21:14:08');
INSERT INTO `recipe` VALUES (133, '冬枣', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=02e7999冬枣.webp', 2, 6, 4, '2025-04-19 11:13:00', '2025-04-19 20:03:04');
INSERT INTO `recipe` VALUES (134, '二米饭', '大米30g，小米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dccd652二米饭.webp', 3, 6, 4, '2025-04-19 11:13:00', '2025-04-19 18:44:59');
INSERT INTO `recipe` VALUES (135, '猪肉炖酸菜', '猪里脊肉50g，酸菜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=08e529a猪肉炖酸菜.webp', 3, 6, 4, '2025-04-19 11:13:00', '2025-04-19 20:19:58');
INSERT INTO `recipe` VALUES (136, '红枣发糕', '全麦面粉50g，大枣20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=44b6ea0红枣发糕.jpg', 1, 6, 4, '2025-04-19 11:13:00', '2025-05-14 21:15:33');
INSERT INTO `recipe` VALUES (137, '藜麦沙拉', '藜麦20g，生菜50g，苦苣50g，紫甘蓝50g，鲜虾仁50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ac5c292沙拉.webp', 3, 6, 4, '2025-04-19 11:13:00', '2025-04-19 19:22:31');
INSERT INTO `recipe` VALUES (139, '煮玉米', '玉米【带棒】200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9ffb841煮玉米.webp', 1, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:14:30');
INSERT INTO `recipe` VALUES (140, '杂粮粥', '赤小豆10g，小米10g，大米10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ea1b06c杂粮饭.webp', 1, 4, 1, '2025-04-19 11:13:00', '2025-04-19 19:10:26');
INSERT INTO `recipe` VALUES (141, '煮鸡蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3b1d749鸡蛋.webp', 1, 4, 1, '2025-04-19 11:13:00', '2025-04-19 19:12:36');
INSERT INTO `recipe` VALUES (142, '凉拌木耳胡萝卜丝', '胡萝卜100g，木耳10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dd05373凉拌木耳胡萝卜丝.webp', 2, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:14:50');
INSERT INTO `recipe` VALUES (143, '杂粮饭', '大米25g，薏苡仁25g，紫米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ea1b06c杂粮饭.webp', 3, 4, 1, '2025-04-19 11:13:00', '2025-04-19 18:43:49');
INSERT INTO `recipe` VALUES (144, '猪肉白菜豆腐炖粉条', '粉条25g，北豆腐50g，猪后腿肉35g，白菜200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6564ab7猪肉白菜豆腐炖粉条.webp', 3, 4, 1, '2025-04-19 11:13:00', '2025-04-19 19:18:05');
INSERT INTO `recipe` VALUES (145, '香菇炒青菜', '小青菜100g，香菇20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=92c4ebb香菇炒青菜.webp', 3, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:15:12');
INSERT INTO `recipe` VALUES (146, '腰果仁', '10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=cd8e6cd腰果仁.webp', 2, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:15:28');
INSERT INTO `recipe` VALUES (147, '清炒芹菜', '芹菜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6d2a770清炒芹菜.webp', 3, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:11:42');
INSERT INTO `recipe` VALUES (148, '羊肉汤', '羊瘦肉25g，面粉15g，小葱5g，生姜2g，花椒1g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=15e4436羊肉汤.webp', 3, 4, 1, '2025-04-19 11:13:00', '2025-05-14 21:12:10');
INSERT INTO `recipe` VALUES (149, '杂粮花卷', '面粉25g，玉米面粉25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0421293杂粮花卷.jpg', 1, 4, 2, '2025-04-19 11:13:00', '2025-04-19 20:14:34');
INSERT INTO `recipe` VALUES (150, '鸡蛋羹', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3faa970鸡蛋羹.webp', 1, 4, 2, '2025-04-19 11:13:00', '2025-04-19 20:13:38');
INSERT INTO `recipe` VALUES (151, '小葱拌豆腐', '嫩豆腐50g，香葱20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d704cdf小葱拌豆腐.webp', 1, 4, 2, '2025-04-19 11:13:00', '2025-04-19 19:16:02');
INSERT INTO `recipe` VALUES (152, '低脂酸奶', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=600f581酸奶.webp', 2, 4, 2, '2025-04-19 11:13:00', '2025-04-19 20:13:29');
INSERT INTO `recipe` VALUES (153, '糙米饭', '糙米35g，大米40g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1c1a3cd糙米饭.webp', 3, 4, 2, '2025-04-19 11:13:00', '2025-04-19 18:45:46');
INSERT INTO `recipe` VALUES (154, '红烧牛肉', '牛腱肉60g，胡萝卜100g，土豆100g，生姜2g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fa302bd红烧牛肉.webp', 3, 4, 2, '2025-04-19 11:13:00', '2025-05-14 21:12:29');
INSERT INTO `recipe` VALUES (155, '芹菜腐竹炒肉', '芹菜100g，腐竹20g，猪瘦肉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=88a12b0芹菜腐竹炒肉.webp', 3, 4, 2, '2025-04-19 11:13:00', '2025-05-14 21:12:46');
INSERT INTO `recipe` VALUES (156, '苹果', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7b2a12f苹果.webp', 2, 4, 2, '2025-04-19 11:13:00', '2025-04-19 18:48:42');
INSERT INTO `recipe` VALUES (157, '莜麦汤面', '莜麦面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ab2f43b莜麦汤面.webp', 3, 4, 2, '2025-04-19 11:13:00', '2025-04-19 20:14:06');
INSERT INTO `recipe` VALUES (158, '发糕', '玉米面粉30g，面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c17bd00红枣发糕.jpg', 1, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:13:47');
INSERT INTO `recipe` VALUES (159, '豆腐脑', '150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7a7b51f豆腐脑.webp', 1, 4, 3, '2025-04-19 11:13:00', '2025-04-19 19:13:50');
INSERT INTO `recipe` VALUES (160, '西芹腐竹', '西芹50g，腐竹30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=218905f西芹腐竹.webp', 1, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:17:08');
INSERT INTO `recipe` VALUES (161, '柚子', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b95c5fc柚子.webp', 2, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:14:55');
INSERT INTO `recipe` VALUES (162, '二米饭', '大米30g，小米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4a19160二米饭.webp', 3, 4, 3, '2025-04-19 11:13:00', '2025-04-19 18:45:51');
INSERT INTO `recipe` VALUES (163, '小鸡炖蘑菇', '鸡肉50g，红菇20g，生姜10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=912d123小鸡炖蘑菇.webp', 3, 4, 3, '2025-04-19 11:13:00', '2025-05-14 21:13:07');
INSERT INTO `recipe` VALUES (164, '炝炒西葫芦', '西葫芦100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5d97e6f炝炒西葫芦.webp', 3, 4, 3, '2025-04-19 11:13:00', '2025-05-14 21:13:30');
INSERT INTO `recipe` VALUES (165, '无糖酸奶', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1eb2f22酸奶.webp', 2, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:15:04');
INSERT INTO `recipe` VALUES (166, '玉米饼', '玉米面粉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c257c27玉米饼.webp', 3, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:15:24');
INSERT INTO `recipe` VALUES (167, '清蒸鲈鱼', '鲈鱼50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5673ec7清蒸鲈鱼.webp', 3, 4, 3, '2025-04-19 11:13:00', '2025-04-19 20:15:44');
INSERT INTO `recipe` VALUES (168, '锅盔辣子馍', '面粉25g，油辣子2g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5952d3d锅盔辣子馍.webp', 1, 4, 4, '2025-04-19 11:13:00', '2025-04-19 20:16:25');
INSERT INTO `recipe` VALUES (169, '煮鸡蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c23e66d鸡蛋.webp', 1, 4, 4, '2025-04-19 11:13:00', '2025-04-19 19:12:31');
INSERT INTO `recipe` VALUES (170, '清炒豆芽', '黄豆芽100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f4b3727清炒豆芽.webp', 1, 4, 4, '2025-04-19 11:13:00', '2025-04-19 20:16:07');
INSERT INTO `recipe` VALUES (171, '豆腐脑', '豆腐100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=75c0eb5豆腐脑.webp', 2, 4, 4, '2025-04-19 11:13:00', '2025-04-19 19:13:46');
INSERT INTO `recipe` VALUES (172, '杂粮饼', '面粉50g，玉米面粉25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a4fa3eb杂粮饼.webp', 3, 4, 4, '2025-04-19 11:13:00', '2025-05-14 21:07:53');
INSERT INTO `recipe` VALUES (173, '冬瓜炖排骨', '冬瓜100g，猪排骨80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c9c2efd冬瓜炖排骨.webp', 3, 4, 4, '2025-04-19 11:13:00', '2025-05-14 21:08:22');
INSERT INTO `recipe` VALUES (174, '芹菜炒香干', '芹菜100g，豆腐干50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e589243芹菜炒香干.webp', 3, 4, 4, '2025-04-19 11:13:00', '2025-05-14 21:08:43');
INSERT INTO `recipe` VALUES (175, '莲子百合羹', '莲子20g，百合10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=88b7c90莲子百合羹.webp', 2, 4, 4, '2025-04-19 11:13:00', '2025-05-14 21:08:59');
INSERT INTO `recipe` VALUES (176, '羊肉汤面', '面粉50g，羊肉25g，土豆30g，胡萝卜50g，西红柿20g，小白菜30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=08d389b羊肉汤面.webp', 3, 4, 4, '2025-04-19 11:13:00', '2025-05-14 21:09:21');
INSERT INTO `recipe` VALUES (177, '红薯', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ad1cf5d红薯.webp', 1, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:09:47');
INSERT INTO `recipe` VALUES (178, '牛奶', '160mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=54df36f牛奶.webp', 1, 5, 1, '2025-04-19 11:13:00', '2025-04-19 18:53:04');
INSERT INTO `recipe` VALUES (181, '花生糙米饭', '花生15g，糙米25g，大米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8c4ff8a花生糙米饭.webp', 2, 5, 1, '2025-04-19 11:13:00', '2025-04-19 18:47:37');
INSERT INTO `recipe` VALUES (182, '瘦肉饼蒸蛋', '猪瘦肉30g，鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2010a14瘦肉饼蒸蛋.webp', 2, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:10:06');
INSERT INTO `recipe` VALUES (183, '烫生菜', '生菜200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f417b97烫生菜.webp', 2, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:10:22');
INSERT INTO `recipe` VALUES (184, '枸杞猪肝汤', '猪肝25g，枸杞子10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6edc137枸杞猪肝汤.webp', 2, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:10:39');
INSERT INTO `recipe` VALUES (185, '猕猴桃', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ee48fb8猕猴桃.webp', 3, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:10:56');
INSERT INTO `recipe` VALUES (186, '藜麦小米饭', '藜麦30g，大米15g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=79ce4bf藜麦小米饭.webp', 3, 5, 1, '2025-04-19 11:13:00', '2025-04-19 18:47:31');
INSERT INTO `recipe` VALUES (187, '蒸鲈鱼', '鲈鱼50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0f42aba清蒸鲈鱼.webp', 3, 5, 1, '2025-04-19 11:13:00', '2025-04-19 20:17:24');
INSERT INTO `recipe` VALUES (188, '香菇炒菜心', '香菇【鲜】100g，广东菜心50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1bd05f4香菇炒菜心.webp', 3, 5, 1, '2025-04-19 11:13:00', '2025-05-14 21:11:12');
INSERT INTO `recipe` VALUES (189, '炒油麦菜', '油麦菜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=83c0468炒油麦菜.webp', 3, 5, 1, '2025-04-19 11:13:00', '2025-05-16 19:00:02');
INSERT INTO `recipe` VALUES (190, '虾米馄饨', '馄饨皮60g，虾仁30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f5a8827虾米馄饨.webp', 1, 5, 2, '2025-04-19 11:13:00', '2025-05-14 21:07:17');
INSERT INTO `recipe` VALUES (191, '酸辣白菜', '小米辣10g，大白菜200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=978713c酸辣白菜.webp', 1, 5, 2, '2025-04-19 11:13:00', '2025-05-14 21:06:48');
INSERT INTO `recipe` VALUES (192, '杂粮米饭', '大米60g，冻玉米粒10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=fc0686c杂粮饭.webp', 2, 5, 2, '2025-04-19 11:13:00', '2025-04-19 18:43:41');
INSERT INTO `recipe` VALUES (193, '麻辣豆腐', '小米辣10g，南豆腐100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1ac68af麻辣豆腐.webp', 2, 5, 2, '2025-04-19 11:13:00', '2025-04-19 19:15:28');
INSERT INTO `recipe` VALUES (194, '牛肉冬瓜汤', '牛瘦肉50g，冬瓜80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1d83341牛肉冬瓜汤.webp', 2, 5, 2, '2025-04-19 11:13:00', '2025-05-14 21:06:26');
INSERT INTO `recipe` VALUES (195, '低脂牛奶', '180mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5f71357牛奶.webp', 3, 5, 2, '2025-04-19 11:13:00', '2025-04-19 18:51:10');
INSERT INTO `recipe` VALUES (196, '杂粮米饭', '黑米25g，大米35g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6565c14杂粮饭.webp', 3, 5, 2, '2025-04-19 11:13:00', '2025-04-19 18:43:36');
INSERT INTO `recipe` VALUES (197, '辣椒炒鸡肉', '尖椒80g，鸡胸肉50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d977d08辣椒炒鸡肉.webp', 3, 5, 2, '2025-04-19 11:13:00', '2025-05-14 21:05:56');
INSERT INTO `recipe` VALUES (198, '西兰花炒香菇', '西兰花100g，香菇60g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2f2bd96西兰花炒香菇.webp', 3, 5, 2, '2025-04-19 11:13:00', '2025-05-14 21:05:31');
INSERT INTO `recipe` VALUES (199, '山药菌菇汤', '鲜山药30g，香菇25g，白玉菇25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f0a0b22山药菌菇汤.webp', 3, 5, 2, '2025-04-19 11:13:00', '2025-04-19 20:10:00');
INSERT INTO `recipe` VALUES (200, '蒸南瓜', '150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8b034fc蒸南瓜.webp', 1, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:09:28');
INSERT INTO `recipe` VALUES (201, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e3c75fa牛奶.webp', 1, 5, 3, '2025-04-19 11:13:00', '2025-04-19 18:51:05');
INSERT INTO `recipe` VALUES (202, '鸡蛋', '50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8365041鸡蛋.webp', 1, 5, 3, '2025-04-19 11:13:00', '2025-04-19 19:12:25');
INSERT INTO `recipe` VALUES (203, '茶盐鸡蛋', '50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e059c56鸡蛋.webp', 2, 5, 3, '2025-04-19 11:13:00', '2025-04-19 19:12:20');
INSERT INTO `recipe` VALUES (204, '杂粮馒头', '面粉40g，玉米面粉25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=508a2cd馒头.jpg', 2, 5, 3, '2025-04-19 11:13:00', '2025-04-19 19:21:25');
INSERT INTO `recipe` VALUES (205, '圆白菜炒腐竹', '圆白菜100g，腐竹20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=74b1b72圆白菜炒腐竹.webp', 2, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:09:03');
INSERT INTO `recipe` VALUES (206, '虾皮紫菜鸡蛋羹', '虾皮10g，紫菜10g，鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e403ddb虾仁鸡蛋羹.webp', 2, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:08:44');
INSERT INTO `recipe` VALUES (207, '开心果仁', '10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=a3984fe开心果仁.webp', 3, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:08:36');
INSERT INTO `recipe` VALUES (208, '苋菜汤', '苋菜150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=843f050苋菜汤.webp', 3, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:11:10');
INSERT INTO `recipe` VALUES (209, '山药炒肉片', '鲜山药150g，红米25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=6a09426山药炒肉片.webp', 3, 5, 3, '2025-04-19 11:13:00', '2025-04-19 20:11:33');
INSERT INTO `recipe` VALUES (210, '蒸山药', '鲜山药*300g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=5299b47蒸山药.webp', 1, 5, 4, '2025-04-19 11:13:00', '2025-04-19 20:10:23');
INSERT INTO `recipe` VALUES (211, '二米饭', '大米30g，小米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0b89b49二米饭.webp', 2, 5, 4, '2025-04-19 11:13:00', '2025-04-19 18:45:59');
INSERT INTO `recipe` VALUES (212, '猪肉炖酸菜', '猪里脊肉50g，酸菜100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=08e529a猪肉炖酸菜.webp', 2, 5, 4, '2025-04-19 11:13:00', '2025-04-19 20:12:28');
INSERT INTO `recipe` VALUES (213, '红枣发糕', '20g，生姜50g，大枣10g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=44b6ea0红枣发糕.jpg', 3, 5, 4, '2025-04-19 11:13:00', '2025-04-19 20:12:08');
INSERT INTO `recipe` VALUES (214, '藜麦沙拉', '藜麦20g，苦苣50g，紫甘蓝50g，鲜虾仁50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1b71187沙拉.webp', 3, 5, 4, '2025-04-19 11:13:00', '2025-04-19 19:22:21');
INSERT INTO `recipe` VALUES (216, '低脂牛奶', '100mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=4458abe牛奶.webp', 1, 5, 4, '2025-04-19 11:13:00', '2025-04-19 18:51:01');
INSERT INTO `recipe` VALUES (217, '茶叶蛋', '鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=08c4478鸡蛋.webp', 1, 5, 4, '2025-04-19 11:13:00', '2025-04-19 19:12:14');
INSERT INTO `recipe` VALUES (218, '冬枣', '100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d0e0ee1冬枣.webp', 2, 5, 4, '2025-04-19 11:13:00', '2025-04-19 20:02:48');
INSERT INTO `recipe` VALUES (219, '菠菜鸡蛋汤面', '菠菜50g，鸡蛋25g，面条40g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d8c4c43菠菜鸡蛋汤面.webp', 1, 1, 1, '2025-04-19 11:13:00', '2025-04-19 20:02:41');
INSERT INTO `recipe` VALUES (220, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=3ab5764牛奶.webp', 1, 1, 1, '2025-04-19 11:13:00', '2025-04-19 18:50:57');
INSERT INTO `recipe` VALUES (221, '红薯饭', '大米40g，红薯100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e874151红薯饭.webp', 2, 1, 1, '2025-04-19 11:13:00', '2025-04-19 18:48:27');
INSERT INTO `recipe` VALUES (222, '胡萝卜炒肉', '柿子椒30g，胡萝卜50g，猪瘦肉40g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=891c627胡萝卜炒肉.webp', 2, 1, 1, '2025-04-19 11:13:00', '2025-04-19 20:12:52');
INSERT INTO `recipe` VALUES (223, '西红柿豆腐汤', '西红柿50g，豆腐30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d59e443西红柿豆腐汤.webp', 2, 1, 1, '2025-04-19 11:13:00', '2025-04-19 19:13:39');
INSERT INTO `recipe` VALUES (224, '橙子', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b82d25d橙子.webp', 3, 1, 1, '2025-04-19 11:13:00', '2025-04-19 20:01:41');
INSERT INTO `recipe` VALUES (225, '红白饭', '大米20g，红米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=24972d2红白饭.webp', 3, 1, 1, '2025-04-19 11:13:00', '2025-04-19 18:48:20');
INSERT INTO `recipe` VALUES (226, '莴苣苣炒鸡', '鸡肉40g，莴苣苣50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=e5faac5莴苣苣炒鸡.webp', 3, 1, 1, '2025-04-19 11:13:00', '2025-04-19 20:01:36');
INSERT INTO `recipe` VALUES (227, '鸡蛋肠粉', '菠菜50g，鸡蛋50g，肠粉150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8370b0f蛋肠粉.webp', 1, 1, 2, '2025-04-19 11:13:00', '2025-04-19 19:13:17');
INSERT INTO `recipe` VALUES (228, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=94d5ea5牛奶.webp', 1, 1, 2, '2025-04-19 11:13:00', '2025-04-19 18:50:53');
INSERT INTO `recipe` VALUES (229, '米饭', '大米60g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=93b2964米饭.webp', 2, 1, 2, '2025-04-19 11:13:00', '2025-04-19 18:43:04');
INSERT INTO `recipe` VALUES (230, '清蒸鲩鱼', '鲩鱼30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=845deff清蒸鲩鱼.webp', 2, 1, 2, '2025-04-19 11:13:00', '2025-04-19 19:07:01');
INSERT INTO `recipe` VALUES (231, '盐水菜心', '菜心100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1855412盐水菜心.webp', 2, 1, 2, '2025-04-19 11:13:00', '2025-04-19 19:06:23');
INSERT INTO `recipe` VALUES (232, '苹果', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=7b0c4d6苹果.webp', 3, 1, 2, '2025-04-19 11:13:00', '2025-04-19 18:48:38');
INSERT INTO `recipe` VALUES (233, '黄白饭', '大米25g，玉米碴干120g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ad60c9a黄白饭.webp', 3, 1, 2, '2025-04-19 11:13:00', '2025-04-19 18:42:43');
INSERT INTO `recipe` VALUES (234, '水煮油莱', '油莱150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d1ff497水煮油莱.webp', 3, 1, 2, '2025-04-19 11:13:00', '2025-04-19 19:06:02');
INSERT INTO `recipe` VALUES (235, '白菜肉饺', '面粉50g，大白菜25g，鲜山药15g，玉米15g，香葱1g，虾米4g，猪瘦肉15g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=f7f6755白菜肉饺.webp', 1, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:05:54');
INSERT INTO `recipe` VALUES (236, '米饭', '大米50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=49fc3cb米饭.webp', 2, 1, 3, '2025-04-19 11:13:00', '2025-04-19 18:42:49');
INSERT INTO `recipe` VALUES (237, '黄豆芽炒瘦肉', '猪瘦肉15g，黄豆芽100g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9515ec1黄豆芽炒瘦肉.webp', 2, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:05:17');
INSERT INTO `recipe` VALUES (238, '蒸鹅', '鹅肉25g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=9c0013b蒸鹅.webp', 2, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:04:51');
INSERT INTO `recipe` VALUES (239, '西红柿豆腐汤', '西红柿150g，豆腐50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=67cfa0e西红柿豆腐汤.webp', 2, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:04:28');
INSERT INTO `recipe` VALUES (240, '鹰嘴桃', '200g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ed24e59鹰嘴桃.webp', 3, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:03:49');
INSERT INTO `recipe` VALUES (241, '米饭', '大米20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=ea0c7bd米饭.webp', 3, 1, 3, '2025-04-19 11:13:00', '2025-04-19 18:42:53');
INSERT INTO `recipe` VALUES (242, '百合炒鸡', '西芹100g，百合30g，鸡肉20g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2bfe8df百合炒鸡.webp', 3, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:03:25');
INSERT INTO `recipe` VALUES (243, '炒上海青', '上海青150g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=dc80074炒上海青.webp', 3, 1, 3, '2025-04-19 11:13:00', '2025-04-19 19:03:21');
INSERT INTO `recipe` VALUES (244, '蛋肠粉', '肠粉【湿】250g，鸡蛋50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=445f659蛋肠粉.webp', 1, 1, 4, '2025-04-19 11:13:00', '2025-04-19 19:02:17');
INSERT INTO `recipe` VALUES (245, '低脂牛奶', '250mL', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=976e889牛奶.webp', 1, 1, 4, '2025-04-19 11:13:00', '2025-04-19 18:50:49');
INSERT INTO `recipe` VALUES (246, '糙米饭', '糙米90g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=1882cae糙米饭.webp', 2, 1, 4, '2025-04-19 11:13:00', '2025-04-19 18:42:58');
INSERT INTO `recipe` VALUES (247, '鲜虾焖冬笋', '冬笋80g，海虾30g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c02ad66鲜虾焖冬笋.jpg@h_1280', 2, 1, 4, '2025-04-19 11:13:00', '2025-04-19 18:40:18');
INSERT INTO `recipe` VALUES (248, '水煮奶白菜', '烧脚白菜80g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=2fefe9b水煮奶白菜.jpg@watermark=0', 2, 1, 4, '2025-04-19 11:13:00', '2025-04-19 18:38:46');
INSERT INTO `recipe` VALUES (249, '枸杞叶豆腐汤', '枸杞叶50g，豆腐50g', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=064fb99gouqi.webp', 2, 1, 4, '2025-04-19 11:13:00', '2025-04-19 18:36:17');

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地区名称',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地区代码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of region
-- ----------------------------
INSERT INTO `region` VALUES (1, '华南地区', 'south');
INSERT INTO `region` VALUES (2, '华东地区', 'east');
INSERT INTO `region` VALUES (3, '华北地区', 'north');
INSERT INTO `region` VALUES (4, '西部地区', 'west');
INSERT INTO `region` VALUES (5, '华中地区', 'central');
INSERT INTO `region` VALUES (6, '东北地区', 'east-north');

-- ----------------------------
-- Table structure for season
-- ----------------------------
DROP TABLE IF EXISTS `season`;
CREATE TABLE `season`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '季节名称',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '季节代码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '季节表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of season
-- ----------------------------
INSERT INTO `season` VALUES (1, '春季', 'spring');
INSERT INTO `season` VALUES (2, '夏季', 'summer');
INSERT INTO `season` VALUES (3, '秋季', 'autumn');
INSERT INTO `season` VALUES (4, '冬季', 'winter');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标签分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '标签分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (1, '心理');
INSERT INTO `tags` VALUES (2, '运动');
INSERT INTO `tags` VALUES (3, '饮食');
INSERT INTO `tags` VALUES (4, '护肤');
INSERT INTO `tags` VALUES (5, '美妆');
INSERT INTO `tags` VALUES (6, '环境');
INSERT INTO `tags` VALUES (7, '职业');
INSERT INTO `tags` VALUES (8, '精神');
INSERT INTO `tags` VALUES (9, '恋爱');
INSERT INTO `tags` VALUES (10, '校园');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户账号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户密码',
  `user_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `user_role` int NULL DEFAULT NULL COMMENT '用户角色(1：管理员）',
  `is_login` tinyint(1) NULL DEFAULT NULL COMMENT '可登录状态(0：可用，1：不可用)',
  `is_word` tinyint(1) NULL DEFAULT NULL COMMENT '禁言状态(0：可用，1：不可用)',
  `gender` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0：女性，1：男性)',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `create_time` datetime NULL DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'whd', '吴汉东', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=8b13839微信图片_2025-05-21_010610_632.jpg', '2303532728@qq.com', 2, 0, 0, 1, 20, '2025-04-02 23:05:58');
INSERT INTO `user` VALUES (3, 'xhr', '许浩然', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b5718ff20.jpg', '123@qq.com', 2, 0, 0, 1, 20, '2025-04-18 23:06:21');
INSERT INTO `user` VALUES (4, 'lym', '刘玉明', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=82dd17818.jpg', '1234@qq.com', 2, 0, 0, 1, 21, '2025-04-03 23:07:06');
INSERT INTO `user` VALUES (5, 'wwb', '王文博', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=cb8bbda17.jpg', '1234@qq.com', 2, 0, 0, 1, 19, '2025-04-04 23:07:44');
INSERT INTO `user` VALUES (6, 'wzr', '王梓瑞', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=768ca766.jpg', '1234@qq.com', 2, 0, 1, 1, 19, '2025-04-05 23:08:06');
INSERT INTO `user` VALUES (7, 'zyk', '张殷恺', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=bd3a863admin.jpg', '1234@qq.com', 2, 1, 0, 1, 19, '2025-04-05 23:09:00');
INSERT INTO `user` VALUES (8, 'zle', '张淋迩', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=25cc72b21.jpg', '1234@qq.com', 2, 0, 0, 0, 19, '2025-04-06 23:09:40');
INSERT INTO `user` VALUES (9, 'fjq', '付佳琪', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=824821210.jpg', '1234@qq.com', 2, 0, 0, 0, 20, '2025-04-06 23:10:19');
INSERT INTO `user` VALUES (16, 'lyh', '刘伊恒', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=c86d1b711.jpg', '1234@qq.com', 2, 0, 0, 0, 20, '2025-04-06 23:18:43');
INSERT INTO `user` VALUES (17, 'rty', '任天翌', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0b8e0f65.jpg', '1234@qq.com', 2, 0, 0, 1, 19, '2025-04-08 23:18:46');
INSERT INTO `user` VALUES (18, 'yjt', '余霁庭', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=0fcb9ef4.jpg', '1234@qq.com', 2, 0, 0, 1, 19, '2025-04-09 23:18:50');
INSERT INTO `user` VALUES (19, 'ycx', '叶辰勋', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=b724e4d3.jpg', '1234@qq.com', 2, 0, 0, 0, 21, '2025-04-10 23:18:53');
INSERT INTO `user` VALUES (20, 'lcz', '吕承泽', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=d18076d2.jpg', '1234@qq.com', 2, 0, 0, 1, 19, '2025-04-16 23:18:57');
INSERT INTO `user` VALUES (29, 'Jenrimark', 'Jenrimark', '14e1b600b1fd579f47433b88e8d85291', 'http://localhost:8080/api/personal-heath/v1.0/file/getFile?fileName=249bc9eImage_1720676880457.jpg', '230@qq.com', 1, 0, 0, 1, 19, '2025-06-16 11:24:46');

-- ----------------------------
-- Table structure for user_health
-- ----------------------------
DROP TABLE IF EXISTS `user_health`;
CREATE TABLE `user_health`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户健康记录主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `health_model_config_id` int NULL DEFAULT NULL COMMENT '健康模型ID',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '输入的值',
  `create_time` datetime NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 430 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户健康记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_health
-- ----------------------------
INSERT INTO `user_health` VALUES (1, 2, 6, '2', '2025-04-19 00:15:36');
INSERT INTO `user_health` VALUES (2, 2, 2, '47.8', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (3, 2, 1, '165', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (4, 2, 3, '1500', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (5, 2, 5, '9', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (6, 2, 7, '90', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (7, 2, 9, '3000', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (8, 2, 14, '36.2', '2025-04-19 00:19:39');
INSERT INTO `user_health` VALUES (9, 2, 12, '90', '2025-04-19 00:19:52');
INSERT INTO `user_health` VALUES (10, 2, 2, '48', '2025-04-19 00:20:22');
INSERT INTO `user_health` VALUES (11, 2, 14, '36.4', '2025-04-19 00:20:22');
INSERT INTO `user_health` VALUES (12, 2, 15, '200', '2025-04-19 00:22:15');
INSERT INTO `user_health` VALUES (13, 2, 14, '38.3', '2025-04-19 00:31:36');
INSERT INTO `user_health` VALUES (14, 2, 12, '59', '2025-04-19 00:31:57');
INSERT INTO `user_health` VALUES (15, 2, 12, '58', '2025-04-19 01:03:54');
INSERT INTO `user_health` VALUES (16, 2, 14, '36.5', '2025-04-24 13:51:54');
INSERT INTO `user_health` VALUES (17, 2, 8, '78', '2025-04-24 13:52:19');
INSERT INTO `user_health` VALUES (18, 2, 7, '90', '2025-04-24 13:52:19');
INSERT INTO `user_health` VALUES (19, 2, 6, '2', '2025-04-24 13:52:19');
INSERT INTO `user_health` VALUES (20, 2, 3, '1500', '2025-04-24 13:52:19');
INSERT INTO `user_health` VALUES (21, 2, 2, '47', '2025-04-24 13:52:19');
INSERT INTO `user_health` VALUES (22, 2, 14, '37', '2025-04-27 09:49:38');
INSERT INTO `user_health` VALUES (23, 2, 13, '3.1', '2025-04-27 09:49:38');
INSERT INTO `user_health` VALUES (24, 2, 12, '56', '2025-04-27 09:50:28');
INSERT INTO `user_health` VALUES (25, 2, 14, '36.5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (26, 2, 13, '2.5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (27, 2, 12, '67', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (28, 2, 11, '5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (29, 2, 10, '3600', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (30, 2, 9, '3600', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (31, 2, 8, '77', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (32, 2, 7, '77', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (33, 2, 6, '2', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (34, 2, 5, '7', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (35, 2, 4, '190', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (36, 2, 15, '250', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (37, 2, 14, '36.5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (38, 2, 13, '2.5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (39, 2, 12, '67', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (40, 2, 11, '5', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (41, 2, 10, '3600', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (42, 2, 9, '3600', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (43, 2, 8, '77', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (44, 2, 7, '77', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (45, 2, 6, '2', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (46, 2, 5, '7', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (47, 2, 4, '190', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (48, 2, 15, '250', '2025-04-28 11:18:17');
INSERT INTO `user_health` VALUES (49, 2, 14, '37', '2025-04-28 11:18:28');
INSERT INTO `user_health` VALUES (50, 2, 14, '37.5', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (51, 2, 13, '3.5', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (52, 2, 12, '58', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (53, 2, 11, '5.5', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (54, 2, 10, '4000', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (55, 2, 9, '4233', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (56, 2, 8, '75', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (57, 2, 7, '95', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (58, 2, 6, '2', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (59, 2, 5, '7', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (60, 2, 4, '259', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (61, 2, 3, '2100', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (62, 2, 15, '250', '2025-05-01 18:14:50');
INSERT INTO `user_health` VALUES (63, 2, 2, '47', '2025-05-01 18:15:17');
INSERT INTO `user_health` VALUES (64, 2, 1, '163', '2025-05-01 18:15:17');
INSERT INTO `user_health` VALUES (65, 2, 14, '37', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (66, 2, 13, '4.4', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (67, 2, 12, '57', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (68, 2, 11, '5.2', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (69, 2, 10, '3456', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (70, 2, 9, '6758', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (71, 2, 8, '79', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (72, 2, 7, '78', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (73, 2, 6, '2', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (74, 2, 5, '10', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (75, 2, 4, '268', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (76, 2, 3, '2000', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (77, 2, 2, '48', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (78, 2, 15, '250', '2025-05-02 23:18:48');
INSERT INTO `user_health` VALUES (79, 2, 14, '37.2', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (80, 2, 13, '3', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (81, 2, 12, '67', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (82, 2, 11, '5.2', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (83, 2, 10, '3333', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (84, 2, 9, '4444', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (85, 2, 8, '77', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (86, 2, 7, '78', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (87, 2, 6, '2', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (88, 2, 5, '10', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (89, 2, 4, '260', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (90, 2, 3, '2000', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (91, 2, 2, '48', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (92, 2, 15, '250', '2025-05-03 22:02:31');
INSERT INTO `user_health` VALUES (93, 2, 14, '37', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (94, 2, 13, '2.5', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (95, 2, 12, '65', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (96, 2, 11, '5', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (97, 2, 10, '5555', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (98, 2, 9, '5555', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (99, 2, 8, '78', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (100, 2, 7, '79', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (101, 2, 6, '2', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (102, 2, 5, '6', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (103, 2, 4, '259', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (104, 2, 2, '48', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (105, 2, 1, '163', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (106, 2, 3, '1354', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (107, 2, 15, '250', '2025-05-07 18:06:29');
INSERT INTO `user_health` VALUES (108, 2, 14, '37', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (109, 2, 13, '3', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (110, 2, 12, '56', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (111, 2, 11, '6', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (112, 2, 10, '3300', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (113, 2, 9, '3300', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (114, 2, 8, '79', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (115, 2, 7, '79', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (116, 2, 6, '2', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (117, 2, 5, '8', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (118, 2, 4, '260', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (119, 2, 3, '1223', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (120, 2, 2, '48', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (121, 2, 15, '250', '2025-05-14 15:42:33');
INSERT INTO `user_health` VALUES (122, 2, 14, '36', '2025-05-16 10:53:08');
INSERT INTO `user_health` VALUES (123, 2, 14, '37', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (124, 2, 13, '5', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (125, 2, 12, '59', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (126, 2, 11, '5', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (127, 2, 10, '333', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (128, 2, 4, '267', '2025-05-16 18:51:15');
INSERT INTO `user_health` VALUES (129, 2, 14, '37', '2025-05-16 19:15:24');
INSERT INTO `user_health` VALUES (130, 2, 13, '5', '2025-05-16 19:15:41');
INSERT INTO `user_health` VALUES (131, 2, 12, '59', '2025-05-16 19:15:41');
INSERT INTO `user_health` VALUES (132, 2, 4, '260', '2025-05-16 19:15:41');
INSERT INTO `user_health` VALUES (133, 2, 14, '37', '2025-05-16 19:19:27');
INSERT INTO `user_health` VALUES (134, 2, 12, '59', '2025-05-16 19:19:37');
INSERT INTO `user_health` VALUES (135, 2, 4, '260', '2025-05-16 19:19:37');
INSERT INTO `user_health` VALUES (136, 2, 12, '40', '2025-05-17 08:57:00');
INSERT INTO `user_health` VALUES (137, 2, 4, '260', '2025-05-17 08:57:00');
INSERT INTO `user_health` VALUES (138, 29, 14, '36.8', '2025-06-17 17:38:14');
INSERT INTO `user_health` VALUES (139, 29, 14, '36.8', '2025-06-17 17:38:24');
INSERT INTO `user_health` VALUES (140, 29, 13, '3', '2025-06-17 17:38:24');
INSERT INTO `user_health` VALUES (141, 29, 14, '36.8', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (142, 29, 13, '3', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (143, 29, 12, '120', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (144, 29, 11, '4', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (145, 29, 10, '0', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (146, 29, 9, '0', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (147, 29, 8, '80', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (148, 29, 7, '230', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (149, 29, 6, '1', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (150, 29, 5, '5', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (151, 29, 4, '120', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (152, 29, 3, '500', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (153, 29, 2, '85', '2025-06-17 17:39:15');
INSERT INTO `user_health` VALUES (154, 2, 14, '37', '2025-06-19 20:46:59');
INSERT INTO `user_health` VALUES (155, 2, 20, '50', '2025-06-19 20:54:32');
INSERT INTO `user_health` VALUES (156, 2, 25, '8', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (157, 2, 24, '2000', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (158, 2, 23, '50', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (159, 2, 22, '80', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (160, 2, 21, '10000', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (161, 2, 20, '55', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (162, 2, 14, '37', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (163, 2, 13, '3', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (164, 2, 12, '88', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (165, 2, 11, '5', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (166, 2, 10, '6666', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (167, 2, 9, '54242', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (168, 2, 8, '150', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (169, 2, 7, '200', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (170, 2, 6, '1', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (171, 2, 5, '8', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (172, 2, 4, '200', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (173, 2, 3, '2000', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (174, 2, 2, '50', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (175, 2, 1, '185', '2025-06-19 22:22:35');
INSERT INTO `user_health` VALUES (176, 2, 23, '30', '2025-06-20 09:23:50');
INSERT INTO `user_health` VALUES (177, 2, 24, '2000', '2025-06-20 09:23:50');
INSERT INTO `user_health` VALUES (178, 2, 21, '20000', '2025-06-20 09:23:50');
INSERT INTO `user_health` VALUES (179, 2, 20, '50', '2025-06-20 09:36:23');
INSERT INTO `user_health` VALUES (180, 2, 25, '8', '2025-06-20 09:39:45');
INSERT INTO `user_health` VALUES (181, 2, 25, '8', '2025-06-20 09:39:52');
INSERT INTO `user_health` VALUES (182, 2, 24, '2000', '2025-06-20 09:39:52');
INSERT INTO `user_health` VALUES (183, 2, 25, '8', '2025-06-20 09:39:58');
INSERT INTO `user_health` VALUES (184, 2, 24, '2000', '2025-06-20 09:39:58');
INSERT INTO `user_health` VALUES (185, 2, 23, '50', '2025-06-20 09:39:58');
INSERT INTO `user_health` VALUES (186, 2, 25, '8', '2025-06-20 09:40:03');
INSERT INTO `user_health` VALUES (187, 2, 24, '2000', '2025-06-20 09:40:03');
INSERT INTO `user_health` VALUES (188, 2, 23, '50', '2025-06-20 09:40:03');
INSERT INTO `user_health` VALUES (189, 2, 22, '88', '2025-06-20 09:40:03');
INSERT INTO `user_health` VALUES (190, 2, 25, '8', '2025-06-20 09:40:09');
INSERT INTO `user_health` VALUES (191, 2, 24, '2000', '2025-06-20 09:40:09');
INSERT INTO `user_health` VALUES (192, 2, 23, '50', '2025-06-20 09:40:09');
INSERT INTO `user_health` VALUES (193, 2, 22, '88', '2025-06-20 09:40:09');
INSERT INTO `user_health` VALUES (194, 2, 21, '8000', '2025-06-20 09:40:09');
INSERT INTO `user_health` VALUES (195, 2, 25, '8', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (196, 2, 24, '2000', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (197, 2, 23, '50', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (198, 2, 22, '88', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (199, 2, 21, '8000', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (200, 2, 20, '50', '2025-06-20 09:40:13');
INSERT INTO `user_health` VALUES (201, 2, 25, '8', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (202, 2, 24, '2000', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (203, 2, 23, '50', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (204, 2, 22, '88', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (205, 2, 21, '8000', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (206, 2, 20, '50', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (207, 2, 14, '37.8', '2025-06-20 09:40:19');
INSERT INTO `user_health` VALUES (208, 2, 25, '8', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (209, 2, 24, '2000', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (210, 2, 23, '50', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (211, 2, 22, '88', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (212, 2, 21, '8000', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (213, 2, 20, '50', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (214, 2, 14, '37.8', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (215, 2, 13, '3', '2025-06-20 09:40:23');
INSERT INTO `user_health` VALUES (216, 2, 25, '8', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (217, 2, 24, '2000', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (218, 2, 23, '50', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (219, 2, 22, '88', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (220, 2, 21, '8000', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (221, 2, 20, '50', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (222, 2, 14, '37.8', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (223, 2, 13, '3', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (224, 2, 12, '88', '2025-06-20 09:40:27');
INSERT INTO `user_health` VALUES (225, 2, 25, '8', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (226, 2, 24, '2000', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (227, 2, 23, '50', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (228, 2, 22, '88', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (229, 2, 21, '8000', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (230, 2, 20, '50', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (231, 2, 14, '37.8', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (232, 2, 13, '3', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (233, 2, 12, '88', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (234, 2, 11, '5', '2025-06-20 09:40:31');
INSERT INTO `user_health` VALUES (235, 2, 25, '8', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (236, 2, 24, '2000', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (237, 2, 23, '50', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (238, 2, 22, '88', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (239, 2, 21, '8000', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (240, 2, 20, '50', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (241, 2, 14, '37.8', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (242, 2, 13, '3', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (243, 2, 12, '88', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (244, 2, 11, '5', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (245, 2, 10, '2000', '2025-06-20 09:40:35');
INSERT INTO `user_health` VALUES (246, 2, 25, '8', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (247, 2, 24, '2000', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (248, 2, 23, '50', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (249, 2, 22, '88', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (250, 2, 21, '8000', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (251, 2, 20, '50', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (252, 2, 14, '37.8', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (253, 2, 13, '3', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (254, 2, 12, '88', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (255, 2, 11, '5', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (256, 2, 10, '2000', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (257, 2, 9, '2000', '2025-06-20 09:40:39');
INSERT INTO `user_health` VALUES (258, 2, 25, '8', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (259, 2, 24, '2000', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (260, 2, 23, '50', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (261, 2, 22, '88', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (262, 2, 21, '8000', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (263, 2, 20, '50', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (264, 2, 14, '37.8', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (265, 2, 13, '3', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (266, 2, 12, '88', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (267, 2, 11, '5', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (268, 2, 10, '2000', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (269, 2, 9, '2000', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (270, 2, 8, '88', '2025-06-20 09:40:44');
INSERT INTO `user_health` VALUES (271, 2, 25, '8', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (272, 2, 24, '2000', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (273, 2, 23, '50', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (274, 2, 22, '88', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (275, 2, 21, '8000', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (276, 2, 20, '50', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (277, 2, 14, '37.8', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (278, 2, 13, '3', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (279, 2, 12, '88', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (280, 2, 11, '5', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (281, 2, 10, '2000', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (282, 2, 9, '2000', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (283, 2, 8, '88', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (284, 2, 7, '200', '2025-06-20 09:40:50');
INSERT INTO `user_health` VALUES (285, 2, 25, '8', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (286, 2, 24, '2000', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (287, 2, 23, '50', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (288, 2, 22, '88', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (289, 2, 21, '8000', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (290, 2, 20, '50', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (291, 2, 14, '37.8', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (292, 2, 13, '3', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (293, 2, 12, '88', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (294, 2, 11, '5', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (295, 2, 10, '2000', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (296, 2, 9, '2000', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (297, 2, 8, '88', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (298, 2, 7, '200', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (299, 2, 6, '1', '2025-06-20 09:40:54');
INSERT INTO `user_health` VALUES (300, 2, 25, '8', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (301, 2, 24, '2000', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (302, 2, 23, '50', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (303, 2, 22, '88', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (304, 2, 21, '8000', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (305, 2, 20, '50', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (306, 2, 14, '37.8', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (307, 2, 13, '3', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (308, 2, 12, '88', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (309, 2, 11, '5', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (310, 2, 10, '2000', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (311, 2, 9, '2000', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (312, 2, 8, '88', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (313, 2, 7, '200', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (314, 2, 6, '1', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (315, 2, 5, '8', '2025-06-20 09:40:59');
INSERT INTO `user_health` VALUES (316, 2, 25, '8', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (317, 2, 24, '2000', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (318, 2, 23, '50', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (319, 2, 22, '88', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (320, 2, 21, '8000', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (321, 2, 20, '50', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (322, 2, 14, '37.8', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (323, 2, 13, '3', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (324, 2, 12, '88', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (325, 2, 11, '5', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (326, 2, 10, '2000', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (327, 2, 9, '2000', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (328, 2, 8, '88', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (329, 2, 7, '200', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (330, 2, 6, '1', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (331, 2, 5, '8', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (332, 2, 4, '200', '2025-06-20 09:41:04');
INSERT INTO `user_health` VALUES (333, 2, 25, '8', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (334, 2, 24, '2000', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (335, 2, 23, '50', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (336, 2, 22, '88', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (337, 2, 21, '8000', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (338, 2, 20, '50', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (339, 2, 14, '37.8', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (340, 2, 13, '3', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (341, 2, 12, '88', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (342, 2, 11, '5', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (343, 2, 10, '2000', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (344, 2, 9, '2000', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (345, 2, 8, '88', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (346, 2, 7, '200', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (347, 2, 6, '1', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (348, 2, 5, '8', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (349, 2, 4, '200', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (350, 2, 3, '1500', '2025-06-20 09:41:10');
INSERT INTO `user_health` VALUES (351, 2, 25, '8', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (352, 2, 24, '2000', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (353, 2, 23, '50', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (354, 2, 22, '88', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (355, 2, 21, '8000', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (356, 2, 20, '50', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (357, 2, 14, '37.8', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (358, 2, 13, '3', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (359, 2, 12, '88', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (360, 2, 11, '5', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (361, 2, 10, '2000', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (362, 2, 9, '2000', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (363, 2, 8, '88', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (364, 2, 7, '200', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (365, 2, 6, '1', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (366, 2, 5, '8', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (367, 2, 4, '200', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (368, 2, 3, '1500', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (369, 2, 2, '50', '2025-06-20 09:41:15');
INSERT INTO `user_health` VALUES (370, 2, 25, '8', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (371, 2, 24, '2000', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (372, 2, 23, '50', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (373, 2, 22, '88', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (374, 2, 21, '8000', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (375, 2, 20, '50', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (376, 2, 14, '37.8', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (377, 2, 13, '3', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (378, 2, 12, '88', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (379, 2, 11, '5', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (380, 2, 10, '2000', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (381, 2, 9, '2000', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (382, 2, 8, '88', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (383, 2, 7, '200', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (384, 2, 6, '1', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (385, 2, 5, '8', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (386, 2, 4, '200', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (387, 2, 3, '1500', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (388, 2, 2, '50', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (389, 2, 1, '173', '2025-06-20 09:41:21');
INSERT INTO `user_health` VALUES (390, 2, 25, '8', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (391, 2, 24, '2000', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (392, 2, 23, '50', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (393, 2, 22, '88', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (394, 2, 21, '8000', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (395, 2, 20, '50', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (396, 2, 14, '37.8', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (397, 2, 13, '3', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (398, 2, 12, '88', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (399, 2, 11, '5', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (400, 2, 10, '2000', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (401, 2, 9, '2000', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (402, 2, 8, '88', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (403, 2, 7, '200', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (404, 2, 6, '1', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (405, 2, 5, '8', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (406, 2, 4, '200', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (407, 2, 3, '1500', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (408, 2, 2, '50', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (409, 2, 1, '173', '2025-06-20 09:41:23');
INSERT INTO `user_health` VALUES (410, 2, 25, '8', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (411, 2, 24, '2000', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (412, 2, 23, '50', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (413, 2, 22, '88', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (414, 2, 21, '8000', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (415, 2, 20, '50', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (416, 2, 14, '37.8', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (417, 2, 13, '3', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (418, 2, 12, '88', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (419, 2, 11, '5', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (420, 2, 10, '2000', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (421, 2, 9, '2000', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (422, 2, 8, '88', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (423, 2, 7, '200', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (424, 2, 6, '1', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (425, 2, 5, '8', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (426, 2, 4, '200', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (427, 2, 3, '1500', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (428, 2, 2, '50', '2025-06-20 09:41:29');
INSERT INTO `user_health` VALUES (429, 2, 1, '173', '2025-06-20 09:41:29');

SET FOREIGN_KEY_CHECKS = 1;
