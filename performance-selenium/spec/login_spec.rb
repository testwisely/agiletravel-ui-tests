load File.dirname(__FILE__) + '/../test_helper.rb'
load File.dirname(__FILE__) + '/../load_test_helper.rb'

describe "Load - User Authentication" do
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

    it "Login" do
      load_test_repeat.times do      
        driver.find_element(:id, "username").send_keys("agileway")
        driver.find_element(:id, "password").send_keys("testwise")
        log_time('Login') { driver.find_element(:name, "commit").click }
        expect(driver.find_element(:id, "flash_notice").text).to eq("Signed in!")
        log_time('Sign off') { driver.find_element(:link_text, "Sign off").click }
      end
    end

end
