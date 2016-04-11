require File.join(File.dirname(__FILE__), "abstract_page.rb")

class FlightPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_trip_type(trip_type)
    click_radio_option("tripType", trip_type)
  end

  def select_depart_from(from_port)
    select_option("fromPort", from_port)
  end

  def select_arrive_at(to_port)
    select_option("toPort", to_port)
  end

  def select_depart_day(depart_day)
    select_option("departDay", depart_day)
  end

  def select_depart_month(depart_month)
    select_option("departMonth",depart_month)
  end

  def select_return_day(return_day)
    select_option("returnDay", return_day)
  end

  def select_return_month(return_month)
    select_option("returnMonth", return_month)
  end

  def click_continue
    click_button("Continue")
  end

end
