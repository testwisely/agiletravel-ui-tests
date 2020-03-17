load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
  include TestHelper

  before(:all) do
    # by setting $driver global variable for build_rspec_formatter can save screenshot if error occurs
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.manage().window().move_to(30, 78)
    driver.get(site_url)
    
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "testwise")
  end

  after(:all) do
    fail_safe { driver.find_element(:link_text, "Sign off").click } unless debugging?
    driver.quit unless debugging?
  end

  it "[4] Can enter passenger details (using page objects)" do
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    # now on passenger page
    passenger_page = PassengerPage.new(driver)
    passenger_page.click_next
    try_for(3) { expect(page_text).to include("Must provide last name") }
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    expect(driver.find_element(:name, "holder_name").attribute("value")).to eq("Wendy Tester")
  end

end
