module JwtAuthenticable
  extend ActiveSupport::Concern

  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET, 'HS256')
  end

  def decoded_token
    token = cookies.signed[:jwt]
    return nil unless token

    JWT.decode(token, JWT_SECRET, true, algorithm: 'HS256')
  rescue JWT::DecodeError
    nil
  end

  def current_user
    return nil unless decoded_token

    user_id = decoded_token[0]["user_id"]
    @current_user ||= User.find_by(id: user_id)
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "Please login first"
    end
  end
end
