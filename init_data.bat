@echo off
echo 正在激活虚拟环境...
call .venv\Scripts\activate

echo 正在导入数据库...
mysql -u root -p imooc < imooc.sql

echo 创建超级管理员...
python manage.py createsuperuser

pause 