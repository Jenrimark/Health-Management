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

 Date: 25/06/2025 04:02:15
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
-- Table structure for cookbook
-- ----------------------------
DROP TABLE IF EXISTS `cookbook`;
CREATE TABLE `cookbook`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '食谱ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `category_id` int NULL DEFAULT NULL COMMENT '所属分类ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否是公开食谱',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cookbook_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_cookbook_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_cookbook_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_cookbook_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '食谱信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cookbook_nutriment
-- ----------------------------
DROP TABLE IF EXISTS `cookbook_nutriment`;
CREATE TABLE `cookbook_nutriment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '食谱营养素关联信息主键ID',
  `cookbook_id` int NULL DEFAULT NULL COMMENT '食谱ID',
  `nutriment_id` int NULL DEFAULT NULL COMMENT '营养素ID',
  `100g_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '每100g食物中含量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cookbook_nutriment_cookbook_id`(`cookbook_id` ASC) USING BTREE,
  INDEX `fk_cookbook_nutriment_nutriment_id`(`nutriment_id` ASC) USING BTREE,
  CONSTRAINT `fk_cookbook_nutriment_cookbook_id` FOREIGN KEY (`cookbook_id`) REFERENCES `cookbook` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cookbook_nutriment_nutriment_id` FOREIGN KEY (`nutriment_id`) REFERENCES `nutriment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '食谱营养素关联信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for diet_history
-- ----------------------------
DROP TABLE IF EXISTS `diet_history`;
CREATE TABLE `diet_history`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户饮食主键ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `cookbook_id` int NULL DEFAULT NULL COMMENT '食谱ID',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '记录的值',
  `create_time` datetime NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_diet_history_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_diet_history_cookbook_id`(`cookbook_id` ASC) USING BTREE,
  CONSTRAINT `fk_diet_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_diet_history_cookbook_id` FOREIGN KEY (`cookbook_id`) REFERENCES `cookbook` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户饮食信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for evaluations
-- ----------------------------
DROP TABLE IF EXISTS `evaluations`;
CREATE TABLE `evaluations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int UNSIGNED NULL DEFAULT NULL COMMENT '父级评论ID',
  `commenter_id` int UNSIGNED NULL DEFAULT NULL COMMENT '评论者ID',
  `replier_id` int UNSIGNED NULL DEFAULT NULL COMMENT '回复者ID',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型',
  `content_id` int NULL DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '评论内容',
  `upvote_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '点赞列表，以\",\"分割',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_evaluations_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `fk_evaluations_commenter_id`(`commenter_id` ASC) USING BTREE,
  INDEX `fk_evaluations_replier_id`(`replier_id` ASC) USING BTREE,
  CONSTRAINT `fk_evaluations_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `evaluations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_evaluations_commenter_id` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_evaluations_replier_id` FOREIGN KEY (`replier_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for evaluations_upvote
