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



Given(/^I am logged in$/) do
  visit root_path
  stub_request(:get, "https://graph.facebook.com/v2.8/me?access_token=fake_token&fields=id,name").
    to_return(:status => 200, :body => "{ \"id\": \"111111111111111\", \"name\": \"Example User\"}", :headers => {})
  find_link('sign_in').click
end

Then(/^I can add more lines to the form$/) do
  find('button', class: 'btn-add').click
end


Then(/^I can fill page id with pageid (\w+) and limit (\d+)$/) do |arg1, arg2|
  # sleep(100)
  all('input[name="pages[][id]"]').each_with_index do |p, i|
    p.set("#{arg1}#{i}")
  end
  all('input[name="pages[][limit]"]').each_with_index do |p, i|
    p.set("#{arg2.to_i+i}")
  end
end

Then(/^I  can export a csv file$/) do
  find('button', text: 'Export to CSV').click
end

# expect(page.response_headers).to eq("application/csv")
