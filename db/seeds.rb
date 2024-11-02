# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# メインのサンプルユーザーを1人作成する
user = User.create!(name:  "Test User",
                    email: "test@example.com",
                    password:              "password",
                    password_confirmation: "password",
                    # admin:     true,
                    # activated: true,
                    # activated_at: Time.zone.now
                   )

# 追加のユーザーをまとめて生成する
99.times do |n|
    name  = Faker::Name.name
    email = "test#{n+1}@example.com"
    password = "password"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 # activated: true,
                 # activated_at: Time.zone.now
                )
end

# プログラミング言語に関するタイトルのリストを作成
programming_titles = [
  "Rubyでの効率的なデータ処理",
  "Railsを使ったWebアプリ開発",
  "JavaScriptの非同期処理入門",
  "Reactでのコンポーネント設計",
  "Dockerを用いた環境構築",
  "SQLによるデータベース設計",
  "Pythonでの機械学習の基礎",
  "CSSでのレスポンシブデザイン",
  "HTML5の新機能について",
  "AWSによるクラウドサービス入門",
  "Gitを使ったバージョン管理",
  "TypeScriptでの型安全な開発",
  "Node.jsでのサーバーサイド開発",
  "Vue.jsでのシングルページアプリケーション",
  "SwiftでのiOSアプリ開発",
  "KotlinによるAndroidアプリ作成",
  "Javaのオブジェクト指向プログラミング",
  "C++による高性能システム開発",
  "PHPでの動的ウェブサイト構築",
  "Goによるマイクロサービス設計",
  "Scalaでのビッグデータ解析",
  "R言語による統計データ分析",
  "Perlを使ったテキスト処理",
  "Rustによるメモリ安全な開発",
  "Elixirでのリアルタイムアプリ構築",
  "Djangoを使ったPythonのWeb開発",
  "LaravelでのPHPフレームワーク活用",
  "Flutterでのクロスプラットフォームアプリ",
  "Unityを用いたゲーム開発の基礎",
  "Machine LearningにおけるTensorFlow",
  "React Nativeでのモバイルアプリ作成",
  "Svelteによる軽量なフロントエンド開発",
  "GraphQLによるAPI設計の基本",
  "Kubernetesでのコンテナオーケストレーション",
  "Ansibleを使ったサーバー自動化",
  "Terraformでのインフラ構築",
  "C言語での低レベルプログラミング",
  "PowerShellを使ったWindows管理",
  "Bashスクリプトによるタスク自動化",
  "jQueryでのDOM操作テクニック",
  "BootstrapでのCSSフレームワーク活用",
  "Tailwind CSSでのユーティリティファーストデザイン",
  "Three.jsでの3Dコンテンツ制作",
  "Reduxによる状態管理",
  "RxJSでのリアクティブプログラミング",
  "Next.jsでのSSRと静的生成",
  "Nuxt.jsによるVue.jsの強化",
  "Expressを使ったNode.jsのAPI構築",
  "MeteorによるリアルタイムWebアプリ",
  "Haskellでの関数型プログラミング",
  "ClojureでのLISP言語基盤開発",
  "Elmによるフロントエンド開発",
  "WebAssemblyでの高速Webアプリ",
  "ASP.NET CoreによるC#開発",
  "Seleniumでのブラウザ自動テスト",
  "Pandasを使ったデータ解析",
  "Jupyter Notebookでのデータサイエンス",
  "Beautiful Soupを使ったスクレイピング",
  "Sparkによる分散データ処理",
  "Hadoopでのビッグデータ管理",
  "Blockchainとスマートコントラクト",
  "Firebaseによるリアルタイムデータベース",
  "Apollo ClientでのGraphQL通信"
]

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
30.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each do |user|
        # プログラミング言語に関するランダムなタイトルを選択
        title = programming_titles.sample
        post = user.posts.create!(title: title, content: content)
    end
end

# タグを生成する
tag_names = ["Ruby", "Rails", "JavaScript", "React", "Docker", "SQL", "Python", "CSS", "HTML", "AWS", "Git"]
tags = tag_names.map { |name| Tag.create!(name: name) }

# 各ポストにランダムなタグを追加する
posts = Post.all
posts.each do |post|
    assigned_tags = tags.sample(3)  # 3つのタグをランダムに選択
    assigned_tags.each do |tag|
        PostTag.create!(post: post, tag: tag)
    end
end
