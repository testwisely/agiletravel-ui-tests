load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flights" do
  include TestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.manage().window().move_to(30, 78)
    driver.get(site_url)
    
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "testwise")
  end

  before(:each) do
    goto_page("/")
    sleep 1 # for some webdriver verson, it might not wait page loaded
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[3] Return trip" do
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    expect(page_text).to include("2016-05-02 Sydney to New York")
    expect(page_text).to include("2016-06-04 New York to Sydney")
  end

  it "[2] One-way trip" do
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    expect(page_text).to include("2016-05-02 Sydney to New York")
  end


end
