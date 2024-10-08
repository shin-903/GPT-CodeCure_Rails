class UsersController < ApplicationController
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

  private

  # Strong parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
