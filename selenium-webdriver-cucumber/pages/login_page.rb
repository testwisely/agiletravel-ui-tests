require File.join(File.dirname(__FILE__), "abstract_page.rb")

class LoginPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def login(user, pass)
    @browser.find_element(:id, "username").send_keys(user)
    @browser.find_element(:id, "password").send_keys(pass)
    @browser.find_element(:id, "username").submit

  end

end
