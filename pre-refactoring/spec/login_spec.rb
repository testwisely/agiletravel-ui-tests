load File.dirname(__FILE__) + '/../test_helper.rb'

describe "User Login" do
  include TestHelper

  before(:all) do
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    @driver.navigate.to(site_url) #
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "User can sign in OK" do
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:xpath,"//input[@value='Sign in']").click
    expect(driver.find_element(:tag_name, "body").text).to include("Welcome agileway")
    driver.find_element(:link_text, "Sign off").click
  end

  it "User failed to sign in due to invalid password" do
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("badpass")
    driver.find_element(:xpath,"//input[@value='Sign in']").click
    expect(driver.find_element(:tag_name, "body").text).to include("Invalid email or password")
  end

end