-- ----------------------------
DROP TABLE IF EXISTS `evaluations_upvote`;
CREATE TABLE `evaluations_upvote`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论点赞表ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `evaluations_id` int UNSIGNED NULL DEFAULT NULL COMMENT '点赞ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_evaluations_upvote_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_evaluations_upvote_evaluations_id`(`evaluations_id` ASC) USING BTREE,
  CONSTRAINT `fk_evaluations_upvote_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_evaluations_upvote_evaluations_id` FOREIGN KEY (`evaluations_id`) REFERENCES `evaluations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for family_relationship
-- ----------------------------
DROP TABLE IF EXISTS `family_relationship`;
CREATE TABLE `family_relationship`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `user_id` int UNSIGNED NOT NULL COMMENT '用户ID',
  `related_user_id` int UNSIGNED NOT NULL COMMENT '关联用户ID',
  `relationship_type` tinyint NOT NULL COMMENT '关系类型(1:父母,2:子女,3:配偶,4:兄弟姐妹,5:祖父母,6:孙子女,7:其他)',
  `permission_level` tinyint NOT NULL DEFAULT 1 COMMENT '权限级别(1:只读查看,2:可编辑,3:完全管理)',
  `data_access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1,2,3' COMMENT '可访问的数据类型(1:健康指标,2:饮食记录,3:运动记录,4:药物记录,多个以逗号分隔)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态(0:已删除,1:正常)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_related`(`user_id` ASC, `related_user_id` ASC) USING BTREE COMMENT '用户关系唯一约束',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_related_user_id`(`related_user_id` ASC) USING BTREE,
  CONSTRAINT `fk_family_relationship_related_user_id` FOREIGN KEY (`related_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_family_relationship_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '家庭关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family_relationship
-- ----------------------------

-- ----------------------------
-- Table structure for gourmet
-- ----------------------------
DROP TABLE IF EXISTS `gourmet`;
CREATE TABLE `gourmet`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '美食表主键ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `is_audit` tinyint(1) NULL DEFAULT NULL COMMENT '是否已经审核',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否公开',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_gourmet_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_gourmet_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_gourmet_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_gourmet_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '美食做法表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for health_model_config
-- ----------------------------
DROP TABLE IF EXISTS `health_model_config`;
CREATE TABLE `health_model_config`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '健康模型自增主键',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置名',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置图标',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置单位',
  `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配置符号',
  `is_global` tinyint(1) NULL DEFAULT NULL COMMENT '是否是全局模型',
  `value_range` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '正常值范围',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_health_model_config_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_health_model_config_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '健康模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for health_plan
-- ----------------------------
DROP TABLE IF EXISTS `health_plan`;
CREATE TABLE `health_plan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_date` date NOT NULL,
  `steps` int NULL DEFAULT NULL,
  `exercise_minutes` int NOT NULL,
  `exercise_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '运动方式',
  `calories_burned` int NULL DEFAULT NULL COMMENT '消耗热量',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_health_plan_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 496129 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for healthy_report
-- ----------------------------
DROP TABLE IF EXISTS `healthy_report`;
CREATE TABLE `healthy_report`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `file_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件类型',
  `file_size` bigint NOT NULL COMMENT '文件大小(字节)',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报告描述',
  `report_date` date NULL DEFAULT NULL COMMENT '体检日期',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除(0-未删除,1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_account`(`user_account` ASC) USING BTREE,
  INDEX `idx_upload_time`(`upload_time` ASC) USING BTREE,
  INDEX `idx_report_date`(`report_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户体检报告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of healthy_report
-- ----------------------------

-- ----------------------------
-- Table structure for interaction
-- ----------------------------
DROP TABLE IF EXISTS `interaction`;
CREATE TABLE `interaction`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '互动表主键ID',
  `type` int NULL DEFAULT NULL COMMENT '互动类型（1：点赞；2：收藏；3：浏览；4：评分）',
  `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型，表示的就是互动属于哪一个模块的东西',
  `content_id` int NULL DEFAULT NULL COMMENT '内容ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `score` int NULL DEFAULT NULL COMMENT '评分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '互动时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_interaction_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_interaction_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '互动信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息表的自增主键ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '消息内容（消息体）',
  `message_type` int NULL DEFAULT NULL COMMENT '消息类型（指标数据、互动、系统消息...）',
  `receiver_id` int UNSIGNED NULL DEFAULT NULL COMMENT '接收者ID',
  `sender_id` int UNSIGNED NULL DEFAULT NULL COMMENT '发送者ID',
  `is_read` tinyint(1) NULL DEFAULT NULL COMMENT '消息是否已经阅读',
  `content_id` int NULL DEFAULT NULL COMMENT '关联的内容ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '消息的发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_message_receiver_id`(`receiver_id` ASC) USING BTREE,
  INDEX `fk_message_sender_id`(`sender_id` ASC) USING BTREE,
  CONSTRAINT `fk_message_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_message_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for nutriment
-- ----------------------------
DROP TABLE IF EXISTS `nutriment`;
CREATE TABLE `nutriment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '营养素主键ID',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '名称',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '描述',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '单位',
  `is_publish` tinyint(1) NULL DEFAULT NULL COMMENT '是否公开',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_nutriment_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_nutriment_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '营养素信息表' ROW_FORMAT = DYNAMIC;

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
  INDEX `idx_region_season`(`region_id` ASC, `season_id` ASC) USING BTREE,
  CONSTRAINT `fk_recipe_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_season_id` FOREIGN KEY (`season_id`) REFERENCES `season` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食谱表' ROW_FORMAT = DYNAMIC;

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
-- Table structure for relationship_request
-- ----------------------------
DROP TABLE IF EXISTS `relationship_request`;
CREATE TABLE `relationship_request`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求ID',
  `sender_id` int UNSIGNED NOT NULL COMMENT '发送者ID',
  `receiver_id` int UNSIGNED NOT NULL COMMENT '接收者ID',
  `relationship_type` tinyint NOT NULL COMMENT '关系类型(1:父母,2:子女,3:配偶,4:兄弟姐妹,5:祖父母,6:孙子女,7:其他)',
  `permission_level` tinyint NOT NULL DEFAULT 1 COMMENT '请求的权限级别(1:只读查看,2:可编辑,3:完全管理)',
  `data_access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1,2,3' COMMENT '请求访问的数据类型(1:健康指标,2:饮食记录,3:运动记录,4:药物记录,多个以逗号分隔)',
  `request_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求消息',
  `request_status` tinyint NOT NULL DEFAULT 0 COMMENT '请求状态(0:待处理,1:已接受,2:已拒绝)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_receiver_id`(`receiver_id` ASC) USING BTREE,
  INDEX `idx_status`(`request_status` ASC) USING BTREE,
  CONSTRAINT `fk_relationship_request_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_request_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '关系请求表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of relationship_request
-- ----------------------------

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
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标签分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '标签分类表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_health
-- ----------------------------
DROP TABLE IF EXISTS `user_health`;
CREATE TABLE `user_health`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户健康记录主键',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `health_model_config_id` int UNSIGNED NULL DEFAULT NULL COMMENT '健康模型ID',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '输入的值',
  `create_time` datetime NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_health_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_user_health_health_model_config_id`(`health_model_config_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_health_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_health_health_model_config_id` FOREIGN KEY (`health_model_config_id`) REFERENCES `health_model_config` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 447 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户健康记录表' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- 视图定义
-- ----------------------------

-- 用户健康数据统计视图
DROP VIEW IF EXISTS `v_user_health_stats`;
CREATE VIEW `v_user_health_stats` AS
SELECT 
    u.id AS user_id, 
    u.user_name,
    hmc.name AS health_metric,
    hmc.unit,
    COUNT(uh.id) AS record_count,
    MIN(uh.value) AS min_value,
    MAX(uh.value) AS max_value,
    AVG(CAST(uh.value AS DECIMAL(10,2))) AS avg_value,
    MAX(uh.create_time) AS last_record_time
FROM 
    user u
JOIN 
    user_health uh ON u.id = uh.user_id
JOIN 
    health_model_config hmc ON uh.health_model_config_id = hmc.id
GROUP BY 
    u.id, hmc.id;

-- 食谱营养成分视图
DROP VIEW IF EXISTS `v_cookbook_nutrition`;
CREATE VIEW `v_cookbook_nutrition` AS
SELECT 
    c.id AS cookbook_id,
    c.title AS cookbook_title,
    c.user_id,
    u.user_name AS creator_name,
    cat.name AS category_name,
    n.id AS nutriment_id,
    n.name AS nutriment_name,
    n.unit AS nutriment_unit,
    cn.`100g_value`
FROM 
    cookbook c
JOIN 
    user u ON c.user_id = u.id
LEFT JOIN 
    category cat ON c.category_id = cat.id
LEFT JOIN 
    cookbook_nutriment cn ON c.id = cn.cookbook_id
LEFT JOIN 
    nutriment n ON cn.nutriment_id = n.id;

-- 用户饮食历史视图
DROP VIEW IF EXISTS `v_user_diet_history`;
CREATE VIEW `v_user_diet_history` AS
SELECT 
    dh.id,
    dh.user_id,
    u.user_name,
    dh.cookbook_id,
    c.title AS cookbook_title,
    c.category_id,
    cat.name AS category_name,
    dh.value,
    dh.detail,
    dh.create_time
FROM 
    diet_history dh
JOIN 
    user u ON dh.user_id = u.id
LEFT JOIN 
    cookbook c ON dh.cookbook_id = c.id
LEFT JOIN 
    category cat ON c.category_id = cat.id
ORDER BY 
    dh.create_time DESC;

-- 评论互动统计视图
DROP VIEW IF EXISTS `v_content_interaction_stats`;
CREATE VIEW `v_content_interaction_stats` AS
SELECT 
    i.content_type,
    i.content_id,
    COUNT(DISTINCT CASE WHEN i.type = 1 THEN i.user_id END) AS like_count,
    COUNT(DISTINCT CASE WHEN i.type = 2 THEN i.user_id END) AS favorite_count,
    COUNT(DISTINCT CASE WHEN i.type = 3 THEN i.user_id END) AS view_count,
    AVG(CASE WHEN i.type = 4 THEN i.score ELSE NULL END) AS avg_score,
    COUNT(DISTINCT e.id) AS comment_count
FROM 
    interaction i
LEFT JOIN 
    evaluations e ON i.content_type = e.content_type AND i.content_id = e.content_id
GROUP BY 
    i.content_type, i.content_id;

-- 家庭成员健康视图
DROP VIEW IF EXISTS `v_family_health`;
CREATE VIEW `v_family_health` AS
SELECT 
    fr.user_id,
    u1.user_name AS user_name,
    fr.related_user_id,
    u2.user_name AS related_user_name,
    fr.relationship_type,
    fr.permission_level,
    hmc.id AS health_model_config_id,
    hmc.name AS health_metric,
    uh.value,
    uh.create_time
FROM 
    family_relationship fr
JOIN 
    user u1 ON fr.user_id = u1.id
JOIN 
    user u2 ON fr.related_user_id = u2.id
JOIN 
    user_health uh ON fr.related_user_id = uh.user_id
JOIN 
    health_model_config hmc ON uh.health_model_config_id = hmc.id
WHERE 
    fr.status = 1
    AND FIND_IN_SET('1', fr.data_access) > 0;

-- ----------------------------
-- 存储过程定义
-- ----------------------------

-- 添加或更新用户健康记录
DELIMITER $$
CREATE PROCEDURE `p_add_update_health_record`(
    IN p_user_id INT UNSIGNED,
    IN p_health_model_config_id INT UNSIGNED,
    IN p_value VARCHAR(255),
    OUT p_result INT
)
BEGIN
    DECLARE v_last_record_id INT UNSIGNED;
    DECLARE v_last_record_value VARCHAR(255);
    DECLARE v_normal_range VARCHAR(255);
    DECLARE v_is_abnormal BOOLEAN DEFAULT FALSE;
    
    -- 获取正常值范围
    SELECT value_range INTO v_normal_range 
    FROM health_model_config 
    WHERE id = p_health_model_config_id;
    
    -- 检查是否有异常值
    IF v_normal_range IS NOT NULL THEN
        -- 假设格式为"min-max"
        SET v_is_abnormal = (
            CAST(p_value AS DECIMAL(10,2)) < CAST(SUBSTRING_INDEX(v_normal_range, '-', 1) AS DECIMAL(10,2)) OR
            CAST(p_value AS DECIMAL(10,2)) > CAST(SUBSTRING_INDEX(v_normal_range, '-', -1) AS DECIMAL(10,2))
        );
    END IF;
    
    -- 插入新记录
    INSERT INTO user_health (user_id, health_model_config_id, value, create_time)
    VALUES (p_user_id, p_health_model_config_id, p_value, NOW());
    
    SET p_result = LAST_INSERT_ID();
    
    -- 如果值异常，创建系统通知
    IF v_is_abnormal THEN
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        VALUES (CONCAT('您的健康指标出现异常值：', p_value), 1, p_user_id, NULL, 0, p_result, NOW());
    END IF;
END$$
DELIMITER ;

-- 创建食谱及其营养成分
DELIMITER $$
CREATE PROCEDURE `p_create_cookbook_with_nutrients`(
    IN p_user_id INT UNSIGNED,
    IN p_title VARCHAR(255),
    IN p_category_id INT,
    IN p_content LONGTEXT,
    IN p_cover VARCHAR(255),
    IN p_is_publish TINYINT(1),
    IN p_nutrients JSON,
    OUT p_cookbook_id INT
)
BEGIN
    DECLARE v_nutrient_id INT;
    DECLARE v_value VARCHAR(255);
    DECLARE i INT DEFAULT 0;
    DECLARE v_nutrient_count INT;
    
    -- 创建食谱
    INSERT INTO cookbook (user_id, title, category_id, content, cover, is_publish, create_time)
    VALUES (p_user_id, p_title, p_category_id, p_content, p_cover, p_is_publish, NOW());
    
    SET p_cookbook_id = LAST_INSERT_ID();
    
    -- 添加营养成分
    IF p_nutrients IS NOT NULL THEN
        SET v_nutrient_count = JSON_LENGTH(p_nutrients);
        
        WHILE i < v_nutrient_count DO
            SET v_nutrient_id = JSON_EXTRACT(p_nutrients, CONCAT('$[', i, '].id'));
            SET v_value = JSON_UNQUOTE(JSON_EXTRACT(p_nutrients, CONCAT('$[', i, '].value')));
            
            INSERT INTO cookbook_nutriment (cookbook_id, nutriment_id, `100g_value`)
            VALUES (p_cookbook_id, v_nutrient_id, v_value);
            
            SET i = i + 1;
        END WHILE;
    END IF;
END$$
DELIMITER ;

-- 处理关系请求
DELIMITER $$
CREATE PROCEDURE `p_process_relationship_request`(
    IN p_request_id INT UNSIGNED,
    IN p_status TINYINT,
    OUT p_result VARCHAR(50)
)
BEGIN
    DECLARE v_sender_id INT UNSIGNED;
    DECLARE v_receiver_id INT UNSIGNED;
    DECLARE v_relationship_type TINYINT;
    DECLARE v_permission_level TINYINT;
    DECLARE v_data_access VARCHAR(255);
    DECLARE v_current_status TINYINT;
    
    -- 获取请求信息
    SELECT sender_id, receiver_id, relationship_type, permission_level, data_access, request_status
    INTO v_sender_id, v_receiver_id, v_relationship_type, v_permission_level, v_data_access, v_current_status
    FROM relationship_request
    WHERE id = p_request_id;
    
    -- 检查是否存在及状态
    IF v_current_status IS NULL THEN
        SET p_result = 'REQUEST_NOT_FOUND';
    ELSEIF v_current_status != 0 THEN
        SET p_result = 'REQUEST_ALREADY_PROCESSED';
    ELSE
        -- 更新请求状态
        UPDATE relationship_request
        SET request_status = p_status, update_time = NOW()
        WHERE id = p_request_id;
        
        -- 如果接受请求，创建关系
        IF p_status = 1 THEN
            -- 创建正向关系
            INSERT INTO family_relationship (user_id, related_user_id, relationship_type, permission_level, data_access, create_time, update_time, status)
            VALUES (v_sender_id, v_receiver_id, v_relationship_type, v_permission_level, v_data_access, NOW(), NOW(), 1);
            
            -- 创建反向关系（根据关系类型自动确定反向关系类型）
            INSERT INTO family_relationship (user_id, related_user_id, relationship_type, permission_level, data_access, create_time, update_time, status)
            VALUES (v_receiver_id, v_sender_id, 
                CASE 
                    WHEN v_relationship_type = 1 THEN 2 -- 父母->子女
                    WHEN v_relationship_type = 2 THEN 1 -- 子女->父母
                    WHEN v_relationship_type = 3 THEN 3 -- 配偶->配偶
                    WHEN v_relationship_type = 4 THEN 4 -- 兄弟姐妹->兄弟姐妹
                    WHEN v_relationship_type = 5 THEN 6 -- 祖父母->孙子女
                    WHEN v_relationship_type = 6 THEN 5 -- 孙子女->祖父母
                    ELSE 7 -- 其他->其他
                END, 
                v_permission_level, v_data_access, NOW(), NOW(), 1);
            
            SET p_result = 'REQUEST_ACCEPTED';
        ELSE
            SET p_result = 'REQUEST_REJECTED';
        END IF;
        
        -- 创建系统通知
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        VALUES (
            CASE 
                WHEN p_status = 1 THEN '您的家庭关系请求已被接受'
                ELSE '您的家庭关系请求已被拒绝'
            END,
            2, -- 关系消息类型
            v_sender_id, -- 发送给请求者
            NULL, -- 系统消息
            0, -- 未读
            p_request_id, -- 关联请求ID
            NOW()
        );
    END IF;
END$$
DELIMITER ;

-- 添加用户饮食记录并分析营养
DELIMITER $$
CREATE PROCEDURE `p_add_diet_record`(
    IN p_user_id INT UNSIGNED,
    IN p_cookbook_id INT,
    IN p_value VARCHAR(255),
    IN p_detail VARCHAR(255),
    OUT p_nutrient_summary JSON
)
BEGIN
    DECLARE v_nutrient_data JSON DEFAULT '[]';
    
    -- 记录饮食历史
    INSERT INTO diet_history (user_id, cookbook_id, value, detail, create_time)
    VALUES (p_user_id, p_cookbook_id, p_value, p_detail, NOW());
    
    -- 获取食谱的营养素信息
    SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
            'nutriment_id', cn.nutriment_id,
            'name', n.name,
            'value', cn.`100g_value`,
            'unit', n.unit
        )
    ) INTO v_nutrient_data
    FROM cookbook_nutriment cn
    JOIN nutriment n ON cn.nutriment_id = n.id
    WHERE cn.cookbook_id = p_cookbook_id;
    
    -- 如果有值信息，计算实际摄入量
    IF p_value IS NOT NULL AND p_value REGEXP '^[0-9]+(\.[0-9]+)?$' AND v_nutrient_data IS NOT NULL THEN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'nutriment_id', JSON_EXTRACT(nutrient, '$.nutriment_id'),
                'name', JSON_EXTRACT(nutrient, '$.name'),
                'value', ROUND(CAST(p_value AS DECIMAL(10,2)) * CAST(JSON_UNQUOTE(JSON_EXTRACT(nutrient, '$.value')) AS DECIMAL(10,2)) / 100, 2),
                'unit', JSON_EXTRACT(nutrient, '$.unit')
            )
        ) INTO p_nutrient_summary
        FROM JSON_TABLE(
            v_nutrient_data,
            "$[*]" COLUMNS(
                nutrient JSON PATH "$"
            )
        ) AS nutrients;
    ELSE
        SET p_nutrient_summary = v_nutrient_data;
    END IF;
