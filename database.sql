-- 创建数据库
CREATE DATABASE IF NOT EXISTS imooc DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE imooc;

-- 用户表
CREATE TABLE users_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(128) NOT NULL,
    last_login DATETIME(6) NULL,
    is_superuser TINYINT(1) NOT NULL,
    username VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL,
    is_staff TINYINT(1) NOT NULL,
    is_active TINYINT(1) NOT NULL,
    date_joined DATETIME(6) NOT NULL,
    role VARCHAR(10) NOT NULL,
    avatar VARCHAR(100) NULL,
    phone VARCHAR(11) NULL,
    is_verified TINYINT(1) NOT NULL DEFAULT 0
);

-- 教师认证表
CREATE TABLE users_teacherverification (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    certificate VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at DATETIME(6) NOT NULL,
    updated_at DATETIME(6) NOT NULL,
    user_id BIGINT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users_user(id)
);

-- 视频分类表
CREATE TABLE videos_category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at DATETIME(6) NOT NULL
);

-- 视频表
CREATE TABLE videos_video (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    file VARCHAR(100) NOT NULL,
    cover VARCHAR(100) NOT NULL,
    views INT NOT NULL DEFAULT 0,
    likes INT NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL,
    created_at DATETIME(6) NOT NULL,
    updated_at DATETIME(6) NOT NULL,
    author_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users_user(id),
    FOREIGN KEY (category_id) REFERENCES videos_category(id)
);

-- 视频观看记录表
CREATE TABLE videos_videoview (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    viewed_at DATETIME(6) NOT NULL,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_user(id),
    FOREIGN KEY (video_id) REFERENCES videos_video(id),
    UNIQUE KEY unique_video_view (video_id, user_id)
);

-- 视频点赞表
CREATE TABLE videos_videolike (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME(6) NOT NULL,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_user(id),
    FOREIGN KEY (video_id) REFERENCES videos_video(id),
    UNIQUE KEY unique_video_like (video_id, user_id)
);

-- 评论表
CREATE TABLE comments_comment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    likes INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL,
    updated_at DATETIME(6) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    parent_id BIGINT NULL,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES comments_comment(id),
    FOREIGN KEY (user_id) REFERENCES users_user(id),
    FOREIGN KEY (video_id) REFERENCES videos_video(id)
);

-- 评论点赞表
CREATE TABLE comments_commentlike (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME(6) NOT NULL,
    comment_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (comment_id) REFERENCES comments_comment(id),
    FOREIGN KEY (user_id) REFERENCES users_user(id),
    UNIQUE KEY unique_comment_like (comment_id, user_id)
);

-- 聊天室表
CREATE TABLE chat_chatroom (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME(6) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    owner_id BIGINT NOT NULL UNIQUE,
    FOREIGN KEY (owner_id) REFERENCES users_user(id)
);

-- 聊天消息表
CREATE TABLE chat_chatmessage (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    created_at DATETIME(6) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    room_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES chat_chatroom(id),
    FOREIGN KEY (user_id) REFERENCES users_user(id)
);

-- 聊天室成员表
CREATE TABLE chat_chatroommember (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    is_banned TINYINT(1) NOT NULL DEFAULT 0,
    joined_at DATETIME(6) NOT NULL,
    last_active DATETIME(6) NOT NULL,
    room_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES chat_chatroom(id),
    FOREIGN KEY (user_id) REFERENCES users_user(id),
    UNIQUE KEY unique_room_member (room_id, user_id)
);

-- 每日统计表
CREATE TABLE stats_dailystatistics (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    total_users INT NOT NULL DEFAULT 0,
    new_users INT NOT NULL DEFAULT 0,
    active_users INT NOT NULL DEFAULT 0,
    total_videos INT NOT NULL DEFAULT 0,
    new_videos INT NOT NULL DEFAULT 0,
    total_views INT NOT NULL DEFAULT 0,
    total_comments INT NOT NULL DEFAULT 0
);

-- 用户统计表
CREATE TABLE stats_userstatistics (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    total_videos INT NOT NULL DEFAULT 0,
    total_views INT NOT NULL DEFAULT 0,
    total_likes INT NOT NULL DEFAULT 0,
    total_comments INT NOT NULL DEFAULT 0,
    last_updated DATETIME(6) NOT NULL,
    user_id BIGINT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users_user(id)
);

-- 视频统计表
CREATE TABLE stats_videostatistics (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    daily_views INT NOT NULL DEFAULT 0,
    daily_likes INT NOT NULL DEFAULT 0,
    daily_comments INT NOT NULL DEFAULT 0,
    last_updated DATETIME(6) NOT NULL,
    video_id BIGINT NOT NULL UNIQUE,
    FOREIGN KEY (video_id) REFERENCES videos_video(id)
); 