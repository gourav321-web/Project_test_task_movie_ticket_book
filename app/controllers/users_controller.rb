class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token({ user_id: @user.id })
      cookies.signed[:jwt] = { value: token, httponly: true }

      UserMailer.welcome_email(@user).deliver_later
      redirect_to movies_path, notice: "Account created successfully"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_picture)
  end
end
