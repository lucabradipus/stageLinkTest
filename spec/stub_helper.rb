def fake_data
  JSON.parse(File.open('spec/fixtures/graph_raw_data.txt').read)
end

def stub_fb_analyzer_controller
  let(:single_page_request) {
    {pages: [{"id" => "107840939393927", "limit" => "11"}]}
  }

  let(:two_pages_request) {
    {pages: [{"id" => "107840939393927", "limit" => "11"}, {"id" => "249403588440524", "limit" => "10"}]}
  }

  let(:valid_session) { {oauth_token: "fake_token"} }

  before do

    stub_request(:get, "https://graph.facebook.com/v2.8/me?access_token=fake_token&fields=id,name").
      to_return(:status => 200, :body => "{ \"id\": \"111111111111111\", \"name\": \"Example User\"}", :headers => {})


    stub_request(:get, "https://graph.facebook.com/v2.8/107840939393927?access_token=fake_token&fields=posts.limit(11)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200, :body => fake_data, :headers => {})
    stub_request(:get, "https://graph.facebook.com/v2.8/249403588440524?access_token=fake_token&fields=posts.limit(10)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200, :body => fake_data, :headers => {})

  end

end

def stub_fb_post
  let(:single_page) {
    [{"id" => "107840939393927", "limit" => "11"}]
  }

  let(:two_pages) {
    [{"id" => "107840939393927", "limit" => "11"}, {"id" => "207840939393927", "limit" => "10"}]
  }


  before do
    stub_request(:get, "https://graph.facebook.com/v2.8/107840939393927?access_token=fake_access_token&fields=posts.limit(11)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      to_return(:status => 200, :body => fake_data, :headers => {})
    stub_request(:get, "https://graph.facebook.com/v2.8/207840939393927?access_token=fake_access_token&fields=posts.limit(10)%7Btype,reactions.limit(100),comments.limit(100)%7D").
      with(:headers => {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Faraday v0.10.1'}).
      to_return(:status => 200, :body => fake_data, :headers => {})
  end
end
