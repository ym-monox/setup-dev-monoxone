@echo off
setlocal enabledelayedexpansion

rem ���ϐ��t�@�C���̓ǂݍ���
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

rem ���ϐ��̐ݒ�m�F�i���ݒ�̏ꍇ�̓G���[�j
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

rem ���ϐ��̒l��\��
echo Using the following configuration:
echo Docker Desktop Path: %DOCKER_DESKTOP_PATH%
echo WSL Distribution: %WSL_DISTRO%
echo WSL User: %WSL_USER%
echo Project Path: %PROJECT_PATH%
echo NPM Script: %NPM_SCRIPT%
echo.

rem Docker Desktop�����݂��邩�m�F
if not exist "%DOCKER_DESKTOP_PATH%" (
    echo Error: Docker Desktop not found at %DOCKER_DESKTOP_PATH%
    pause
    exit /b 1
)

rem Docker Desktop ���N��
echo Starting Docker Desktop...
start "" "%DOCKER_DESKTOP_PATH%"

rem Docker Desktop�̋N����ҋ@
echo Waiting for Docker Desktop to start...
timeout /t 10 /nobreak

rem WSL�f�B�X�g���r���[�V���������p�\���m�F
wsl --distribution %WSL_DISTRO% echo "Checking WSL distribution..." > nul 2>&1
if %errorlevel% neq 0 (
    echo Error: WSL distribution %WSL_DISTRO% is not available
    pause
    exit /b 1
)

rem WSL�Ńv���W�F�N�g���N��
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
