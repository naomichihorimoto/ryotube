# プロジェクト環境情報

## Docker環境

このプロジェクトはDocker Composeを使用した開発環境で動作しています。

### サービス構成

- **web**: Ruby on Railsアプリケーション (ポート3000)
  - Ruby最新版
  - Node.js, PostgreSQLクライアントを含む
  - 作業ディレクトリ: `/app`

- **db**: PostgreSQL 18データベース (ポート5432)
  - データベース名: `ryotube_development`
  - ユーザー: `postgres`
  - パスワード: `password`

### 重要な注意事項

1. **コマンド実行**: アプリケーション関連のコマンド（Rails、bundle、migrateなど）は、webコンテナ内で実行する必要があります。
   ```bash
   docker compose exec web <command>
   ```

2. **データベース操作**: データベース関連のコマンドもwebコンテナ経由で実行します。
   ```bash
   docker compose exec web rails db:migrate
   ```

3. **ボリューム**:
   - アプリケーションコードは `.:/app` でマウント
   - gemは `bundle_cache` ボリュームにキャッシュ
   - PostgreSQLデータは `postgres_data` ボリュームに永続化

4. **環境起動**:
   ```bash
   docker compose up
   ```
