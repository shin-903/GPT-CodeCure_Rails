class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }
end