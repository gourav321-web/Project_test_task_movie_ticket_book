class SessionsController < ApplicationController
  skip_forgery_protection
  def new
  end
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      cookies.signed[:jwt] = { value: token, httponly: true }
      redirect_to movies_path, notice: "Logged-in"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    cookies.delete(:jwt)
    redirect_to login_path, notice: "Logged-out"
  end
end