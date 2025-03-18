# GPT CodeCure

GPT CodeCureは、エンジニアが開発中に発生するエラーや問題に対する解決策を簡単に共有できるSNSアプリケーションです。このプラットフォームを通じて、エンジニアはChatGPTから得た解決策を投稿し、他のエンジニアと情報をシェアすることで、効率的なトラブルシューティングをサポートします。

## コンセプト

開発中に発生したエラーを解決する際、通常はWeb上で検索し、自力で記事を参照して対策を見つける必要がありますが、これには時間がかかる場合があります。GPT CodeCureは、以下の目的で設計されています。

- ChatGPTから得た解決策を即座に投稿し、他のエンジニアにも役立つ情報として共有できる
- 投稿数が増加することで、同じエラーに悩むエンジニアが素早く解決策を発見しやすくなる
- エンジニア同士が知見を交換し、効率的に開発を進められるコミュニティの構築

## 主な機能

- **投稿機能**：ChatGPTの解決策に限らず、エンジニア自身が発見した解決方法や知見も自由に投稿し、コミュニティと共有できます。
- **フィードの閲覧**：他のエンジニアが投稿したエラー解決策を簡単に参照でき、類似の問題に迅速に対処できます。
- **ChatGPTとの連携**：アプリ内の入力フォームから直接ChatGPTに質問し、リアルタイムで解決策を取得できます。得られた解決策は、そのまま記事として投稿し、他のエンジニアと共有することが可能です。

## 技術スタック

- **フロントエンド**：React  
- **バックエンド**：Ruby on Rails
- **データベース**：PostgreSQL  
- **その他API**：OpenAI API 
- **Docker**：Dockerを用いて開発環境を構築し、一貫性のある環境での開発を実現  

## セットアップ方法

1. リポジトリをクローンします。

    ```bash
    git clone https://github.com/shin-903/GPT-CodeCure_React.git
    git clone https://github.com/shin-903/GPT-CodeCure_Rails.git
    ```

2. 必要なパッケージをインストールします。

    ```bash
    # フロントエンド
    cd GPT-CodeCure_React
    npm install

    # バックエンド
    cd ../GPT-CodeCure_Rails
    bundle install
    ```

3. Dockerを使ってアプリケーションを起動します。

    ```bash
    docker-compose up
    ```

4. ブラウザで`http://localhost:3000`にアクセスしてアプリケーションを確認します。

## GitHub リンク

- **フロントエンド**： [https://github.com/shin-903/GPT-CodeCure_React.git](https://github.com/shin-903/GPT-CodeCure_React.git)
- **バックエンド**： [https://github.com/shin-903/GPT-CodeCure_Rails.git](https://github.com/shin-903/GPT-CodeCure_Rails.git)


## 今後の展望

今後は、検索機能や、役に立った記事をお気に入りとして保存する機能、記事の評価機能などを追加し、より多くのエンジニアが効率的に問題解決できる環境を目指して改善していく予定です。
