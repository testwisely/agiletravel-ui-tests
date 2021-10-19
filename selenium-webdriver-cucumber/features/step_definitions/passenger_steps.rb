# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  driver.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

When('I enter {string} and {string} as passenger name') do |first_name, last_name|
    sleep 1
  @passenger_page = PassengerPage.new(driver)
  @passenger_page.enter_first_name(first_name)
  @passenger_page.enter_last_name(last_name)
end

Then('I should see {string} shown in card holder name on the next payment page') do |name|
 sleep 1
  expect(driver.find_element(:name, "holder_name").attribute("value")).to eq(name)
end

When('click {string} on the passenger page') do |button_name|
   @passenger_page.click_next
end


