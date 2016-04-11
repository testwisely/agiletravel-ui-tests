require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PaymentPage < AbstractPage

  def initialize()
    super("") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_card_type(card_type)
    choose("card_type", option: card_type)
  end

  def enter_holder_name(holder_name)
    fill_in 'holder_name', :with => holder_name
  end

  def enter_card_number(card_number)
    fill_in 'card_number', :with => card_number
  end

  def select_expiry_month(expiry_month)        
    select(expiry_month, :from => "expiry_month")    
  end

  def select_expiry_year(expiry_year)
    select(expiry_year, :from => "expiry_year")    
  end

  def click_pay_now
    click_button("Pay now")
  end

end
