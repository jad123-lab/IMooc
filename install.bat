@echo off
echo 正在创建虚拟环境...
python -m venv .venv

echo 正在激活虚拟环境...
call .venv\Scripts\activate

echo 正在安装依赖...
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple django==5.0.2
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple channels
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple daphne
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pillow
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple mysqlclient

echo 正在执行数据库迁移...
python manage.py makemigrations
python manage.py migrate

echo 环境安装完成！
pause 