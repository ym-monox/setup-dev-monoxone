@echo off
rem --- 環境変数を読み込む ---
setlocal
if exist config.env (
    for /f "tokens=1,2 delims==" %%A in (config.env) do set %%A=%%B
) else (
    echo config.env が見つかりません。環境変数を設定してください。
    pause
    exit /b
)

rem --- Docker Desktop を起動 ---
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

rem --- WSLでUbuntuを起動し、環境変数を使って開発環境をセットアップ ---
wsl --distribution %WSL_DISTRO% --user %WSL_USER% bash -ic " \
    cd %PROJECT_PATH% && \
    if [ '%USE_VSCODE%' = 'true' ]; then code .; fi && \
    docker-compose up -d && \
    docker-compose exec %DOCKER_WEB_CONTAINER% bash -c 'npm run dev'"

echo Development environment is starting...
pause
