load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flights" do
  include TestHelper

  before(:all) do
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    @driver.navigate.to(site_url) # you may

    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:xpath,"//input[@value='Sign in']").click
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  before(:each) do
    # before each test, make sure on flight page
    driver.navigate.to "#{site_url}/flights/start" 
  end

  it "One-way trip" do
    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    expect(driver.find_element(:id, "returnTrip").displayed?).to be_falsey
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "New York")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "02")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "May 2016")
    driver.find_element(:xpath,"//input[@value='Continue']").click

    expect(page_text).to include("2016-05-02 Sydney to New York")
  end
  
  it "Return trip" do
    driver.find_element(:xpath, "//input[@name='tripType' and @value='return']").click

    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "New York")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "02")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "May 2016")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnDay")).select_by(:text, "04")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnMonth")).select_by(:text, "June 2016")
    driver.find_element(:xpath,"//input[@value='Continue']").click

    expect(page_text).to include("2016-05-02 Sydney to New York")
    expect(page_text).to include("2016-06-04 New York to Sydney")
  end

end
