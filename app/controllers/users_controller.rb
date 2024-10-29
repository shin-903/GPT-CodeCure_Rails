class UsersController < ApplicationController

  require 'jwt'
  # SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  SECRET_KEY = 'gsirskfngsafjkgklsxzerfgbn'

  # POST /signup
  def create
    user = User.new(user_params)

    # メールの一意性を確認
    if User.exists?(email: user.email)
      render json: { error: 'Email already exists' }, status: :bad_request
      return
    end

    if user.save
      render json: {
        message: 'User created successfully',
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    # ユーザーが存在し、パスワードが一致するか確認
    if user && BCrypt::Password.new(user.password_digest) == params[:password]
      token = encode_token({ user_id: user.id })
      render json: {
        message: 'Login successful',
        token: token
      }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  # Strong parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # JWTトークンを生成するメソッド
  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  # JWTトークンをデコードしてユーザーを特定する（認証に使用）
  def decoded_token(token)
    begin
      JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      nil
    end
  end
end