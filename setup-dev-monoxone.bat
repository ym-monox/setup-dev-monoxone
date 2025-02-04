@echo off
setlocal enabledelayedexpansion

rem 環境変数ファイルの読み込み
if exist ".env" (
    echo Loading configuration from .env file...
    for /f "tokens=*" %%i in (.env) do (
        set "%%i"
    )
) else if exist ".env.example" (
    echo Warning: .env file not found, using .env.example instead
    for /f "tokens=*" %%i in (.env.example) do (
        set "%%i"
    )
) else (
    echo Error: No environment file found. Please create .env file based on .env.example
    pause
    exit /b 1
)

rem 環境変数の設定確認（未設定の場合はエラー）
if not defined DOCKER_DESKTOP_PATH (
    echo Error: DOCKER_DESKTOP_PATH is not set
    exit /b 1
)
if not defined WSL_DISTRO (
    echo Error: WSL_DISTRO is not set
    exit /b 1
)
if not defined WSL_USER (
    echo Error: WSL_USER is not set
    exit /b 1
)
if not defined PROJECT_PATH (
    echo Error: PROJECT_PATH is not set
    exit /b 1
)
if not defined NPM_SCRIPT (
    echo Error: NPM_SCRIPT is not set
    exit /b 1
)

rem 環境変数の値を表示
echo Using the following configuration:
echo Docker Desktop Path: %DOCKER_DESKTOP_PATH%
echo WSL Distribution: %WSL_DISTRO%
echo WSL User: %WSL_USER%
echo Project Path: %PROJECT_PATH%
echo NPM Script: %NPM_SCRIPT%
echo.

rem Docker Desktopが存在するか確認
if not exist "%DOCKER_DESKTOP_PATH%" (
    echo Error: Docker Desktop not found at %DOCKER_DESKTOP_PATH%
    pause
    exit /b 1
)

rem Docker Desktop を起動
echo Starting Docker Desktop...
start "" "%DOCKER_DESKTOP_PATH%"

rem Docker Desktopの起動を待機
echo Waiting for Docker Desktop to start...
timeout /t 10 /nobreak

rem WSLディストリビューションが利用可能か確認
wsl --distribution %WSL_DISTRO% echo "Checking WSL distribution..." > nul 2>&1
if %errorlevel% neq 0 (
    echo Error: WSL distribution %WSL_DISTRO% is not available
    pause
    exit /b 1
)

rem WSLでプロジェクトを起動
echo Starting development environment in WSL...
wsl --distribution %WSL_DISTRO% --user %WSL_USER% bash -ic ^
    "cd %PROJECT_PATH% && code . && docker-compose up -d && docker-compose exec web bash -c 'npm run %NPM_SCRIPT%'"

if %errorlevel% neq 0 (
    echo Error: Failed to start development environment
    pause
    exit /b 1
)

echo Development environment is starting...
echo Press any key to exit...
pause
