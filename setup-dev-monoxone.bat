@echo off
rem Docker Desktop ���N��
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

rem WSL��Ubuntu���N�����A�R�}���h�����s
wsl --distribution Ubuntu --user ym bash -ic "cd /home/ym/source/repos/apibridge && code . && docker-compose up -d && docker-compose exec web bash -c 'npm run dev'"

echo Development environment is starting...
pause
