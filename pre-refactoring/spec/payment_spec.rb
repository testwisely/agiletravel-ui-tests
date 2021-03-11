load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Payment" do
  include TestHelper

  before(:all) do
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    @driver.navigate.to(site_url) # you may

    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:xpath,"//input[@value='Sign in']").click
  end

  before(:each) do
  end

  after(:all) do
    fail_safe { @driver.quit } unless debugging?
  end
  
  it "Get booking confirmation after payment " do
    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "New York")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "02")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "May 2016")
    driver.find_element(:xpath,"//input[@value='Continue']").click

    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:xpath,"//input[@value='Next']").click

    driver.find_element(:xpath, "//input[@name='card_type' and @value='master']").click
    driver.find_element(:name, "holder_name").send_keys("Bob the Tester")
    driver.find_element(:name, "card_number").send_keys("4242424242424242")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_month")).select_by(:text, "04")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_year")).select_by(:text, "2016")
    driver.find_element(:xpath,"//input[@type='submit' and @value='Pay now']").click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds 
    wait.until{ driver.page_source.include?("Booking number") }
    debug driver.find_element(:id, "booking_number").text
  end

end
