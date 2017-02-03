class FbAnalyzerController < ApplicationController
  def index
    @user = User.koala(session[:oauth_token]) if session[:oauth_token]
  end

  def extract
    if session[:oauth_token]
      pages = params['pages']
      limits = params['limits']
      pages.size.times do |index|
        @post_in_pages = FbPost.posts_in_page(session[:oauth_token], pages[index], limits[index])
      end
    end
    logger.info("POST: #{@post_in_pages}")
  end
end
