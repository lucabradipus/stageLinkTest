def fake_data
  JSON.parse(File.open('spec/fixtures/graph_raw_data.txt').read)
end


Before do |scenario|
  Rails.logger.debug "Starting scenario: #{scenario.name}"

  stub_request(:get, "https://graph.facebook.com/v2.8/me?access_token=fake_token&fields=id,name").
    to_return(:status => 200, :body => "{ \"id\": \"111111111111111\", \"name\": \"Example User\"}", :headers => {})

  stub_request(:get, "https://graph.facebook.com/v2.8/first_page0?access_token=fake_token&fields=posts.limit(10)%7Btype,reactions.limit(100),comments.limit(100)%7D").
    to_return(:status => 200, :body => fake_data, :headers => {})
  stub_request(:get, "https://graph.facebook.com/v2.8/first_page1?access_token=fake_token&fields=posts.limit(11)%7Btype,reactions.limit(100),comments.limit(100)%7D").
    to_return(:status => 200, :body => fake_data, :headers => {})

end

Given(/^I am logged in$/) do
  visit root_path
  find_link('sign_in').click
end

Then(/^I can add more lines to the form$/) do
  find('button', class: 'btn-add').click
end

Then(/^I can fill page id with pageid (\w+) and limit (\d+)$/) do |arg1, arg2|
  # sleep(100)
  expect { page.find('button', text: 'Export to CSV', class: 'disabled') }.not_to raise_error

  all('input[name="pages[][id]"]').each_with_index do |p, i|
    p.set("#{arg1}#{i}")
  end
  all('input[name="pages[][limit]"]').each_with_index do |p, i|
    p.set("#{arg2.to_i+i}")
  end
  expect { page.find('button', text: 'Export to CSV', class: 'disabled') }.to raise_error(Capybara::ElementNotFound)
  expect(page.response_headers["Content-Type"]).to match(/text\/html/)
  find('button', text: 'Export to CSV').click
  expect(page.response_headers["Content-Type"]).to match(/application\/octet-stream/)

end

Then(/^I  can export a csv file$/) do

end


Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I am not yet logged in$/) do
  find_link('sign_in')
end

Then(/^I can log in$/) do
  find_link('sign_in').click
end

Then(/^I can see the query form$/) do
  visit root_path
  find('button', text: 'Export to CSV')
end
