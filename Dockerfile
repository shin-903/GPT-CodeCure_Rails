# ベースイメージを指定
FROM ruby:3.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリを作成
WORKDIR /app

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /app

# ポート3000でアプリを起動
EXPOSE 3000

# コンテナ起動時にRailsサーバーを実行
CMD ["rails", "server", "-b", "0.0.0.0"]
