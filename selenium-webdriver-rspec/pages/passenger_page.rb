require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PassengerPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_first_name(passenger_first_name)
    driver.find_element(:name, "passengerFirstName").send_keys(passenger_first_name)
  end

  def enter_last_name(passenger_last_name)
    driver.find_element(:name, "passengerLastName").send_keys(passenger_last_name)
  end

  def click_next
    driver.find_element(:name, "passengerLastName").submit # submit the form, ie click 'Next'
  end
  
end
