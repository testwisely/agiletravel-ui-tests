
Given /^I am on the home page$/ do

end

When /^I enter user name "([^\"]*)" and password "([^\"]*)"$/ do |arg1, arg2|
  @browser.enter_text("username", "agileway")
  @browser.enter_text("password", "testwise")
end

When /^click the 'Sign in' button$/ do
  @browser.click_button("Sign in")
end

Then /^I signed in successfully$/ do
  assert @browser.text.include?("Welcome agileway")
end
