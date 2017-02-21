Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I am not yet logged in$/) do
  find_link('sign_in')
end

Then(/^I can log in$/) do
  stub_request(:get, "https://graph.facebook.com/v2.8/me?access_token=fake_token&fields=id,name").
    to_return(:status => 200, :body => "{ \"id\": \"111111111111111\", \"name\": \"Example User\"}", :headers => {})
  find_link('sign_in').click
end

Then(/^see the query form$/) do
  find('form', id: "fan_collector")
  find_link('sign_out')
end
