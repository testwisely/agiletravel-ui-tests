require File.join(File.dirname(__FILE__), "abstract_page.rb")

class FlightPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_trip_type(trip_type)
    driver.find_elements(:name => "tripType").each { |elem| elem.click && break if elem.attribute("value") == trip_type && elem.attribute("type") == "radio" }
  end

  def select_depart_from(from_port)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, from_port)
  end

  def select_arrive_at(to_port)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, to_port)
  end

  def select_depart_day(depart_day)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, depart_day)
  end

  def select_depart_month(depart_month)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, depart_month)
  end

  def select_return_day(return_day)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnDay")).select_by(:text, return_day)
  end

  def select_return_month(return_month)
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnMonth")).select_by(:text, return_month)
  end

  def click_continue
    driver.find_element(:xpath,"//input[@value='Continue']").click
  end

end
