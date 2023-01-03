require "rspec"
require "selenium-webdriver"

describe "End To End" do
  before(:all) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.get("https://travel.agileway.net")
    driver.find_element(:link_text, "Login").click
  end

  after(:all) do
    @driver.quit
  end

  def driver
    @driver
  end

  it "End-to-End Selenium Raw" do
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:id, "remember_me").click
    driver.find_element(:id, "username").submit
    expect(driver.find_element(:tag_name, 'body').text).to include("Signed in")

    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "New York")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "02")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "May 2016")
    driver.find_element(:xpath, "//input[@value='Continue']").click

    # now on passenger page
    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:name, "passengerLastName").submit

    # one payment page
    driver.find_element(:xpath, "//input[@name='card_type' and @value='master']").click
    driver.find_element(:name, "holder_name").send_keys("Bob the Tester")
    driver.find_element(:name, "card_number").send_keys("4242424242424242")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_month")).select_by(:text, "04")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_year")).select_by(:text, "2016")
    driver.find_element(:xpath, "//input[@value='Pay now']").click
  end
end
