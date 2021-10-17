load File.dirname(__FILE__) + "/../test_helper.rb"

# don't use selenium excessive log directly when running in TestWise
# if you want do, use the statement below, and run the test from command line to see debug log
#
# Selenium::WebDriver.logger.level = :debug unless defined?(TestWiseRuntimeSupport)

describe "User Login" do
  include TestHelper

  before(:all) do
    # for windows, when unable auto-detect firefox binary
    # Please note Firefox on 32 bit is "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
    # Selenium::WebDriver::Firefox::Binary.path="C:/Program Files/Mozilla Firefox/firefox.exe"

    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.manage().window().move_to(30, 78)
    driver.get(site_url)
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[1] Can sign in OK" do
    visit("/login")
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:name, "commit").click
    # selenium does not have browser.text yet
    expect(driver.page_source).to include("Welcome")
    driver.find_element(:link_text, "Sign off").click
    puts "[stdout] Signed out"
  end

  it "[1] User failed to sign in due to invalid password", :tag => "showcase" do
    visit("/login")
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "badpass")
    expect(driver.page_source).to include("Invalid email or password")
  end
end
