load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
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


  it "Can enter passenger details" do
    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "New York")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "04")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "March 2016")
    driver.find_element(:xpath,"//input[@value='Continue']").click

    # now on passenger page
    driver.find_element(:xpath,"//input[@value='Next']").click
    expect(driver.page_source).to include("Must provide last name")
    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:xpath,"//input[@value='Next']").click

    expect(driver.find_element(:name, "holder_name")["value"]).to eq("Bob Tester")
  end

end
