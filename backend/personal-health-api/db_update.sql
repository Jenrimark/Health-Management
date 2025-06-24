-- 修改health_plan表中的target_calories列为steps
ALTER TABLE health_plan CHANGE COLUMN target_calories steps INT;

-- 如果需要从头创建这个表，这里是完整的建表语句
/*
CREATE TABLE IF NOT EXISTS health_plan (
  id INT PRIMARY KEY,
  user_id INT NOT NULL,
  plan_date DATE NOT NULL,
  steps INT,
  exercise_minutes INT,
  exercise_type VARCHAR(50),
  calories_burned INT,
  create_time DATETIME NOT NULL,
  update_time DATETIME,
  FOREIGN KEY (user_id) REFERENCES user(id)
);
*/

-- 家庭关系表
DROP TABLE IF EXISTS `family_relationship`;
CREATE TABLE `family_relationship` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `user_id` int UNSIGNED NOT NULL COMMENT '用户ID',
  `related_user_id` int UNSIGNED NOT NULL COMMENT '关联用户ID',
  `relationship_type` tinyint NOT NULL COMMENT '关系类型(1:父母,2:子女,3:配偶,4:兄弟姐妹,5:祖父母,6:孙子女,7:其他)',
  `permission_level` tinyint NOT NULL DEFAULT 1 COMMENT '权限级别(1:只读查看,2:可编辑,3:完全管理)',
  `data_access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1,2,3' COMMENT '可访问的数据类型(1:健康指标,2:饮食记录,3:运动记录,4:药物记录,多个以逗号分隔)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态(0:已删除,1:正常)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_related` (`user_id`, `related_user_id`) COMMENT '用户关系唯一约束',
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_related_user_id` (`related_user_id`) USING BTREE,
  CONSTRAINT `fk_family_relationship_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_family_relationship_related_user_id` FOREIGN KEY (`related_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '家庭关系表' ROW_FORMAT = DYNAMIC;

-- 关系请求表
DROP TABLE IF EXISTS `relationship_request`;
CREATE TABLE `relationship_request` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求ID',
  `sender_id` int UNSIGNED NOT NULL COMMENT '发送者ID',
  `receiver_id` int UNSIGNED NOT NULL COMMENT '接收者ID',
  `relationship_type` tinyint NOT NULL COMMENT '关系类型(1:父母,2:子女,3:配偶,4:兄弟姐妹,5:祖父母,6:孙子女,7:其他)',
  `permission_level` tinyint NOT NULL DEFAULT 1 COMMENT '请求的权限级别(1:只读查看,2:可编辑,3:完全管理)',
  `data_access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1,2,3' COMMENT '请求访问的数据类型(1:健康指标,2:饮食记录,3:运动记录,4:药物记录,多个以逗号分隔)',
  `request_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求消息',
  `request_status` tinyint NOT NULL DEFAULT 0 COMMENT '请求状态(0:待处理,1:已接受,2:已拒绝)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sender_id` (`sender_id`) USING BTREE,
  KEY `idx_receiver_id` (`receiver_id`) USING BTREE,
  KEY `idx_status` (`request_status`) USING BTREE,
  CONSTRAINT `fk_relationship_request_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_request_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '关系请求表' ROW_FORMAT = DYNAMIC; 