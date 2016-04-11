load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flights" do
  include TestHelper

  before(:all) do
    open_browser(:browser => browser_type)
    enter_text("username", "agileway")
    enter_text("password", "testwise")
    click_button("Sign in")
  end

  before(:each) do
    sleep 0.5
    goto_page("/")
    sleep 1 # for some webdriver verson, it might not wait page loaded
  end

  after(:all) do
    close_browser unless debugging?
  end

  test_case "Return trip" do
    flight_page = expect_page FlightPage
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    assert_text_present("2016-05-02 Sydney to New York")
    assert_text_present("2016-06-04 New York to Sydney")
  end

  test_case "One-way trip" do
    flight_page = expect_page FlightPage
    flight_page.select_trip_type("oneway")
    click_radio_option("tripType", "oneway")
    assert_hidden(:div, "returnTrip")

    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    assert_text_present("2016-05-02 Sydney to New York")
  end


end
