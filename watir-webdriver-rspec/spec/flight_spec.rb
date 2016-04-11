load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flights" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new(browser_type)
    @browser.goto(site_url)
    login_as("agileway", "testwise")
  end

  before(:each) do    
    browser.goto(site_url)    
  end

  after(:all) do
    browser.close unless debugging?
  end

  it "Return trip" do
    flight_page = FlightPage.new(browser)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    expect(browser.text).to include("2016-05-02 Sydney to New York")
    expect(browser.text).to include("2016-06-04 New York to Sydney")
  end

  it "One-way trip" do
    flight_page = FlightPage.new(browser)
    flight_page.select_trip_type("oneway")
    expect(browser.div(:id, "returnTrip").visible?).to be_falsey

    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    expect(browser.text).to include("2016-05-02 Sydney to New York")
  end


end
