require 'rails_helper'

RSpec.describe FbPost, type: :model do
  before do
    body =JSON.parse(File.open('spec/fixtures/graph_raw_data.txt').read)
    stub_request(:get, "https://graph.facebook.com/v2.8/fake_page1?access_token=fake_token&fields=posts.limit(fake_limit1)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200,:body => body  , :headers => {})
    stub_request(:get, "https://graph.facebook.com/v2.8/fake_page2?access_token=fake_token&fields=posts.limit(fake_limit2)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.10.1'}).
      to_return(:status => 200, :body => body, :headers => {})

  end
  it "return a correct csv files when called with one page" do
    csv = FbPost.to_csv("fake_token",["fake_page1"],["fake_limit1"])
    expect(csv).to include("fake_page1")
  end
  it "return a correct csv files when called with two pages" do
    csv = FbPost.to_csv("fake_token",["fake_page1", "fake_page2"],["fake_limit1", "fake_limit2"])
    expect(csv).to include("fake_page1")
    expect(csv).to include("fake_page2")
  end

end