END$$
DELIMITER ;

-- 生成用户健康报告
DELIMITER $$
CREATE PROCEDURE `p_generate_health_report`(
    IN p_user_id INT UNSIGNED,
    IN p_start_date DATE,
    IN p_end_date DATE,
    OUT p_report JSON
)
BEGIN
    DECLARE v_health_data JSON;
    DECLARE v_diet_data JSON;
    
    -- 获取健康数据
    SELECT JSON_OBJECTAGG(
        hmc.name,
        JSON_OBJECT(
            'records', JSON_ARRAYAGG(
                JSON_OBJECT(
                    'value', uh.value,
                    'date', DATE_FORMAT(uh.create_time, '%Y-%m-%d'),
                    'time', DATE_FORMAT(uh.create_time, '%H:%i:%s')
                )
            ),
            'unit', hmc.unit,
            'min', MIN(CAST(uh.value AS DECIMAL(10,2))),
            'max', MAX(CAST(uh.value AS DECIMAL(10,2))),
            'avg', AVG(CAST(uh.value AS DECIMAL(10,2))),
            'normal_range', hmc.value_range
        )
    ) INTO v_health_data
    FROM user_health uh
    JOIN health_model_config hmc ON uh.health_model_config_id = hmc.id
    WHERE uh.user_id = p_user_id
      AND uh.create_time BETWEEN p_start_date AND p_end_date
    GROUP BY hmc.id;
    
    -- 获取饮食数据
    SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
            'date', DATE_FORMAT(dh.create_time, '%Y-%m-%d'),
            'cookbook', c.title,
            'category', cat.name,
            'amount', dh.value,
            'detail', dh.detail
        )
    ) INTO v_diet_data
    FROM diet_history dh
    LEFT JOIN cookbook c ON dh.cookbook_id = c.id
    LEFT JOIN category cat ON c.category_id = cat.id
    WHERE dh.user_id = p_user_id
      AND dh.create_time BETWEEN p_start_date AND p_end_date;
    
    -- 组合报告
    SET p_report = JSON_OBJECT(
        'user_id', p_user_id,
        'period', JSON_OBJECT(
            'start', p_start_date,
            'end', p_end_date
        ),
        'health_data', IFNULL(v_health_data, JSON_OBJECT()),
        'diet_data', IFNULL(v_diet_data, JSON_ARRAY()),
        'generated_at', NOW()
    );
