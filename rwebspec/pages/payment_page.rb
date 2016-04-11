require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PaymentPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

def enter_holder_name(holder_name)
  enter_text("holder_name", holder_name)
end

def enter_card_number(card_number)
  enter_text("card_number", card_number)
end

def enter_expiry_month(expiry_month)
  select_option("expiry_month", expiry_month)
end

def enter_expiry_year(expiry_year)
  select_option("expiry_year", expiry_year)
end

def click_pay_now
  click_button("Pay now")
end

def select_card_type(card_type)
  click_radio_option("card_type", card_type)
end

end
