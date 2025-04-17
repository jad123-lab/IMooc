# 个性化网上学习系统系统

一个基于Django的在线教育平台，支持视频课程、实时聊天、评论互动等功能。

## 功能特点

- 用户系统
  - 普通用户注册登录
  - 教师认证
  - 用户权限管理
- 视频系统
  - 视频上传和播放
  - 分类管理
  - 点赞和观看统计
- 互动系统
  - 视频评论
  - 实时聊天室
  - 用户反馈
- 后台管理
  - 用户管理
  - 内容审核
  - 数据统计

## 环境要求

- Python 3.8+
- MySQL 5.7+
- Redis 6.0+

## 安装步骤

1. 克隆项目到本地：
```bash
git clone https://github.com/yourusername/IMooc.git
cd IMooc
```

2. 创建并激活虚拟环境：
```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# Linux/Mac
source .venv/bin/activate
```

3. 安装依赖（使用国内镜像）：
```bash
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
```

4. 创建MySQL数据库：
```bash
mysql -u root -p < database.sql
```

5. 修改数据库配置：
编辑 IMooc/settings.py 文件，配置数据库连接信息。

6. 执行数据库迁移：
```bash
python manage.py makemigrations
python manage.py migrate
```

7. 创建超级用户：
```bash
python manage.py createsuperuser
```

8. 启动开发服务器：
```bash
python manage.py runserver
daphne -b 0.0.0.0 -p 8001 IMooc.asgi:application 
```

## 访问地址

- 前台首页：http://localhost:8000/
- 管理后台：http://localhost:8000/admin/
- API文档：http://localhost:8000/api/docs/

## 目录结构

```
IMooc/
├── chat/           # 聊天室应用
├── comments/       # 评论系统
├── IMooc/          # 项目配置
├── media/         # 上传文件
├── static/        # 静态文件
├── stats/         # 数据统计
├── templates/     # 模板文件
├── users/         # 用户管理
├── videos/        # 视频系统
├── manage.py      # 管理脚本
└── requirements.txt # 项目依赖
```

## 开发团队

- 开发者：[您的名字]
- 联系方式：[您的邮箱]

## 许可证

MIT License 