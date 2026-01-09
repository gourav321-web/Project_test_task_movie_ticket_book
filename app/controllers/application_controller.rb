class ApplicationController < ActionController::Base
  include JwtAuthenticable
  helper_method :current_user
end
