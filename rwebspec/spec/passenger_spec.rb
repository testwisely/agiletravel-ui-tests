load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
  include TestHelper

  before(:all) do
    open_browser(:browser => browser_type)
    enter_text("username", "agileway")
    enter_text("password", "testwise")
    click_button("Sign in")
  end

  after(:all) do
    fail_safe { click_link("Sign off")} unless debugging?
  end

	test_case "Can enter passenger details (using page objects)" do
    flight_page = expect_page FlightPage
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    
    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue
    
    # now on passenger page
    passenger_page = expect_page PassengerPage
    passenger_page.click_submit
    try_for(3) { page_text.should contain("Must provide last name") }
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_submit

    browser.find_element(:name, "holder_name").attribute("value").should == "Bob Tester"
  end

end
