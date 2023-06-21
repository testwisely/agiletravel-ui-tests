load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Payment" do
  include TestHelper

  before(:all) do
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.manage().window().move_to(30, 78)
    driver.get(site_url)
    
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "testwise")
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[5] Book flight with payment", :tag => "showcase" do
    
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    # now on passenger page
    passenger_page = PassengerPage.new(driver)
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    payment_page = PaymentPage.new(driver)
    payment_page.select_card_type("master")
    payment_page.enter_holder_name("Bob the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now
    try_for(10) { expect(driver.page_source).to include("Booking number")}
    puts("booking number: " + driver.find_element(:id, 'booking_number').text)
  end

end