END$$
DELIMITER ;

-- ----------------------------
-- 触发器定义
-- ----------------------------

-- 健康数据异常检测触发器
DELIMITER $$
CREATE TRIGGER `trg_health_data_check`
BEFORE INSERT ON `user_health`
FOR EACH ROW
BEGIN
    DECLARE v_normal_range VARCHAR(255);
    DECLARE v_min DECIMAL(10,2);
    DECLARE v_max DECIMAL(10,2);
    DECLARE v_metric_name VARCHAR(255);
    
    -- 获取正常值范围和度量名称
    SELECT value_range, name INTO v_normal_range, v_metric_name
    FROM health_model_config 
    WHERE id = NEW.health_model_config_id;
    
    -- 如果有值范围，检查是否异常
    IF v_normal_range IS NOT NULL AND v_normal_range LIKE '%-%' THEN
        SET v_min = CAST(SUBSTRING_INDEX(v_normal_range, '-', 1) AS DECIMAL(10,2));
        SET v_max = CAST(SUBSTRING_INDEX(v_normal_range, '-', -1) AS DECIMAL(10,2));
        
        -- 如果数值异常且是有效数字，创建系统通知
        IF NEW.value REGEXP '^[0-9]+(\.[0-9]+)?$' AND (CAST(NEW.value AS DECIMAL(10,2)) < v_min OR CAST(NEW.value AS DECIMAL(10,2)) > v_max) THEN
            INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
            VALUES (CONCAT('警告：您的', v_metric_name, '数值(', NEW.value, ')超出正常范围(', v_normal_range, ')'), 1, NEW.user_id, NULL, 0, NULL, NOW());
        END IF;
    END IF;
