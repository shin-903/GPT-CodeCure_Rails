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
    email = "test-#{n+1}@example.com"
    password = "password"
    User.create!(name:  name,
                             email: email,
                             password:              password,
                             password_confirmation: password,
                             # activated: true,
                             # activated_at: Time.zone.now
                            )
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each do |user|
        post = user.posts.create!(title: "Sample Title", content: content)
        # post.tags.create!(name: "Sample Tag")
    end
end


