class FbAnalyzerController < ApplicationController
  def index
    @user = User.koala(session[:oauth_token]) if session[:oauth_token]
  end

  def extract
    fb_post = FbPost.new(params['pages'], session[:oauth_token])
    respond_to do |format|
      if fb_post.valid?
        format.html { @post_in_pages = fb_post.get_interactions }
        format.csv { send_data fb_post.to_csv }
      else
        flash[:error] = fb_post.errors.full_messages.to_sentence
        redirect_to :root
      end
    end
  rescue Koala::Facebook::ServerError, Koala::Facebook::ClientError => ex
    flash[:error] = ex.message
    redirect_to :root
  end
end