END$$
DELIMITER ;

-- 评论计数更新触发器
DELIMITER $$
CREATE TRIGGER `trg_evaluation_count_update`
AFTER INSERT ON `evaluations`
FOR EACH ROW
BEGIN
    -- 只处理顶层评论（非回复）
    IF NEW.parent_id IS NULL THEN
        -- 创建或更新互动统计
        INSERT INTO interaction (type, content_type, content_id, user_id, create_time)
        VALUES (5, NEW.content_type, NEW.content_id, NEW.commenter_id, NOW())
        ON DUPLICATE KEY UPDATE create_time = NOW();
    END IF;
    
    -- 向被评论用户发送通知（如果内容与用户关联）
    IF NEW.content_type = 'cookbook' THEN
        -- 查找食谱作者
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        SELECT 
            CONCAT('您的食谱"', c.title, '"收到了新评论'), 
            3, -- 评论消息类型
            c.user_id, -- 食谱作者
            NEW.commenter_id, -- 评论者
            0, -- 未读
            NEW.id, -- 评论ID
            NOW()
        FROM cookbook c
        WHERE c.id = NEW.content_id AND c.user_id != NEW.commenter_id;
    ELSEIF NEW.content_type = 'gourmet' THEN
        -- 查找美食作者
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        SELECT 
            CONCAT('您的美食"', g.title, '"收到了新评论'), 
            3, -- 评论消息类型
            g.user_id, -- 美食作者
            NEW.commenter_id, -- 评论者
            0, -- 未读
            NEW.id, -- 评论ID
            NOW()
        FROM gourmet g
        WHERE g.id = NEW.content_id AND g.user_id != NEW.commenter_id;
    END IF;
    
    -- 如果是回复，向原评论者发送通知
    IF NEW.parent_id IS NOT NULL AND NEW.replier_id IS NOT NULL THEN
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        SELECT 
            '您的评论收到了新回复', 
            3, -- 评论消息类型
            commenter_id, -- 原评论者
            NEW.replier_id, -- 回复者
            0, -- 未读
            NEW.id, -- 评论ID
            NOW()
        FROM evaluations
        WHERE id = NEW.parent_id AND commenter_id != NEW.replier_id;
    END IF;
