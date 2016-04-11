load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Payment" do
  include TestHelper

  before(:all) do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => browser_type)
    end
    visit("/")
    sign_in("agileway", "testwise")
  end

  before(:each) do
  end

  after(:all) do
    # close_browser unless debugging?
  end

  it "Get booking confirmation after payment " do
    flight_page = FlightPage.new
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    flight_page.select_departure_day("02")
    flight_page.select_departure_month("May 2016")
    flight_page.click_continue

    passenger_page = PassengerPage.new
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next()

    payment_page = PaymentPage.new
    payment_page.select_card_type("master")
    payment_page.enter_holder_name("Bob  the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.select_expiry_month("04")
    payment_page.select_expiry_year("2016")
    payment_page.click_pay_now
    wait_for_ajax(10)
    expect(page.has_content?("Booking number")).to be_truthy
  end

  def wait_for_ajax(max_time)
    Timeout.timeout(max_time) do
      active = page.evaluate_script('jQuery.active')
      until active == 0
        active = page.evaluate_script('jQuery.active')
      end
    end
  end

end
