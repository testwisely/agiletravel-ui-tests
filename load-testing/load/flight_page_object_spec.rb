load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "Select Flights" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.get(site_url)
  end

  after(:all) do
    dump_timings
    driver.quit unless debugging?
  end

  it "[2] Return trip" do
    log_time("Visit Home Page") {
      driver.get(site_url)
      expect(driver.title).to eq("Agile Travel")
    }
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    log_time("Sign in") {
        driver.find_element(:name, "commit").click
        expect(driver.find_element(:id, "flash_notice").text).to include("Signed in!")
    }
    
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    
    log_time("Select Flight") { 
      flight_page.click_continue 
      #  simple page get_page_text costs about 0.03 seconds
      # start_time = Time.now
      expect(page_text).to include("2016-01-01 Sydney to New York")
      # puts("#{Time.now - start_time}: check flight")
    }

    log_time("Sign out") { logout }
  end
end
