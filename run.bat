@echo off
echo 正在激活虚拟环境...
call .venv\Scripts\activate

echo 正在启动服务器...
python manage.py runserver

pause 