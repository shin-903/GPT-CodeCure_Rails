# application_controller.rb
class ApplicationController < ActionController::Base
  protected

  def decoded_token(token)
    begin
      # HS256アルゴリズム(サーバー内のsecret keyを使用)でトークンをデコード
      decoded = JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')
      decoded[0] # デコード結果のペイロード部分のみを返す
    rescue JWT::DecodeError
      nil
    end
  end

  def authenticate_user
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    if token.nil?
      render json: { error: 'Token missing' }, status: :unauthorized
      return
    end

    decoded_payload = decoded_token(token)
    # デコードされたペイロードがHashであり、user_idキーが存在するかを確認
    if decoded_payload.nil? || !decoded_payload.is_a?(Hash) || !decoded_payload.key?('user_id')
      render json: { error: 'Invalid token' }, status: :unauthorized
      return
    end

    @current_user = User.find_by(id: decoded_payload['user_id'])
    if @current_user.nil?
      render json: { error: 'User not found' }, status: :not_found
    end
  end
end
