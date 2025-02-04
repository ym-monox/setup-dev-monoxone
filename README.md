# batchfile for Setup Dev "MONMO-X One"

インターンで開発している"MONO-X One"（**他プロジェクトに拡張可能**）の開発環境を自動的にセットアップするためのスクリプトです。
WSL2、Docker、Node.jsの開発環境を自動的にセットアップするためのスクリプトです。VSCodeでプロジェクトを開き、Docker環境を立ち上げ、開発サーバーを起動します。

## 前提条件

以下のソフトウェアがインストールされている必要があります：

- Windows 10/11
- WSL2
- Ubuntu（WSL2）
- Docker Desktop for Windows
- Visual Studio Code（Cursorでも可）
- Node.js（WSL内）


## セットアップ手順

1. このリポジトリをクローンします：
   ```bash
   git clone https://github.com/ym-monox/setup-dev-monoxone.git
   cd setup-dev-monoxone
   ```


2. 環境変数ファイルを設定します：
   ```bash
   cp .env.example .env
   ```

3. `.env`ファイルを編集し、以下の項目を自分の環境に合わせて設定します：
   - `DOCKER_DESKTOP_PATH`: Docker Desktopの実行ファイルのパス
   - `WSL_DISTRO`: 使用するWSLディストリビューション名（デフォルト: Ubuntu）
   - `WSL_USER`: WSLで使用するユーザー名
   - `PROJECT_PATH`: WSL内のプロジェクトパス
   - `NPM_SCRIPT`: 実行するNPMスクリプト名（デフォルト: dev）

## 使用方法

1. `setup-dev-monoxone.bat`をダブルクリックで実行します。

2. スクリプトは以下の処理を順番に行います：
   - 環境変数の読み込みと検証
   - Docker Desktopの起動
   - WSLの起動
   - プロジェクトディレクトリでのVSCodeの起動
   - Dockerコンテナの起動
   - 開発サーバーの起動

3. ブラウザで開発サーバーにアクセスできます（通常は http://localhost:3000）

## エラー対応

### よくあるエラーと解決方法

1. **Docker Desktopが見つからない場合**
   - `.env`ファイル内の`DOCKER_DESKTOP_PATH`が正しく設定されているか確認してください。

2. **WSLディストリビューションにアクセスできない場合**
   - `WSL_DISTRO`の値が正しいか確認してください。
   - WSLがインストールされ、指定したディストリビューションが利用可能か確認してください。

3. **プロジェクトパスが見つからない場合**
   - WSL内の正しいプロジェクトパスを`PROJECT_PATH`に設定しているか確認してください。

## カスタマイズ

スクリプトは`.env`ファイルを通じて簡単にカスタマイズできます。主な設定項目：

```env
DOCKER_DESKTOP_PATH=C:\Program Files\Docker\Docker\Docker Desktop.exe
WSL_DISTRO=Ubuntu
WSL_USER=your-username
PROJECT_PATH=/home/your-username/project-path
NPM_SCRIPT=dev
```

## 貢献について

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. Pull Requestを作成

## ライセンス

このプロジェクトは[MITライセンス](LICENSE)の下で公開されています。