END$$
DELIMITER ;

-- 互动统计更新触发器
DELIMITER $$
CREATE TRIGGER `trg_interaction_update`
AFTER INSERT ON `interaction`
FOR EACH ROW
BEGIN
    DECLARE v_content_owner INT UNSIGNED;
    DECLARE v_content_title VARCHAR(255);
    DECLARE v_interaction_type VARCHAR(20);
    
    -- 设置互动类型描述
    SET v_interaction_type = CASE
        WHEN NEW.type = 1 THEN '点赞'
        WHEN NEW.type = 2 THEN '收藏'
        WHEN NEW.type = 3 THEN '浏览'
        WHEN NEW.type = 4 THEN '评分'
        ELSE '互动'
    END;
    
    -- 只处理点赞和收藏的通知
    IF NEW.type IN (1, 2) THEN
        -- 查找内容所有者和标题
        IF NEW.content_type = 'cookbook' THEN
            SELECT user_id, title INTO v_content_owner, v_content_title
            FROM cookbook
            WHERE id = NEW.content_id;
        ELSEIF NEW.content_type = 'gourmet' THEN
            SELECT user_id, title INTO v_content_owner, v_content_title
            FROM gourmet
            WHERE id = NEW.content_id;
        END IF;
        
        -- 如果找到所有者且不是自己互动，发送通知
        IF v_content_owner IS NOT NULL AND v_content_owner != NEW.user_id THEN
            INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
            VALUES (
                CONCAT('您的', CASE WHEN NEW.content_type = 'cookbook' THEN '食谱' ELSE '美食' END, 
                       '"', v_content_title, '"收到了新', v_interaction_type),
                4, -- 互动消息类型
                v_content_owner, -- 内容所有者
                NEW.user_id, -- 互动用户
                0, -- 未读
                NEW.id, -- 互动ID
                NOW()
            );
        END IF;
    END IF;
