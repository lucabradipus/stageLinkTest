class FbAnalyzerController < ApplicationController
  def index
    @user = User.koala(session[:oauth_token]) if session[:oauth_token]
  end

  def extract
    pages = params['pages']
    limits = params['limits']
    respond_to do |format|
      format.html { send_data FbPost.posts_in_pages(session[:oauth_token], pages, limits) }
      format.csv { send_data FbPost.to_csv(session[:oauth_token], pages, limits) }
    end
  rescue Koala::Facebook::ServerError, Koala::Facebook::ClientError => ex
    flash[:error] = ex.message
    redirect_to :root
  end
end

