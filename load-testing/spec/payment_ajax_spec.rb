load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "Payment Load (AJAX)" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.get(site_url)
  end

  before(:each) do
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[3] Payment with AJAX" do
    log_time("Visit Home Page") { driver.get(site_url) }
    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    log_time("Sign in") { driver.find_element(:name, "commit").click }

    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    log_time("Select Flight") { flight_page.click_continue }
    expect(page_text).to include("2016-01-01 Sydney to New York")

    # now on passenger page
    passenger_page = PassengerPage.new(driver)
    passenger_page.enter_last_name("Tester")
    log_time("Passenger") { passenger_page.click_next }

    payment_page = PaymentPage.new(driver)
    payment_page.select_card_type("master")
    payment_page.enter_holder_name("Bob the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now
    log_time("Payment") {
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { driver.page_source.include?("Booking number") }
    }

    log_time("Sign out") { logout }
  end
end
