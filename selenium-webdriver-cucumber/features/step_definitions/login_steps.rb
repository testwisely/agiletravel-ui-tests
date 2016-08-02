# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  @driver.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

Given(/^I am on the home page$/) do
  @driver.navigate.to($BASE_URL )
end

When (/^enter user name "(.*?)" and password "(.*?)"$/) do |user, pass|
  @driver.find_element(:id, "username").send_keys(user)
  @driver.find_element(:id, "password").send_keys(pass)
end

When /^click "(.*?)" button$/ do |button|
  @driver.find_element(:xpath,"//input[@value=\"#{button}\"]").click
end

Then /^I am logged in$/ do
  expect(@driver.page_source).to include("Signed in!")
end

# If you want snippets in a different programming language, just make sure a file
# with the appropriate file extension exists where cucumber looks for step definitions.


Then(/^I should see an log in error message$/) do
  expect(@driver.page_source).to include("Invalid email or password")
end


Then(/^I sign off$/) do
  @driver.find_element(:link_text, "Sign off").click
end
