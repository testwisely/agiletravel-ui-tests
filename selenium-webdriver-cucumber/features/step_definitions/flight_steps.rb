# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  @browser.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.


Given /^I am signed in as "(.*?)"$/ do |user|
  sign_in("agileway", "testwise")
  @flight_page = FlightPage.new(@browser)
end

When /^select oneway trip$/ do
  @flight_page.select_trip_type("oneway")
end

When /^select return trip$/ do
    @flight_page.select_trip_type("return")
end

When /^click "(.*?)"$/ do |arg1|
   sleep 0.5
   @flight_page.click_continue
end

When /^select depart from "(.*?)" to "(.*?)" on "(.*?)" of "(.*?)"$/ do |from, to, day, month_year|
  @flight_page.select_depart_from(from)
  @flight_page.select_arrive_at(to)
  @flight_page.select_departure_day(day)
  @flight_page.select_departure_month(month_year)
end

Then /^I should see "(.*?)", "(.*?)" and "(.*?)" on next page$/ do |text1, text2, text3|
  the_page_source = @browser.page_source
  expect(the_page_source).to include(text1)
  expect(the_page_source).to include(text2)
  expect(the_page_source).to include(text3)
end


When /^return on "(.*?)" of "(.*?)"$/ do |day, month|
  @flight_page.select_return_date(day, month)
end