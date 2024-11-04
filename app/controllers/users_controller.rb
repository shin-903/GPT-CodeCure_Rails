class UsersController < ApplicationController

  require 'jwt'

  before_action :authenticate_user, except: [ :create, :login ]

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
        token: token,
        # userに紐づいたpostsも一緒に返す
        # posts: user.posts,
        posts: user.posts.as_json(include: :tags),
        # ユーザー情報を返す（IDを含む）
        user: {
          id: user.id,        # ユーザーIDを追加
          name: user.name,
          email: user.email
        }
        
      }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def show
    user = User.find(params[:id])

    if user
      render json: {
        user: user,
        posts: user.posts # userに紐づいたpostsも一緒に返す
      }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  rescue StandardError => e
    render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
  end


  # PATCH /user
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { message: "User updated successfully", user: user }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /user
  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { message: "User deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete user" }, status: :unprocessable_entity
    end
  end



  private

  # Strong parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # JWTトークンを生成するメソッド
  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  # # JWTトークンをデコードしてユーザーを特定する（認証に使用）
  # def decoded_token(token)
  #   begin
  #     JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')[0]
  #   rescue JWT::DecodeError
  #     nil
  #   end
  # end

  # # JWTを用いてユーザー認証を行う (before_action)
  # def authenticate_user
  #   token = request.headers['Authorization']&.split(' ')&.last
  #   decoded_payload = decoded_token(token)

  #   if decoded_payload.nil?
  #     render json: { error: 'Unauthorized' }, status: :unauthorized
  #     return
  #   end
    
  #   #正しく認証された場合、@current_userにユーザー情報を格納
  #   @current_user = User.find_by(id: decoded_payload['user_id'])

  #   if @current_user.nil?
  #     render json: { error: 'User not found' }, status: :not_found
  #   end
  # end

end