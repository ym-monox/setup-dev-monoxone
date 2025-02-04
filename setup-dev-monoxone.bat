@echo off
rem Docker Desktop を起動
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

rem WSLでUbuntuを起動し、コマンドを実行
wsl --distribution Ubuntu --user ym bash -ic "cd /home/ym/source/repos/apibridge && code . && docker-compose up -d && docker-compose exec web bash -c 'npm run dev'"

echo Development environment is starting...
pause
