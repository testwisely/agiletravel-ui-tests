require "rspec"
require "selenium-webdriver"

require "#{File.dirname(__FILE__)}/../pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/../pages/*_page.rb"].each { |file| load file }

describe "End To End" do
  before(:all) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.get("https://travel.agileway.net")
    driver.find_element(:link_text, "Login").click
  end

  after(:all) do
    @driver.quit
  end

  def driver
    @driver
  end

  it "End-to-End Selenium POM" do
    login_page = LoginPage.new(driver)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.check_remember_me
    login_page.click_sign_in
    expect(driver.find_element(:tag_name, 'body').text).to include("Signed in")

    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    passenger_page = PassengerPage.new(driver)
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    payment_page = PaymentPage.new(driver)
    payment_page.select_card_type("master")
    payment_page.enter_holder_name("Bob the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now
  end
end
