# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  @browser.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.




When('select {string} card') do |card_type|
  @payment_page = PaymentPage.new(driver)
  @payment_page.select_card_type(card_type.downcase)
end

When('enter card holder name {string}') do |holder|
  @payment_page.enter_card_number(holder)
end

When('enter card number {string}') do |card_number|
  @payment_page.enter_card_number(card_number)
end

When('select card expiry date {string} of {string}') do |month, year|
  @payment_page.select_expiry_month(month)
  @payment_page.select_expiry_year(year)
end

When('I click {string}') do |button_name|
  @payment_page.click_pay_now
end

Then('I should see {string} in confirmation section') do |booking_number|
   #AJAX 
  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  wait.until{ driver.find_element(:id => "booking_number").text.to_i > 100 }
  puts "Booking number is " + driver.find_element(:id => "booking_number").text
end

