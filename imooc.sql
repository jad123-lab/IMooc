/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : imooc

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 28/02/2025 18:43:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 教师认证', 7, 'add_teacherverification');
INSERT INTO `auth_permission` VALUES (26, 'Can change 教师认证', 7, 'change_teacherverification');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 教师认证', 7, 'delete_teacherverification');
INSERT INTO `auth_permission` VALUES (28, 'Can view 教师认证', 7, 'view_teacherverification');
INSERT INTO `auth_permission` VALUES (29, 'Can add 视频分类', 8, 'add_category');
INSERT INTO `auth_permission` VALUES (30, 'Can change 视频分类', 8, 'change_category');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 视频分类', 8, 'delete_category');
INSERT INTO `auth_permission` VALUES (32, 'Can view 视频分类', 8, 'view_category');
INSERT INTO `auth_permission` VALUES (33, 'Can add 视频', 9, 'add_video');
INSERT INTO `auth_permission` VALUES (34, 'Can change 视频', 9, 'change_video');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 视频', 9, 'delete_video');
INSERT INTO `auth_permission` VALUES (36, 'Can view 视频', 9, 'view_video');
INSERT INTO `auth_permission` VALUES (37, 'Can add 视频点赞', 10, 'add_videolike');
INSERT INTO `auth_permission` VALUES (38, 'Can change 视频点赞', 10, 'change_videolike');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 视频点赞', 10, 'delete_videolike');
INSERT INTO `auth_permission` VALUES (40, 'Can view 视频点赞', 10, 'view_videolike');
INSERT INTO `auth_permission` VALUES (41, 'Can add 视频观看记录', 11, 'add_videoview');
INSERT INTO `auth_permission` VALUES (42, 'Can change 视频观看记录', 11, 'change_videoview');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 视频观看记录', 11, 'delete_videoview');
INSERT INTO `auth_permission` VALUES (44, 'Can view 视频观看记录', 11, 'view_videoview');
INSERT INTO `auth_permission` VALUES (45, 'Can add 评论点赞', 12, 'add_commentlike');
INSERT INTO `auth_permission` VALUES (46, 'Can change 评论点赞', 12, 'change_commentlike');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 评论点赞', 12, 'delete_commentlike');
INSERT INTO `auth_permission` VALUES (48, 'Can view 评论点赞', 12, 'view_commentlike');
INSERT INTO `auth_permission` VALUES (49, 'Can add 评论', 13, 'add_comment');
INSERT INTO `auth_permission` VALUES (50, 'Can change 评论', 13, 'change_comment');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 评论', 13, 'delete_comment');
INSERT INTO `auth_permission` VALUES (52, 'Can view 评论', 13, 'view_comment');
INSERT INTO `auth_permission` VALUES (53, 'Can add 聊天消息', 14, 'add_chatmessage');
INSERT INTO `auth_permission` VALUES (54, 'Can change 聊天消息', 14, 'change_chatmessage');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 聊天消息', 14, 'delete_chatmessage');
INSERT INTO `auth_permission` VALUES (56, 'Can view 聊天消息', 14, 'view_chatmessage');
INSERT INTO `auth_permission` VALUES (57, 'Can add 聊天室', 15, 'add_chatroom');
INSERT INTO `auth_permission` VALUES (58, 'Can change 聊天室', 15, 'change_chatroom');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 聊天室', 15, 'delete_chatroom');
INSERT INTO `auth_permission` VALUES (60, 'Can view 聊天室', 15, 'view_chatroom');
INSERT INTO `auth_permission` VALUES (61, 'Can add 聊天室成员', 16, 'add_chatroommember');
INSERT INTO `auth_permission` VALUES (62, 'Can change 聊天室成员', 16, 'change_chatroommember');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 聊天室成员', 16, 'delete_chatroommember');
INSERT INTO `auth_permission` VALUES (64, 'Can view 聊天室成员', 16, 'view_chatroommember');
INSERT INTO `auth_permission` VALUES (65, 'Can add 每日统计', 17, 'add_dailystatistics');
INSERT INTO `auth_permission` VALUES (66, 'Can change 每日统计', 17, 'change_dailystatistics');
INSERT INTO `auth_permission` VALUES (67, 'Can delete 每日统计', 17, 'delete_dailystatistics');
INSERT INTO `auth_permission` VALUES (68, 'Can view 每日统计', 17, 'view_dailystatistics');
INSERT INTO `auth_permission` VALUES (69, 'Can add 用户统计', 18, 'add_userstatistics');
INSERT INTO `auth_permission` VALUES (70, 'Can change 用户统计', 18, 'change_userstatistics');
INSERT INTO `auth_permission` VALUES (71, 'Can delete 用户统计', 18, 'delete_userstatistics');
INSERT INTO `auth_permission` VALUES (72, 'Can view 用户统计', 18, 'view_userstatistics');
INSERT INTO `auth_permission` VALUES (73, 'Can add 视频统计', 19, 'add_videostatistics');
INSERT INTO `auth_permission` VALUES (74, 'Can change 视频统计', 19, 'change_videostatistics');
INSERT INTO `auth_permission` VALUES (75, 'Can delete 视频统计', 19, 'delete_videostatistics');
INSERT INTO `auth_permission` VALUES (76, 'Can view 视频统计', 19, 'view_videostatistics');

