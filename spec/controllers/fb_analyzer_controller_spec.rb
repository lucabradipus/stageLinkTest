require 'rails_helper'
require 'stub_helper'
OmniAuth.config.test_mode = true

RSpec.describe FbAnalyzerController, type: :controller do

  stub_fb_analyzer_controller
  describe "POST #extract" do
    it "returns reactions and comments for all the post in a single page" do
      post :extract, params: single_page_request, session: valid_session
        expect(assigns(:post_in_pages).length).to eq(337)
    end

    it "returns reactions and comments for all the post in a two pages" do
      post :extract, params: two_pages_request, session: valid_session
      expect(assigns(:post_in_pages).length).to eq(674)

    end
  end
  describe "GET #index" do
      it "returns a valid user" do
        get :index, session: valid_session
        expect(assigns(:user)['id']).to eq("111111111111111")
      end

  end

end
