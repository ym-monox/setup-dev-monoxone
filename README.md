# SETUP-DEV-MONOXONE

このプロジェクトは、DockerとWSLを使用してMONO-X One(他プロジェクトに拡張可能)の開発環境をセットアップするためのものです。
config.envをカスタマイズしてご利用ください。

## 必要条件

- Docker Desktop
- WSL (Windows Subsystem for Linux)
- Ubuntu (WSLディストリビューション)

## セットアップ手順

1. **環境変数の設定**
   - `config.env`ファイルを作成し、以下の内容を含めます。`config.example.env`を参考にしてください。

   ```env
   WSL_DISTRO=Ubuntu
   WSL_USER=your-username
   PROJECT_PATH=/home/your-username/source/repos/apibridge
   DOCKER_WEB_CONTAINER=web
   USE_VSCODE=true
   ```

2. **開発環境の起動**
   - `setup-dev-monoxone.bat`を実行します。このバッチファイルは、必要な環境変数を読み込み、Docker Desktopを起動し、WSLで開発環境をセットアップします。

   ```bash
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
   ```

## 使用方法

- 開発環境が起動したら、必要に応じてコードを編集し、Dockerコンテナ内でアプリケーションを実行できます。

## 注意事項

- 環境変数は、プロジェクトの要件に応じて適切に設定してください。
- DockerとWSLのインストールが正しく行われていることを確認してください。
