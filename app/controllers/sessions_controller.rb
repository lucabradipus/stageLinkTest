class SessionsController < ApplicationController
  def create
    auth =  request.env['omniauth.auth']['credentials']
    session[:oauth_token] = auth['token']
    redirect_to root_url
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to root_url
  end


end
