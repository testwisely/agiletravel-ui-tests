
load File.dirname(__FILE__) + '/../test_helper.rb'

describe "New" do
    include TestHelper

    before(:all) do
      # browser_type, browser_options, site_url are defined in test_helper.rb
      @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
      driver.manage().window().resize_to(1280, 720)
      driver.get(site_url)
    end

    after(:all) do
      driver.quit unless debugging?
    end

    it "Test Case Name" do
      # driver.find_element(...)
      # expect(page_text).to include(..)
    end

end


