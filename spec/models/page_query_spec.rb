require 'rails_helper'

RSpec.describe PageQuery, type: :model do

  it "instantiates an object when parameters are correct" do
    page_q = PageQuery.new('fake_page1', 10, "fake_access_token")
    expect(page_q).to be_valid
  end

  it "returns error when page_id is not correct" do
    page_q = PageQuery.new('???', 10, "fake_access_token")
    expect(page_q).to be_invalid
  end

  it "returns error when limit is not correct" do
    page_q = PageQuery.new('fake_page1', 'aaa', "fake_access_token")
    expect(page_q).to be_invalid
    page_q = PageQuery.new('fake_page1', 101, "fake_access_token")
    expect(page_q).to be_invalid
    page_q = PageQuery.new('fake_page1', -10, "fake_access_token")
    expect(page_q).to be_invalid
  end

  it "returns error when there is no access token" do
    page_q = PageQuery.new('fake_page1', 'aaa', "")
    expect(page_q).to be_invalid
  end

end
