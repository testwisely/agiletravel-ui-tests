require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PassengerPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_first_name(passenger_first_name)
    enter_text("passengerFirstName", passenger_first_name)
  end

  def enter_last_name(passenger_last_name)
    enter_text("passengerLastName", passenger_last_name)
  end

  def click_next
    click_button("Next")    
  end

end
