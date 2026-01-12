class ApplicationController < ActionController::Base
  include JwtAuth
  helper_method :current_user
end
