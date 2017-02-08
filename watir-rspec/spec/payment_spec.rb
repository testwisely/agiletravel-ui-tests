load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Payment" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new(browser_type)
    @browser.goto(site_url)
    login_as("agileway", "testwise")
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "Get booking confirmation after payment " do

    flight_page = FlightPage.new(browser)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    # now on passenger page
    passenger_page = PassengerPage.new(browser)
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    payment_page = PaymentPage.new(browser)
    try_for(3) {  payment_page.select_card_type("master") }
    payment_page.enter_holder_name("Bob  the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now
    Watir::Wait.until{ browser.text.include?("Booking number") }
    debug browser.span(:id, "booking_number").text
  end

end
