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

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end





























# gem 'sidekiq'
# gem 'redis'

# bundle install

# sudo apt update
# sudo apt install redis-server -y

# sudo systemctl enable redis-server
# sudo systemctl start redis-server

# redis-cli ping

# config.active_job.queue_adapter = :sidekiq



# Sidekiq initializer

# config/initializers/sidekiq.rb create karo:

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end