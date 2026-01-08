class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  # LOGIN PAGE
  def new
    # empty on purpose (sirf view render karega)
  end

  # LOGIN ACTION
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      cookies.signed[:jwt] = { value: token, httponly: true }

      redirect_to movies_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  # LOGOUT
  def destroy
    cookies.delete(:jwt)
    redirect_to login_path, notice: "Logged out successfully"
  end
end
