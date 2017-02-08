load File.dirname(__FILE__) + '/abstract_page.rb'

class FlightPage < AbstractPage

  def initialize(browser)
    super(browser, "Select Flight")
  end

  def select_depart_from(depart_from)
    browser.select_list(:name, "fromPort").select(depart_from)
  end

  def select_depart_month(depart_month)
    browser.select_list(:id, "departMonth").select(depart_month)
  end

  def select_depart_day(depart_day)
    browser.select_list(:name, "departDay").select(depart_day)
  end

  def select_arrive_at(arriving_in)
    browser.select_list(:name, "toPort").select(arriving_in)
  end

  def select_return_month(return_month)
    browser.select_list(:id, "returnMonth").select(return_month)
  end

  def select_return_day(return_day)
    browser.select_list(:name, "returnDay").select(return_day)
  end

  def select_service_class(service_class)
    browser.radio(:name, "servClass", service_class).click
  end

  def select_trip_type(trip_type)
    browser.radio(:name => "tripType", :value => trip_type).click
  end

  def click_continue
    browser.button(:value, "Continue").click
    PassengerPage.new(browser)
  end

end
