load File.dirname(__FILE__) + '/../test_helper.rb'
load File.dirname(__FILE__) + '/../load_test_helper.rb'

describe "Select Flights" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.get(site_url)
    login_as("agileway", "testwise")
  end

  before(:each) do
    visit("/")
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[3] Return trip" do
    
    
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    log_time("Select Flight"){ flight_page.click_continue } 
    expect(page_text).to include("2016-01-01 Sydney to New York")
  end

end
