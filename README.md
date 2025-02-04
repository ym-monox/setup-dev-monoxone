#setup-dev-monoxone.bat 

## **概要**  
このバッチファイル（`setup-dev-monoxone.bat`）は、Windows 上で開発環境を自動的にセットアップするためのスクリプトです。Docker Desktop の起動、WSL（Ubuntu）の起動、および開発に必要なコマンドの実行を一括で行います。

---

## **動作内容**  
1. **Docker Desktop の起動**  

   - `C:\Program Files\Docker\Docker\Docker Desktop.exe` を実行し、Docker Desktop を起動します。  

2. **WSL（Ubuntu）の起動と初期化**  
   - `wsl --distribution Ubuntu --user ym` により、指定したユーザー (`ym`) で WSL（Ubuntu）を起動します。  
   - Ubuntu 内で、開発プロジェクトのディレクトリ `/home/ym/source/repos/apibridge` に移動します。  

3. **VS Code の起動**  
   - `code .` を実行し、VS Code をカレントディレクトリで開きます。  

4. **Docker コンテナの起動**  
   - `docker-compose up -d` を実行し、定義されたコンテナをバックグラウンドで起動します。  

5. **開発環境の初期化**  
   - `docker-compose exec web bash -c 'npm run dev'` を実行し、`web` コンテナ内で `npm run dev` を実行して開発環境を開始します。  

6. **完了メッセージの表示**  
   - `Development environment is starting...` というメッセージを表示し、ユーザー入力待ち (`pause`) になります。  

---

## **使用方法**  
1. **バッチファイルを実行する**  

   - `setup-dev-monoxone.bat` をダブルクリックするか、コマンドプロンプトまたは PowerShell で以下のコマンドを実行します。  
     ```sh
     setup-dev-monoxone.bat
     ```

2. **開発環境のセットアップが完了するのを待つ**  
   - スクリプトの指示に従い、処理が完了するのを待ちます。  

---

## **前提条件**  
このスクリプトを正しく実行するためには、以下のソフトウェアがインストールされている必要があります。  


- **Windows 10/11（WSL2対応）**  
- **WSL（Ubuntu）** がセットアップ済みであること  
- **Docker Desktop**（Windows で WSL2 バックエンドを有効にする必要あり）  
- **Visual Studio Code**（`code` コマンドが使用できること）  
- **Docker Compose**（プロジェクトで `docker-compose.yml` が正しく設定されていること）  
- **Node.js（npm）**（`web` コンテナ内で `npm run dev` を実行するため）  

---

## **カスタマイズ方法**  
- `ym` を他の WSL ユーザーに変更したい場合は、以下の部分を修正してください。  
  ```sh

  wsl --distribution Ubuntu --user <your-username>
  ```
- プロジェクトのディレクトリを変更する場合は、以下の部分を修正してください。  
  ```sh
  cd /home/ym/source/repos/apibridge
  ```
- 実行するコマンドを変更したい場合は、`docker-compose exec web bash -c 'npm run dev'` の部分を適宜変更してください。  

---

## **トラブルシューティング**  
- **スクリプトが正しく動作しない場合**  
  1. **Docker Desktop が起動しているか確認**  

     ```sh
     docker info
     ```
  2. **WSL2 が正しく動作しているか確認**  
     ```sh
     wsl -l -v
     ```
  3. **`docker-compose.yml` の設定が正しいか確認**  
  4. **スクリプトのパスが正しく設定されているか確認**  

- **「code: command not found」というエラーが出る場合**  
  - Visual Studio Code の WSL インストールが適切でない可能性があります。  
    ```sh
    code .
    ```
  - これが実行できない場合、VS Code を再インストールし、WSL に拡張機能を追加してください。

---

## **ライセンス**
このスクリプトは自由にカスタマイズ・再配布可能です。