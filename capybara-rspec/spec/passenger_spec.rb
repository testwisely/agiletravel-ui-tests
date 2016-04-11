load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
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
  
  it "Can enter passenger details" do
    flight_page = FlightPage.new
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("New York")
    flight_page.select_arrive_at("Sydney")
    flight_page.select_departure_day("04")
    flight_page.select_departure_month("March 2016")
    flight_page.select_return_date("07", "April 2016")
    flight_page.click_continue
    
    # now on passenger page    
    passenger_page = PassengerPage.new
    passenger_page.click_next
    expect(page.has_content?("Must provide last name")).to be_truthy
    
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next
    
    expect(page.html).to include("Bob Tester")
  end

end
