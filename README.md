# Readify

Readify は、読んだ本の進捗や感想などを記録・管理するための、シンプルで使いやすい Web アプリケーションです。

## 主な機能

- **本の検索**: Google Books API を使用して、世界中の本を検索できます
- **読書記録**: 読書中の本の進捗を記録し、読了状況を管理できます
- **統計情報**: 登録本数、読了済み冊数、読書中の冊数などを一目で確認できます
- **ユーザー認証**: Devise を使用した安全なユーザー認証機能

## 技術スタック

- **フレームワーク**: Rails 8.0.1
- **データベース**: PostgreSQL
- **CSS フレームワーク**: Tailwind CSS
- **認証**: Devise
- **Web 検索 API**: Google Books API

## セットアップ

### 前提条件

- Ruby 3.x
- PostgreSQL
- Node.js（Tailwind CSS コンパイル用）

### インストール

```bash
# リポジトリをクローン
git clone https://github.com/taka-y-0820/readify.git
cd readify

# 依存gemをインストール
bundle install

# Nodeの依存パッケージをインストール
yarn install

# データベースをセットアップ
rails db:create
rails db:migrate
rails db:seed

# 環境変数をセットアップ
# .envファイルを作成し、GOOGLE_BOOKS_API_KEYを設定してください
cp .env.example .env
# .envを編集して、GOOGLE_BOOKS_API_KEYを追加
```

### 開発サーバーの起動

```bash
./bin/dev
```

アプリケーションは http://localhost:3000 で起動します。

## ユーザーガイド

### アカウント作成

1. ホームページの「新規登録」ボタンをクリック
2. メールアドレスとパスワードを入力
3. 「新規登録」をクリック

### 本を追加

1. 「本を探す」ページにアクセス
2. 検索フォームで本のタイトルまたは著者名を入力
3. 「検索」ボタンをクリック
4. 表示された本の「読書リストに追加」ボタンをクリック

### 読書進捗を更新

1. 「マイリスト」ページから本を選択
2. 「編集」ボタンをクリック
3. スライダーで進捗を調整するか、直接パーセンテージを入力
4. 「読了済みにする」チェックボックスで完了状態を設定
5. 「更新」ボタンをクリック

### 本を削除

1. 「マイリスト」ページから本を選択
2. 「削除」ボタンをクリック
3. 確認ダイアログで「OK」をクリック

## API 設定

### Google Books API キーの取得

1. [Google Cloud Console](https://console.cloud.google.com/)にアクセス
2. 新規プロジェクトを作成
3. Google Books API を有効化
4. API キーを生成
5. `.env`ファイルに以下のように設定:

```
GOOGLE_BOOKS_API_KEY=your_api_key_here
```

## テスト実行

```bash
# 全テストを実行
rails test

# 特定のテストを実行
rails test test/models/book_test.rb
```

## ディレクトリ構造

```
.
├── app/
│   ├── controllers/       # コントローラーファイル
│   ├── models/            # モデルファイル
│   ├── views/             # ビューテンプレート
│   ├── services/          # ビジネスロジック
│   ├── helpers/           # ビューヘルパー
│   └── jobs/              # バックグラウンドジョブ
├── config/                # 設定ファイル
├── db/                    # マイグレーションファイル
├── test/                  # テストファイル
└── public/                # 静的ファイル
```

## 主な改善点

- ✅ ReadingsController の作成と機能の充実
- ✅ モデルの関連付けと検証の追加
- ✅ Google Books Service のバグ修正
- ✅ UI/UX の大幅改善（Tailwind CSS を活用）
- ✅ 認証機能の実装と保護されたルート
- ✅ 読書統計情報の表示
- ✅ ユーザーの使いやすさに配慮したデザイン

## 今後実装予定の機能

- [ ] 読書感想・レビュー機能
- [ ] ソーシャル機能（友人とのリスト共有など）
- [ ] 高度な検索・フィルター機能
- [ ] 月間読書目標の設定
- [ ] モバイルアプリ化
- [ ] 複数言語対応
- [ ] PDF エクスポート機能

## トラブルシューティング

### Google Books API が機能しない場合

- API キーが正しく設定されているか確認
- API キーに実装制限がないか確認
- Google Books API が有効になっているか確認

### データベースエラーが出る場合

```bash
# データベースをリセット
rails db:drop
rails db:create
rails db:migrate
```

## ライセンス

MIT License

## 作成者

- [taka-y-0820](https://github.com/taka-y-0820)

## サポート

問題が発生した場合は、GitHub の Issues で報告してください。

---

**Happy Reading!** 📚
