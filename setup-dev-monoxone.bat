@echo off
rem --- ���ϐ���ǂݍ��� ---
setlocal
if exist config.env (
    for /f "tokens=1,2 delims==" %%A in (config.env) do set %%A=%%B
) else (
    echo config.env ��������܂���B���ϐ���ݒ肵�Ă��������B
    pause
    exit /b
)

rem --- Docker Desktop ���N�� ---
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

rem --- WSL��Ubuntu���N�����A���ϐ����g���ĊJ�������Z�b�g�A�b�v ---
wsl --distribution %WSL_DISTRO% --user %WSL_USER% bash -ic " \
    cd %PROJECT_PATH% && \
    if [ '%USE_VSCODE%' = 'true' ]; then code .; fi && \
    docker-compose up -d && \
    docker-compose exec %DOCKER_WEB_CONTAINER% bash -c 'npm run dev'"

echo Development environment is starting...
pause
