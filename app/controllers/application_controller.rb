class ApplicationController < ActionController::API
    # before_action :authorized
  
    # def authorized
    #   token = request.headers['Authorization']
    #   decoded = decoded_token(token)
    #   if decoded
    #     @current_user = User.find_by(id: decoded['user_id'])
    #   else
    #     render json: { error: 'Unauthorized access' }, status: :unauthorized
    #   end
    # end
  end