END$$
DELIMITER ;

-- 用户关系变更历史记录触发器
DELIMITER $$
CREATE TRIGGER `trg_family_relationship_history`
AFTER UPDATE ON `family_relationship`
FOR EACH ROW
BEGIN
    -- 如果状态从正常变为删除，记录历史
    IF OLD.status = 1 AND NEW.status = 0 THEN
        -- 这里可以添加历史记录表来记录被删除的关系
        -- 或发送系统通知
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        VALUES (
            CONCAT('您与用户ID:', OLD.related_user_id, '的家庭关系已解除'),
            2, -- 关系消息类型
            OLD.user_id, -- 发送给关系拥有者
            NULL, -- 系统消息
            0, -- 未读
            OLD.id, -- 关联关系ID
            NOW()
        );
    END IF;
END$$
DELIMITER ;

-- 用户健康数据统计更新触发器
DELIMITER $$
CREATE TRIGGER `trg_health_stats_update`
AFTER INSERT ON `user_health`
FOR EACH ROW
BEGIN
    -- 如果需要实时统计，可以在这里更新统计表
    -- 目前使用视图实现，所以这个触发器可以用于其他目的
    -- 例如，检查连续多次异常值并发出更严重的警告
    
    DECLARE v_abnormal_count INT;
    DECLARE v_metric_name VARCHAR(255);
    
    -- 获取度量名称
    SELECT name INTO v_metric_name
    FROM health_model_config
    WHERE id = NEW.health_model_config_id;
    
    -- 检查最近是否有连续异常值
    SELECT COUNT(*) INTO v_abnormal_count
    FROM user_health uh
    JOIN health_model_config hmc ON uh.health_model_config_id = hmc.id
    WHERE uh.user_id = NEW.user_id
      AND uh.health_model_config_id = NEW.health_model_config_id
      AND uh.create_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
      AND (
          CAST(uh.value AS DECIMAL(10,2)) < CAST(SUBSTRING_INDEX(hmc.value_range, '-', 1) AS DECIMAL(10,2))
          OR
          CAST(uh.value AS DECIMAL(10,2)) > CAST(SUBSTRING_INDEX(hmc.value_range, '-', -1) AS DECIMAL(10,2))
      )
    ORDER BY uh.create_time DESC
    LIMIT 3;
    
    -- 如果连续3次异常，发送特别警告
    IF v_abnormal_count >= 3 THEN
        INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
        VALUES (
            CONCAT('严重警告：您的', v_metric_name, '连续多次出现异常值，请及时就医!'),
            1, -- 健康警告消息类型
            NEW.user_id, -- 用户
            NULL, -- 系统消息
            0, -- 未读
            NEW.id, -- 健康记录ID
            NOW()
        );
    END IF;
