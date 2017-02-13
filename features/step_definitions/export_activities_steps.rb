Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I am not yet logged in$/) do
  find_link('sign_in')
end

Then(/^I can log in$/) do
  find_link('sign_in').click
end

Then(/^see the query form$/) do
  # save_and_open_page
  find('form', id: "fan_collector")
end
