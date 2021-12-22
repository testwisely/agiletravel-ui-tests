load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "Load - Payment" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    log_time("Visit Home Page") { driver.get(site_url) }
  end

  after(:all) do
    dump_timings
    driver.quit unless debugging?
  end

  it "Payment AJAX" do
    load_test_repeat.times do
      driver.find_element(:id, "username").send_keys("agileway")
      driver.find_element(:id, "password").send_keys("testwise")
      log_time("Login") { driver.find_element(:name, "commit").click }
      expect(driver.find_element(:id, "flash_notice").text).to eq("Signed in!")

      driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
      Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "New York")
      Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "Sydney")
      log_time("Select Flight") {
        driver.find_element(:xpath, "//input[@type='submit' and @value='Continue']").click
      }
      driver.find_element(:name, "passengerFirstName").send_keys("B")
      driver.find_element(:name, "passengerLastName").send_keys("D")
      log_time("Submit Passenger") {
        driver.find_element(:xpath, "//input[@type='submit' and @value='Next']").click
      }
      driver.find_element(:name, "card_type").click
      driver.find_element(:name, "card_number").send_keys("4242424242424242")

      log_time('Click pay button') { driver.find_element(:xpath, "//input[@type='submit' and @value='Pay now']").click }
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      log_time("Pay now") { 
        wait.until { driver.find_element(:id, "booking_number") } 
      }
      puts "Receipt: " + driver.find_element(:id, "booking_number").text
    end
  end
end
