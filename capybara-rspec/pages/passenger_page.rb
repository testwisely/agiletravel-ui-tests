require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PassengerPage < AbstractPage

  def initialize()
    super("") #
  end

  def click_next()
    click_button("Next")
  end

  def enter_first_name(passenger_first_name)
    fill_in 'passengerFirstName', :with => passenger_first_name
  end

  def enter_last_name(passenger_last_name)
    fill_in 'passengerLastName', :with => passenger_last_name
  end

end
