load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new(browser_type)
    @browser.goto(site_url)
    login_as("agileway", "testwise")
  end

  after(:all) do
    @browser.close unless debugging?
  end

	it "Can enter passenger details (using page objects)" do
    flight_page = FlightPage.new(browser)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    
    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue
    
    # now on passenger page
    passenger_page = PassengerPage.new(browser)
    passenger_page.click_next    
    try_for(3) { expect(browser.text).to include("Must provide last name") }
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    expect(browser.text_field(:name, "holder_name").attribute_value("value")).to eq("Bob Tester")
  end

end
