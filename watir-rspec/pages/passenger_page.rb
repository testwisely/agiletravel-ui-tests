load File.dirname(__FILE__) + '/abstract_page.rb'

class PassengerPage < AbstractPage

  def initialize(browser)
    super(browser, "Passenger")
  end

  def enter_first_name(first_name)
     browser.text_field(:name, "passengerFirstName").set first_name
  end

  def enter_last_name(last_name)
    browser.text_field(:name, "passengerLastName").set last_name
  end

  def click_next
    browser.button(:value, "Next").click
    ConfirmationPage.new(browser)
  end

end
