require File.join(File.dirname(__FILE__), "abstract_page.rb")

class FlightPage < AbstractPage

  def initialize()
    super("") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_trip_type(trip_type)
    choose("tripType", option: trip_type)
  end

  def select_depart_from(from_port)
    select(from_port, :from => 'fromPort')
  end

  def select_arrive_at(to_port)
    select(to_port, :from => 'toPort')
  end

  def select_departure_day(depart_day)
    select(depart_day, :from => 'departDay')
  end

  def select_departure_month(depart_month)
    select(depart_month, :from => 'departMonth')
  end

  def select_return_date(day, month)
    select(day, :from => 'returnDay')
    select(month, :from => 'returnMonth')
  end

  def click_continue
    click_button("Continue")
  end

end
