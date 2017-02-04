class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def current_user
    @current_user ||=  OpenStruct.new(User.koala(session[:oauth_token])) if session[:oauth_token]

  end
  helper_method :current_user

end
