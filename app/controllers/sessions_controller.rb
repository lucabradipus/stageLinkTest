class SessionsController < ApplicationController
  def create
    auth =  request.env['omniauth.auth']['credentials']
    session[:oauth_token] = auth['token']
    redirect_to root_url
  end

  def destroy
    reset_session
    redirect_to root_url
  end


end
