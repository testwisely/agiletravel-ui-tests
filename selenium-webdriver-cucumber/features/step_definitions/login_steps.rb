# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  @browser.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

Given(/^I am on the home page$/) do
  @browser.navigate.to($BASE_URL )
end

When (/^enter user name "(.*?)" and password "(.*?)"$/) do |user, pass|
  @browser.find_element(:id, "username").send_keys(user)
  @browser.find_element(:id, "password").send_keys(pass)
end

When /^click "(.*?)" button$/ do |button|
  @browser.find_element(:xpath,"//input[@value=\"#{button}\"]").click
end

Then /^I am logged in$/ do
  expect(@browser.page_source).to include("Welcome <b>agileway</b>")
end

# If you want snippets in a different programming language, just make sure a file
# with the appropriate file extension exists where cucumber looks for step definitions.
