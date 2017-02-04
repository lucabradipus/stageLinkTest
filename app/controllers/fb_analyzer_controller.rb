class FbAnalyzerController < ApplicationController
  def index
    @user = User.koala(session[:oauth_token]) if session[:oauth_token]
  end

  def extract
    if session[:oauth_token]
      pages = params['pages']
      limits = params['limits']
      @post_in_pages = FbPost.posts_in_pages(session[:oauth_token], pages, limits)

    end
    logger.info("POST: #{@post_in_pages}")
    respond_to do |format|
      format.html
      format.csv { send_data FbPost.to_csv(@post_in_pages) }
    end
  rescue Koala::Facebook::ServerError, Koala::Facebook::ClientError => ex
    flash[:error] = ex.message
    redirect_to :root
  end
end

