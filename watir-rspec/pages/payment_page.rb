require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PaymentPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end


  def enter_holder_name(holder_name)
    browser.text_field(:name, "holder_name").set(holder_name)
  end

  def enter_card_number(card_number)
    browser.text_field(:name, "card_number").set(card_number)
  end

  def enter_expiry_month(expiry_month)
    browser.select_list(:name, "expiry_month").select(expiry_month)
  end

  def enter_expiry_year(expiry_year)
    browser.select_list(:name, "expiry_year").select(expiry_year)
  end

  def click_pay_now
    browser.button(:value, "Pay now").click
  end

  def select_card_type(card_type)
    browser.radio(:name => "card_type", :value => card_type).click
  end

end
