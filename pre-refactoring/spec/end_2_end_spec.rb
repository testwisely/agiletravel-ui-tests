load File.dirname(__FILE__) + "/../test_helper.rb"

describe "End2End" do
  include TestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    @driver.get(site_url)
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "(Recorded version) Book Flight" do
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:name, "commit").click

    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    elem_from = driver.find_element(:name, "fromPort")
    Selenium::WebDriver::Support::Select.new(elem_from).select_by(:text, "Sydney")
    elem_to = driver.find_element(:name, "toPort")
    Selenium::WebDriver::Support::Select.new(elem_to).select_by(:text, "New York")
    elem_depart_day = driver.find_element(:id, "departDay")
    Selenium::WebDriver::Support::Select.new(elem_depart_day).select_by(:text, "02")
    elem_depart_month = driver.find_element(:id, "departMonth")
    Selenium::WebDriver::Support::Select.new(elem_depart_month).select_by(:text, "May 2016")
    driver.find_element(:xpath, "//input[@value='Continue']").click

    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:xpath, "//input[@value='Next']").click

    driver.find_element(:xpath, "//input[@name='card_type' and @value='master']").click
    driver.find_element(:name, "holder_name").send_keys("Bob the Tester")
    driver.find_element(:name, "card_number").send_keys("4242424242424242")
    elem_expiry_month = driver.find_element(:name, "expiry_month")
    Selenium::WebDriver::Support::Select.new(elem_expiry_month).select_by(:text, "04")
    elem_expiry_year = driver.find_element(:name, "expiry_year")
    Selenium::WebDriver::Support::Select.new(elem_expiry_year).select_by(:text, "2016")
    driver.find_element(:xpath, "//input[@type='submit' and @value='Pay now']").click
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    puts("123")
    wait.until { driver.page_source.include?("Booking number") }
    driver.find_element(:link_text, "Sign off").click
  end
end
