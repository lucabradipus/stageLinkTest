require 'rails_helper'
require 'stub_helper'


RSpec.describe FbPost, type: :model do

  stub_fb_post
  it "return a correct csv files when called with one page" do
    fb_post = FbPost.new(single_page, 'fake_access_token')
    csv = fb_post.to_csv
    expect(csv).to include("107840939393927")
  end
  it "return a correct csv files when called with two pages" do
    fb_post = FbPost.new(two_pages, 'fake_access_token')
    csv = fb_post.to_csv
    expect(csv).to include("107840939393927")
    expect(csv).to include("207840939393927")
  end

end
