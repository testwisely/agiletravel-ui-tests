load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flights" do
  include TestHelper

  before(:all) do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => browser_type)
    end
    visit("/")
    sign_in("agileway", "testwise")    
  end

  before(:each) do
    visit("/flights/start")
  end
  
  after(:all) do
    # close_browser unless debugging?
  end

  it "One-way trip" do
    flight_page = FlightPage.new
    flight_page.select_trip_type("oneway")        
    expect(page).to have_selector('#returnTrip', visible: false)    
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    flight_page.select_departure_day("02")
    flight_page.select_departure_month("May 2016")
    flight_page.click_continue
    sleep 0.5
    expect(page.has_content?("2016-05-02 Sydney to New York")).to be_truthy
  end
  
  it "Return trip" do
    flight_page = FlightPage.new
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    flight_page.select_departure_day("02")
    flight_page.select_departure_month("May 2016")
    flight_page.select_return_date("04", "June 2016")
    flight_page.click_continue
    expect(page.has_content?("2016-05-02 Sydney to New York")).to be_truthy
    expect(page.has_content?("2016-06-04 New York to Sydney")).to be_truthy
  end

end
