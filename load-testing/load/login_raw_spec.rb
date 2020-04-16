load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "User Login" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    # driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:all) do
    dump_timings
    @driver.quit unless debugging?
  end

  it "[1] User sign in and sign out" do
    1.times do
      # add simple verification after visit a URL, to make sure it is correct,
      # the `driver.title` costs only 0.005 seconds
      log_time("Visit Home Page") {
        driver.get(site_url)
        # start_time = Time.now
        expect(driver.title).to eq("Agile Travel")
        # puts "#{Time.now - start_time} s"
      }

      # this is user supplying information, not hitting the server
      driver.find_element(:id, "username").send_keys("agileway")
      driver.find_element(:id, "password").send_keys("testwise")
      
      # the `driver.find_element(:id)` costs only 0.03 seconds
      log_time("Sign in") {
        driver.find_element(:name, "commit").click
        # start_time = Time.now
        expect(driver.find_element(:id, "flash_notice").text).to include("Signed in!")
        # puts("#{Time.now - start_time}: check signed in")
      }

      log_time("Sign out") {
        visit("/logout")
        # start_time = Time.now
        expect(driver.find_element(:id, "flash_notice").text).to include("Signed out!")
        # puts("#{Time.now - start_time}: check signed out")
      }
    end
  end
end
