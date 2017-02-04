require 'rails_helper'
OmniAuth.config.test_mode = true

RSpec.describe FbAnalyzerController, type: :controller do

  let(:single_page_request) {
    pages = %w(fake_page1)
    limits = %w(fake_limit1)
    {pages: pages, limits: limits}
  }
  let(:two_pages_request) {
    pages = %w(fake_page1 fake_page2)
    limits = %w(fake_limit1 fake_limit2)
    {pages: pages, limits: limits}
  }

  let(:valid_session) { {oauth_token: "fake_token"} }
  before do


    stub_request(:get, "https://graph.facebook.com/v2.8/me?access_token=fake_token&fields=id,name").
      to_return(:status => 200, :body => "{ \"id\": \"111111111111111\", \"name\": \"Example User\"}", :headers => {})


    body =JSON.parse(File.open('spec/fixtures/graph_raw_data.txt').read)
    stub_request(:get, "https://graph.facebook.com/v2.8/fake_page1?access_token=fake_token&fields=posts.limit(fake_limit1)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200,:body => body  , :headers => {})
    stub_request(:get, "https://graph.facebook.com/v2.8/fake_page2?access_token=fake_token&fields=posts.limit(fake_limit2)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200, :body => body, :headers => {})

  end
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