END$$
DELIMITER ;

-- ----------------------------
-- 事件定义
-- ----------------------------

-- 创建定时健康提醒事件
DELIMITER $$
CREATE EVENT `evt_health_checkup_reminder`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    -- 查找30天没有记录健康数据的用户
    INSERT INTO message (content, message_type, receiver_id, sender_id, is_read, content_id, create_time)
    SELECT 
        '您已超过30天未记录健康数据，请记得定期监测您的健康状况',
        1, -- 健康提醒消息类型
        u.id, -- 用户ID
        NULL, -- 系统消息
        0, -- 未读
        NULL, -- 无关联内容
        NOW() -- 当前时间
    FROM user u
    LEFT JOIN (
        SELECT DISTINCT user_id
        FROM user_health
        WHERE create_time >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    ) recent_users ON u.id = recent_users.user_id
    WHERE recent_users.user_id IS NULL
      AND u.is_login = 0; -- 只提醒可登录的用户
END$$
DELIMITER ;

-- 数据清理事件
DELIMITER $$
CREATE EVENT `evt_data_cleanup`
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    -- 删除已拒绝且超过6个月的关系请求
    DELETE FROM relationship_request
    WHERE request_status = 2 -- 已拒绝
      AND update_time < DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH);
      
    -- 标记已读且超过1年的消息为可删除状态
    -- 实际删除可以由另一个事件或手动操作完成
    UPDATE message
    SET is_read = 2 -- 使用2表示已读且可删除
    WHERE is_read = 1 -- 已读
      AND create_time < DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);
END$$
DELIMITER ;