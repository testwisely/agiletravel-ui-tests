require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PaymentPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_holder_name(holder_name)
    driver.find_element(:name, "holder_name").send_keys(holder_name)
  end

  def enter_card_number(card_number)
    driver.find_element(:name, "card_number").send_keys(card_number)
  end

  def enter_expiry_month(expiry_month)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_month")).select_by(:text, expiry_month)
  end

  def enter_expiry_year(expiry_year)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_year")).select_by(:text, expiry_year)
  end

  def click_pay_now
    driver.find_element(:xpath,"//input[@value='Pay now']").click
  end

  def select_card_type(card_type)
    driver.find_element(:xpath, "//input[@name='card_type' and @value='" + card_type +  "']").click
  end

end
