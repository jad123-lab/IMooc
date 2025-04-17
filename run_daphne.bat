@echo off
call .venv\Scripts\activate
daphne -b 0.0.0.0 -p 8001 IMooc.asgi:application 