-- ----------------------------
-- Table structure for chat_chatmessage
-- ----------------------------
DROP TABLE IF EXISTS `chat_chatmessage`;
CREATE TABLE `chat_chatmessage`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chat_chatmessage_user_id_fa615e65_fk_users_user_id`(`user_id` ASC) USING BTREE,
  INDEX `chat_chatmessage_room_id_5d04fb68_fk_chat_chatroom_id`(`room_id` ASC) USING BTREE,
  CONSTRAINT `chat_chatmessage_room_id_5d04fb68_fk_chat_chatroom_id` FOREIGN KEY (`room_id`) REFERENCES `chat_chatroom` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chat_chatmessage_user_id_fa615e65_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_chatmessage
-- ----------------------------

-- ----------------------------
-- Table structure for chat_chatroom
-- ----------------------------
DROP TABLE IF EXISTS `chat_chatroom`;
CREATE TABLE `chat_chatroom`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `owner_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `owner_id`(`owner_id` ASC) USING BTREE,
  CONSTRAINT `chat_chatroom_owner_id_75572c33_fk_users_user_id` FOREIGN KEY (`owner_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_chatroom
-- ----------------------------

-- ----------------------------
-- Table structure for chat_chatroommember
-- ----------------------------
DROP TABLE IF EXISTS `chat_chatroommember`;
CREATE TABLE `chat_chatroommember`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_banned` tinyint(1) NOT NULL,
  `joined_at` datetime(6) NOT NULL,
  `last_active` datetime(6) NOT NULL,
  `room_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `chat_chatroommember_room_id_user_id_d9d341f1_uniq`(`room_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `chat_chatroommember_user_id_a585b158_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `chat_chatroommember_room_id_72bb9ba8_fk_chat_chatroom_id` FOREIGN KEY (`room_id`) REFERENCES `chat_chatroom` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chat_chatroommember_user_id_a585b158_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_chatroommember
-- ----------------------------

-- ----------------------------
-- Table structure for comments_comment
-- ----------------------------
DROP TABLE IF EXISTS `comments_comment`;
CREATE TABLE `comments_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `parent_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_comment_parent_id_3e0802fb_fk_comments_comment_id`(`parent_id` ASC) USING BTREE,
  INDEX `comments_comment_user_id_a1db4881_fk_users_user_id`(`user_id` ASC) USING BTREE,
  INDEX `comments_comment_video_id_fe17644e_fk_videos_video_id`(`video_id` ASC) USING BTREE,
  CONSTRAINT `comments_comment_parent_id_3e0802fb_fk_comments_comment_id` FOREIGN KEY (`parent_id`) REFERENCES `comments_comment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_comment_user_id_a1db4881_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_comment_video_id_fe17644e_fk_videos_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos_video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_comment
-- ----------------------------
INSERT INTO `comments_comment` VALUES (8, '测试', '2025-02-28 08:36:56.438954', '2025-02-28 08:36:56.438954', 0, NULL, 6, 7);
INSERT INTO `comments_comment` VALUES (9, '测试评论', '2025-02-28 08:44:50.919054', '2025-02-28 09:00:55.632704', 1, NULL, 6, 7);
INSERT INTO `comments_comment` VALUES (10, '哦哦', '2025-02-28 09:25:29.488038', '2025-02-28 09:25:29.488038', 0, NULL, 4, 7);
INSERT INTO `comments_comment` VALUES (11, '测试评论区', '2025-02-28 09:29:15.484110', '2025-02-28 09:29:15.484110', 0, NULL, 4, 7);
INSERT INTO `comments_comment` VALUES (12, '从', '2025-02-28 09:29:56.133203', '2025-02-28 09:29:56.133203', 0, NULL, 4, 7);
INSERT INTO `comments_comment` VALUES (13, '好看', '2025-02-28 09:35:11.098991', '2025-02-28 09:35:11.098991', 0, NULL, 8, 8);

-- ----------------------------
-- Table structure for comments_commentlike
-- ----------------------------
DROP TABLE IF EXISTS `comments_commentlike`;
CREATE TABLE `comments_commentlike`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `comment_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `comments_commentlike_comment_id_user_id_a79ddba8_uniq`(`comment_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `comments_commentlike_comment_id_7809b554`(`comment_id` ASC) USING BTREE,
  INDEX `comments_commentlike_user_id_714b638d`(`user_id` ASC) USING BTREE,
  CONSTRAINT `comments_commentlike_comment_id_7809b554_fk_comments_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments_comment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_commentlike_user_id_714b638d_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_commentlike
-- ----------------------------
INSERT INTO `comments_commentlike` VALUES (30, '2025-02-28 09:02:22.278251', 8, 6);
INSERT INTO `comments_commentlike` VALUES (31, '2025-02-28 09:03:17.111725', 8, 7);
INSERT INTO `comments_commentlike` VALUES (33, '2025-02-28 09:49:32.246918', 13, 8);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (14, 'chat', 'chatmessage');
INSERT INTO `django_content_type` VALUES (15, 'chat', 'chatroom');
INSERT INTO `django_content_type` VALUES (16, 'chat', 'chatroommember');
INSERT INTO `django_content_type` VALUES (13, 'comments', 'comment');
INSERT INTO `django_content_type` VALUES (12, 'comments', 'commentlike');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (17, 'stats', 'dailystatistics');
INSERT INTO `django_content_type` VALUES (18, 'stats', 'userstatistics');
INSERT INTO `django_content_type` VALUES (19, 'stats', 'videostatistics');
INSERT INTO `django_content_type` VALUES (7, 'users', 'teacherverification');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');
INSERT INTO `django_content_type` VALUES (8, 'videos', 'category');
INSERT INTO `django_content_type` VALUES (9, 'videos', 'video');
INSERT INTO `django_content_type` VALUES (10, 'videos', 'videolike');
INSERT INTO `django_content_type` VALUES (11, 'videos', 'videoview');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-02-28 09:52:59.165481');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2025-02-28 09:52:59.352695');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2025-02-28 09:52:59.605861');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2025-02-28 09:52:59.659344');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2025-02-28 09:52:59.665850');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2025-02-28 09:52:59.670953');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2025-02-28 09:52:59.676999');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2025-02-28 09:52:59.680022');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2025-02-28 09:52:59.686043');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2025-02-28 09:52:59.690967');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2025-02-28 09:52:59.700676');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2025-02-28 09:52:59.724547');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2025-02-28 09:52:59.730797');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2025-02-28 09:52:59.737366');
INSERT INTO `django_migrations` VALUES (15, 'users', '0001_initial', '2025-02-28 09:53:00.098743');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2025-02-28 09:53:00.239988');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2025-02-28 09:53:00.247152');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2025-02-28 09:53:00.255596');
INSERT INTO `django_migrations` VALUES (19, 'chat', '0001_initial', '2025-02-28 09:53:00.314729');
INSERT INTO `django_migrations` VALUES (20, 'chat', '0002_initial', '2025-02-28 09:53:00.620886');
INSERT INTO `django_migrations` VALUES (21, 'videos', '0001_initial', '2025-02-28 09:53:01.061860');
INSERT INTO `django_migrations` VALUES (22, 'comments', '0001_initial', '2025-02-28 09:53:01.152155');
INSERT INTO `django_migrations` VALUES (23, 'comments', '0002_initial', '2025-02-28 09:53:01.428580');
INSERT INTO `django_migrations` VALUES (24, 'sessions', '0001_initial', '2025-02-28 09:53:01.466989');
INSERT INTO `django_migrations` VALUES (25, 'stats', '0001_initial', '2025-02-28 09:53:01.531080');
INSERT INTO `django_migrations` VALUES (26, 'stats', '0002_initial', '2025-02-28 09:53:01.659868');
INSERT INTO `django_migrations` VALUES (27, 'comments', '0003_alter_commentlike_unique_together_and_more', '2025-02-28 06:47:01.865118');
INSERT INTO `django_migrations` VALUES (28, 'comments', '0004_alter_commentlike_unique_together', '2025-02-28 06:54:08.436025');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1k1kxp9k6tr2vuv6gpin2242iy75kjf5', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnwU4:-FGGgXZn8Rt950kYXVEex_7i9-VV0qcpnjwPk-QzoQE', '2025-03-14 09:16:40.474277');
INSERT INTO `django_session` VALUES ('4eem26ssjzop47y3rd3krppqw2sppt3c', '.eJxVjEEOwiAQAP_C2ZBtEej26N03EGDBogYMtInG-HdD0oNeZybzZsZu62K2FqpJxGam2OGXOetvIXdBV5svhfuS15oc7wnfbePnQuF-2tu_wWLb0reTk-E4RMRB6DESCC0HSWQnkmMQoBAieTGSUhNEp31EjQ6jRwtgCfq0hdZSySY8H6m-2AyfL363PyM:1tnuMj:6InYDgCUWp4urRgHHXkOvBEto4PV_ZX_VuZrD1gBoGU', '2025-03-14 07:00:57.150829');
INSERT INTO `django_session` VALUES ('4g7pp1068x4cda182dpgnyx6zrn3pll4', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnvqH:FNwX42cdxdtBXtKrVbxjAFSyW8XI2E8F49s1zfhLIDk', '2025-03-14 08:35:33.439927');
INSERT INTO `django_session` VALUES ('4wj60o6gew8ppss22uegrut4kfjpeptw', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnqcJ:B_uY19WhfYmQHGtrPdzc_bXifHILqd0L-S6pSLduaPo', '2025-03-14 11:00:47.205430');
INSERT INTO `django_session` VALUES ('6to9fe2dqtvqmx9k3k104uc0y0l6uj4m', '.eJxVjEEOwiAQRe_C2hBKhw64dO8ZyMCAVA0kpV0Z765NutDtf-_9l_C0rcVvPS1-ZnEWVpx-t0DxkeoO-E711mRsdV3mIHdFHrTLa-P0vBzu30GhXr61gpQBEAJCdjHnjKAtcECi0U1TToRsjVasRgIHI6MeiNlots6qwYj3B--GN7o:1tnwlb:tHZzhNEpps1lPF3AlJXZp9go7P8Ink4VPJEh2fSYlmQ', '2025-03-14 09:34:47.153779');
INSERT INTO `django_session` VALUES ('7wixcmh3mmboihdk528qc1dmtymf1ksn', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnpaT:q-liAQWUwWJ9TkuaG1A7QZ3gOOtCpmZbOknePzIddpU', '2025-03-14 09:54:49.139539');
INSERT INTO `django_session` VALUES ('93ls00u405wukdudf9fbmru0yf2k0ho5', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnwc0:i3cZq09lBM-k_o2-rFXCtCHbeE04D4sCt3c7oO4YCJM', '2025-03-14 09:24:52.144487');
INSERT INTO `django_session` VALUES ('9hm21mkfvnr5yg6vj6ixvffjgpbxlyrd', '.eJxVjDkOwjAUBe_iGlnewnco6XMG6y82DqBEipMKcXeIlALaNzPvpRJua01by0saRV1UUKffjZAfedqB3HG6zZrnaV1G0ruiD9r0MEt-Xg_376Biq98aBIw9G0AmQ5GshUDF-QA-FMgdAEZTmK1w8JGlsz16YO96ACuOUL0_1Rs3mQ:1tnrjA:vjftdfe053F4D9VKI8Mj2lwJj81as0WCGOmZ_tMAdYk', '2025-03-14 04:11:56.315826');
INSERT INTO `django_session` VALUES ('9qai24t5x14xpar06h1urwo3jff43zj1', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnshN:g5XY6eks9I5HIPx73i_TtCJ5MGStOZjU8r16Wuj1Qf0', '2025-03-14 05:14:09.157057');
INSERT INTO `django_session` VALUES ('chl5f0eefjzke5mcnajsnj5eik2wiya7', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnxXR:pNS57vdwER--5J8w1DooMIpUchFZjUofgvnEGZcZ9pw', '2025-03-14 10:24:13.224681');
INSERT INTO `django_session` VALUES ('ddtdo162ttjbqsig8uwdxjv18g604ofe', '.eJxVjDsOwjAQBe_iGlle_wgp6TmDtRtviAHZyE4kEOLuECkFtG_mzUsEXOYpLI1rSFH0AsTudyMcrpxXEC-Yz0UOJc81kVwVudEmTyXy7bi5f4EJ2_R9OwPaHcACGVJOW0QPg3dkPVtjiEZyDMYCesauQzdSpBGUIjCs9V6t0catpZIDP-6pPkWv3h9hRD6q:1tnsHB:r-Q_8SaC8jIQStRAwP278V44CjFmEjIK8A3xA8APiqs', '2025-03-14 04:47:05.860889');
INSERT INTO `django_session` VALUES ('dee5poj82bz404hfuchcy1ahlb01xm1v', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnr3w:4GiXlwY6Jgp34nxutSK-SNTtHsmrOxWlXbJ8Rokb2t4', '2025-03-14 11:29:20.154856');
INSERT INTO `django_session` VALUES ('efo6bad2vdpg3sj8lrxn2grigkkca9m1', '.eJxVjMsOwiAQAP-FsyFLkcd69O43kIUFWzWQlPZk_HdD0oNeZybzFoH2bQ57z2tYWFyEFadfFik9cx2CH1TvTaZWt3WJciTysF3eGufX9Wj_BjP1eWx9NPmsCqLSbioM2hllmMmzmbIGi1A46Ymt9VCiSwUdRiwJCYAYxOcL1mk35g:1tnwml:4bznszmqOh-gPF4aYBUR-EJVQW6ec_R4n8rpt8fhsgs', '2025-03-14 09:35:59.746570');
INSERT INTO `django_session` VALUES ('fy1c178yj6lye0882n06z4678is1kvwp', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnqtp:RsdVcI6y1rup-R2lQ5AP39E5waZoPehisv_4gdRF8ho', '2025-03-14 11:18:53.991845');
INSERT INTO `django_session` VALUES ('gizmy7hwzlxcw56wbvb52u148y7opj25', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnrvR:Z_jJbMJDswqDEQfnRotnIue9dOw9iLTOHQZOMwNvCZg', '2025-03-14 04:24:37.907879');
INSERT INTO `django_session` VALUES ('he9m06fljmc5qg9415hzbketxz7omr5l', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnsoc:cPJrwgCcj8afwtw3_N1eoZcoaW9CcRDblF4-qHq1wN8', '2025-03-14 05:21:38.953671');
INSERT INTO `django_session` VALUES ('hp8r7l8yso2enbv92nnafk01b9qn3tjr', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnqxX:k88vNNQKHExvEj6ZidG8u99wAZGvLPY5XXv287wcAJs', '2025-03-14 11:22:43.994308');
INSERT INTO `django_session` VALUES ('ivuiymq6rmgbe20macy4vmkwk9a7gcor', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnqq1:W5X5nvCm68TyiAFmFWvOBDsln9TJmGL4z6qoiEuzLtc', '2025-03-14 11:14:57.392243');
INSERT INTO `django_session` VALUES ('j0rr0v0r8tttljcujuc2uok65ou0yrya', '.eJxVjEEOwiAQAP_C2ZBtEej26N03EGDBogYMtInG-HdD0oNeZybzZsZu62K2FqpJxGam2OGXOetvIXdBV5svhfuS15oc7wnfbePnQuF-2tu_wWLb0reTk-E4RMRB6DESCC0HSWQnkmMQoBAieTGSUhNEp31EjQ6jRwtgCfq0hdZSySY8H6m-2AyfL363PyM:1tnvLB:ObqcSsAnkdeNldVfQbFRpHFiOpV9JTHweb1u19rCark', '2025-03-14 08:03:25.321812');
INSERT INTO `django_session` VALUES ('ke1ry1va06x740xl0kow91pyhdsmsnbz', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnsjL:9qAXB3WNrQ-QNQROI4q_CFygP_9ujFiJL6mRoqD75ek', '2025-03-14 05:16:11.278011');
INSERT INTO `django_session` VALUES ('kif9abi2tbobbhvg18torqsd7owqs8by', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnwEp:khbhJHu2ZchPhIJqWTA1z2aSRCG6YrhX0aX7u6lKjck', '2025-03-14 09:00:55.662751');
INSERT INTO `django_session` VALUES ('kwz1myl3osqnitun5w4lk6fwko3d8fzx', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnvkq:7vbC2YV5EY9OVjOAYW9VTEMTn4pqgNmiGEq6s01d8yc', '2025-03-14 08:29:56.390219');
INSERT INTO `django_session` VALUES ('lvoosts7tlpq6yakzm2ivafryv0ko4w8', '.eJxVjMEOwiAQRP-FsyFWCrQevfcbyC67K1UDSWlPxn-XJj3oZSaZNzNvFWBbU9gqL2EmdVVenX4zhPjkvAN6QL4XHUtelxn1XtEHrXoqxK_b0f07SFBTWxuH3tuITnBwzQxEh6MXufQDMiK4aJmsNSJNse9AIBomsp2QjGf1-QIbTDnB:1tnwGz:baEbokNkJY6uyVBEsGbg82y60Kl3exL64ZOnAC8oOmc', '2025-03-14 09:03:09.706945');
INSERT INTO `django_session` VALUES ('mlxskbkewd477f1yq8clhmrijw3eyhqp', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnwSd:E3ZciLIl3RZOyliFPMRyiVA2DCetoi74dValHV7AnRU', '2025-03-14 09:15:11.681841');
INSERT INTO `django_session` VALUES ('mszlmhky8tmzlxx6f07fxbxf5ir4aqc9', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnu2H:fvy_5OdSG81YbLi8yc90W9Vb6uOM0SC2Z8tA81c3_hU', '2025-03-14 06:39:49.263847');
INSERT INTO `django_session` VALUES ('nqurnn0r1budmlmj4acx5kqbpl3y55ac', '.eJxVjEEOwiAQAP_C2ZBtEej26N03EGDBogYMtInG-HdD0oNeZybzZsZu62K2FqpJxGam2OGXOetvIXdBV5svhfuS15oc7wnfbePnQuF-2tu_wWLb0reTk-E4RMRB6DESCC0HSWQnkmMQoBAieTGSUhNEp31EjQ6jRwtgCfq0hdZSySY8H6m-2AyfL363PyM:1tnxWq:v74IEjg2P-1F4cXSt3xd-gJQEgLrDvFK1z7AZWbPu6g', '2025-03-14 10:23:36.963835');
INSERT INTO `django_session` VALUES ('nwcf9fybrq6ax4p7fjhg0o2ax0pbe428', '.eJxVjDsOwjAQBe_iGlmOP_FCSZ8zWLveNQ6gRIqTCnF3iJQC2jcz76USbmtNW5MljawuqlOn340wP2TaAd9xus06z9O6jKR3RR-06WFmeV4P9--gYqvfGiwJeCsm5q533McoABzEeMcxIJYAxEiUMYMvVHrvAN05WvFGwBr1_gDt3Tg7:1tnqkL:ty9XlcCDvKyHvhafr7tudJgbQw7Ttd1Y02rtbtv9iIg', '2025-03-14 11:09:05.410155');
INSERT INTO `django_session` VALUES ('qarlee38721kh25aq5p8nuppjdxu70wj', '.eJxVjDsOwjAQBe_iGlle_wgp6TmDtRtviAHZyE4kEOLuECkFtG_mzUsEXOYpLI1rSFH0AsTudyMcrpxXEC-Yz0UOJc81kVwVudEmTyXy7bi5f4EJ2_R9OwPaHcACGVJOW0QPg3dkPVtjiEZyDMYCesauQzdSpBGUIjCs9V6t0catpZIDP-6pPkWv3h9hRD6q:1tnuNk:FUdGBCeyaSB3dO7EbPa5vRSm-17ebHCyyZjVK8NzHag', '2025-03-14 07:02:00.521716');
INSERT INTO `django_session` VALUES ('siolp8ed2hwxm6k85o53d3ps5qt6k5vi', '.eJxVjEEOwiAQRe_C2hCGAawu3XuGZgYGqRpISrsy3l2bdKHb_977LzXSupRx7TKPU1JnBerwuzHFh9QNpDvVW9Ox1WWeWG-K3mnX15bkedndv4NCvXxrj2D9CRwwsvHWEQWIwbML4hCZM3sBdEBBaBjIZ06cwRgGFGuPRr0_wmo3bQ:1tnsLm:2LRlU7EV6-Uce2BSpi4BUad3UkVnfe-X_BM_kaVuXCQ', '2025-03-14 04:51:50.772681');
INSERT INTO `django_session` VALUES ('t1mvx8pp2no9ckx9x6kk038nl107aorf', '.eJxVjMsOwiAUBf-FtSFQqLd16d5vIPdBLWrAlDbRGP9dm3Sh2zNz5qUCLvMYlhqnkEQdlFe7342QrzGvQC6Yz0VzyfOUSK-K3mjVpyLxdtzcv8CIdfy-QcDYvQFkMtSRteBpaJwH5weILQB2ZmC2wt51LK3t0QG7pgew0hCu0RprTSWH-Lin6akO5v0Bd2U-1g:1tnrqo:ZRMo39TuZzs34k8b4KiYiLkyPJruTPLVbdW2_UFe0U4', '2025-03-14 04:19:50.675591');
INSERT INTO `django_session` VALUES ('ub8is9rnq2cwpecfkuuywya1ojj965a2', '.eJxVjMsOwiAQAP-FsyFLkcd69O43kIUFWzWQlPZk_HdD0oNeZybzFoH2bQ57z2tYWFyEFadfFik9cx2CH1TvTaZWt3WJciTysF3eGufX9Wj_BjP1eWx9NPmsCqLSbioM2hllmMmzmbIGi1A46Ymt9VCiSwUdRiwJCYAYxOcL1mk35g:1tnty9:hO9etDbNMvSX2dK2ULYDnXWO9kaAtkp93HDxWvPBvrc', '2025-03-14 06:35:33.658919');
INSERT INTO `django_session` VALUES ('vc03be9jcoj9qy4mqica6it7d5y35qja', '.eJxVjMsOwiAUBf-FtSFQqLd16d5vIPdBLWrAlDbRGP9dm3Sh2zNz5qUCLvMYlhqnkEQdlFe7342QrzGvQC6Yz0VzyfOUSK-K3mjVpyLxdtzcv8CIdfy-QcDYvQFkMtSRteBpaJwH5weILQB2ZmC2wt51LK3t0QG7pgew0hCu0RprTSWH-Lin6akO5v0Bd2U-1g:1tnu1f:XkEI3d7a47Gr_XqlBXKICtkSZ9mabqzva-BY0FOw9p4', '2025-03-14 06:39:11.512380');
INSERT INTO `django_session` VALUES ('whrz5qd08wlp772vr78mnlkm5vf8vwt0', '.eJxVjDkOwjAUBe_iGlnewnco6XMG6y82DqBEipMKcXeIlALaNzPvpRJua01by0saRV1UUKffjZAfedqB3HG6zZrnaV1G0ruiD9r0MEt-Xg_376Biq98aBIw9G0AmQ5GshUDF-QA-FMgdAEZTmK1w8JGlsz16YO96ACuOUL0_1Rs3mQ:1tnwjI:ThekMUDKXeWAJHsPH3UW_iWDQoQpXtUacdKSruBbUBI', '2025-03-14 09:32:24.779343');
INSERT INTO `django_session` VALUES ('zyy3kp9puv9qmne4qblfzrpv5egby7pi', '.eJxVjMsOwiAUBf-FtSFQqLd16d5vIPdBLWrAlDbRGP9dm3Sh2zNz5qUCLvMYlhqnkEQdlFe7342QrzGvQC6Yz0VzyfOUSK-K3mjVpyLxdtzcv8CIdfy-QcDYvQFkMtSRteBpaJwH5weILQB2ZmC2wt51LK3t0QG7pgew0hCu0RprTSWH-Lin6akO5v0Bd2U-1g:1tnvO6:EgUUnCJAlPk54oAY75-PrqGyOLn2LR9EPQAnoTPnHKw', '2025-03-14 08:06:26.698118');

-- ----------------------------
-- Table structure for stats_dailystatistics
-- ----------------------------
DROP TABLE IF EXISTS `stats_dailystatistics`;
CREATE TABLE `stats_dailystatistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total_users` int NOT NULL,
  `new_users` int NOT NULL,
  `active_users` int NOT NULL,
  `total_videos` int NOT NULL,
  `new_videos` int NOT NULL,
  `total_views` int NOT NULL,
  `total_comments` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `date`(`date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stats_dailystatistics
-- ----------------------------

-- ----------------------------
-- Table structure for stats_userstatistics
-- ----------------------------
DROP TABLE IF EXISTS `stats_userstatistics`;
CREATE TABLE `stats_userstatistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_videos` int NOT NULL,
  `total_views` int NOT NULL,
  `total_likes` int NOT NULL,
  `total_comments` int NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `stats_userstatistics_user_id_3006b8e9_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stats_userstatistics
-- ----------------------------

-- ----------------------------
-- Table structure for stats_videostatistics
-- ----------------------------
DROP TABLE IF EXISTS `stats_videostatistics`;
CREATE TABLE `stats_videostatistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `daily_views` int NOT NULL,
  `daily_likes` int NOT NULL,
  `daily_comments` int NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  `video_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `video_id`(`video_id` ASC) USING BTREE,
  CONSTRAINT `stats_videostatistics_video_id_d887f4b0_fk_videos_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos_video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stats_videostatistics
-- ----------------------------

-- ----------------------------
-- Table structure for users_teacherverification
-- ----------------------------
DROP TABLE IF EXISTS `users_teacherverification`;
CREATE TABLE `users_teacherverification`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `certificate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `users_teacherverification_user_id_9e84a115_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_teacherverification
-- ----------------------------
INSERT INTO `users_teacherverification` VALUES (2, 'certificates/OIP-C.jpg', '我牛逼', 'approved', '2025-02-28 11:50:37.188654', '2025-02-28 11:51:08.734357', 4);
INSERT INTO `users_teacherverification` VALUES (3, 'certificates/微信图片_20250226170837.jpg', '博士生毕业', 'approved', '2025-02-28 06:03:24.742875', '2025-02-28 07:50:34.288977', 6);
INSERT INTO `users_teacherverification` VALUES (4, 'certificates/banner1.png', '硕士毕业', 'approved', '2025-02-28 09:33:46.216934', '2025-02-28 09:34:23.221338', 8);

-- ----------------------------
-- Table structure for users_user
-- ----------------------------
DROP TABLE IF EXISTS `users_user`;
CREATE TABLE `users_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user
-- ----------------------------
INSERT INTO `users_user` VALUES (1, 'pbkdf2_sha256$720000$8XqPwpNSwwiHkzHRTz4SWK$q5//zEu3wi9Z8M6HF0Jd0btOUZ9KoBeDrYH5CJSDVvI=', '2025-02-28 10:24:13.221128', 1, 'admin', '', '', 'admin@qq.com', 1, 1, '2025-02-28 09:53:30.056970', 'admin', '', NULL, 0);
INSERT INTO `users_user` VALUES (4, 'pbkdf2_sha256$720000$l2CMm7ZH2xGhG6D1ZeGpTv$rDvpbOHAU0FOWraet9vJZKmg7gHgneQXchGjI9iRIZk=', '2025-02-28 09:32:57.178417', 0, 'ces', '', '', '1301708719@qq.com', 0, 1, '2025-02-28 11:50:23.894740', 'student', '', '18530673619', 0);
INSERT INTO `users_user` VALUES (5, 'pbkdf2_sha256$720000$vOAizhisQmwaOWux8mObNV$oeTpPgemo9K+PG2u/u/JH61EB41Ai3s3VZTqDqW03AA=', NULL, 0, 'ggb', '', '', 'wsad@qq.com', 0, 1, '2025-02-28 04:59:46.858530', 'student', 'avatars/下载_3.jpg', '18530673619', 0);
INSERT INTO `users_user` VALUES (6, 'pbkdf2_sha256$720000$HFZOopuSf8o99o8C9hwFRC$wknMSe7DGwNNa3HA3AXwO/KV3iq1La6DfPOck73NDc4=', '2025-02-28 10:12:20.403757', 0, 'zhao', '', '', '1301708718@qq.com', 0, 1, '2025-02-28 06:03:04.552963', 'teacher', '', '18317333619', 1);
INSERT INTO `users_user` VALUES (7, 'pbkdf2_sha256$720000$Yop1OhspFHQJ75TaFkzhfL$J1+nNfc7X/cJ+ueCb/BUtzvMbZ5doLGWCoD5cwyZ7Sk=', '2025-02-28 09:03:09.677887', 0, 'hj', '', '', '13017087118@qq.com', 0, 1, '2025-02-28 09:03:09.223558', 'student', '', '18317333619', 0);
INSERT INTO `users_user` VALUES (8, 'pbkdf2_sha256$720000$rGgltu8jG8CdQGj0Tr89vq$lqSWOudX5PyF3j4+Wk7F/TwvSmb4tNcWmM+VQOiGTcE=', '2025-02-28 09:33:29.799142', 0, 'gg', '', '', '130170871228@qq.com', 0, 1, '2025-02-28 09:33:29.354749', 'teacher', '', '18317333611', 1);

-- ----------------------------
-- Table structure for users_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `users_user_groups`;
CREATE TABLE `users_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_groups_user_id_group_id_b88eab82_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `users_user_groups_group_id_9afc8d0e_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for users_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `users_user_user_permissions`;
CREATE TABLE `users_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_user_permissions_user_id_permission_id_43338c45_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `users_user_user_perm_permission_id_0b93982e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for videos_category
-- ----------------------------
DROP TABLE IF EXISTS `videos_category`;
CREATE TABLE `videos_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of videos_category
-- ----------------------------
INSERT INTO `videos_category` VALUES (1, '前端开发', 'Web前端开发相关课程', '2025-02-28 10:38:34.000000');
INSERT INTO `videos_category` VALUES (2, '后端开发', 'Web后端开发相关课程', '2025-02-28 10:38:34.000000');
INSERT INTO `videos_category` VALUES (3, '移动开发', '移动应用开发相关课程', '2025-02-28 10:38:34.000000');

-- ----------------------------
-- Table structure for videos_video
-- ----------------------------
DROP TABLE IF EXISTS `videos_video`;
CREATE TABLE `videos_video`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` int NOT NULL,
  `likes` int NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `videos_video_author_id_cb8e1e63_fk_users_user_id`(`author_id` ASC) USING BTREE,
  INDEX `videos_video_category_id_192e505b_fk_videos_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `videos_video_author_id_cb8e1e63_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `videos_video_category_id_192e505b_fk_videos_category_id` FOREIGN KEY (`category_id`) REFERENCES `videos_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of videos_video
-- ----------------------------
INSERT INTO `videos_video` VALUES (7, '测试', 'web', 'videos/3143a2b013b6a28173b9f44f59dec795_ThlRd09.mp4', 'covers/banner2.png', 0, 2, 'published', '2025-02-28 08:35:04.433154', '2025-02-28 09:07:39.561262', 6, 1);
INSERT INTO `videos_video` VALUES (8, '后端', '后端后端', 'videos/f94b1a58f77c9af401b5b7f84e052eca_o6dfLVe.mp4', 'covers/banner3_jnBfV3i.png', 0, 1, 'published', '2025-02-28 09:34:47.129080', '2025-02-28 10:40:15.995309', 8, 2);

-- ----------------------------
-- Table structure for videos_videolike
-- ----------------------------
DROP TABLE IF EXISTS `videos_videolike`;
CREATE TABLE `videos_videolike`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `videos_videolike_video_id_user_id_f615bcb1_uniq`(`video_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `videos_videolike_user_id_e36b7f64_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `videos_videolike_user_id_e36b7f64_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `videos_videolike_video_id_bb6954c2_fk_videos_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos_video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of videos_videolike
-- ----------------------------
INSERT INTO `videos_videolike` VALUES (18, '2025-02-28 08:59:53.010910', 6, 7);
INSERT INTO `videos_videolike` VALUES (19, '2025-02-28 09:07:39.558145', 7, 7);
INSERT INTO `videos_videolike` VALUES (20, '2025-02-28 09:35:30.305746', 8, 8);

-- ----------------------------
-- Table structure for videos_videoview
-- ----------------------------
DROP TABLE IF EXISTS `videos_videoview`;
CREATE TABLE `videos_videoview`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `viewed_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `videos_videoview_video_id_user_id_7bd8080a_uniq`(`video_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `videos_videoview_user_id_d50b4237_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `videos_videoview_user_id_d50b4237_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `videos_videoview_video_id_211f58f6_fk_videos_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos_video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of videos_videoview
-- ----------------------------
INSERT INTO `videos_videoview` VALUES (12, '2025-02-28 08:35:41.474478', 6, 7);
INSERT INTO `videos_videoview` VALUES (15, '2025-02-28 08:40:36.914819', 1, 7);
INSERT INTO `videos_videoview` VALUES (17, '2025-02-28 09:03:12.744449', 7, 7);
INSERT INTO `videos_videoview` VALUES (18, '2025-02-28 09:22:54.046386', 4, 7);
INSERT INTO `videos_videoview` VALUES (19, '2025-02-28 09:35:00.792311', 8, 8);
INSERT INTO `videos_videoview` VALUES (20, '2025-02-28 09:35:19.195469', 8, 7);
INSERT INTO `videos_videoview` VALUES (21, '2025-02-28 09:36:01.295093', 6, 8);

SET FOREIGN_KEY_CHECKS = 1;
