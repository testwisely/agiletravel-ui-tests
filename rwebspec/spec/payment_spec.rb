load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Payment" do
  include TestHelper

  before(:all) do
    open_browser(:base_url => site_url, :browser => browser_type)
    enter_text("username", "agileway")
    enter_text("password", "testwise")
    click_button("Sign in")
  end

  after(:all) do
    fail_safe { click_link("Sign off")} unless debugging?
  end

  test_case "Get booking confirmation after payment " do

    flight_page = expect_page FlightPage
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    # now on passenger page
    passenger_page = expect_page PassengerPage
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    payment_page = expect_page PaymentPage
    try_for(3) {  payment_page.select_card_type("master") }
    payment_page.enter_holder_name("Bob  the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now
    try_for(12) { assert_text_present("Booking number") }
    debug span(:id, "booking_number").text
  end

end
