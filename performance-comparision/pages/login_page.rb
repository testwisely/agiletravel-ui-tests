require File.join(File.dirname(__FILE__), "abstract_page.rb")

class LoginPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def check_remember_me
    driver.find_element(:id, "remember_me").click
  end

  def enter_username(user)
    driver.find_element(:id, "username").send_keys(user)
  end

  def enter_password(passwd)
    driver.find_element(:id, "password").send_keys(passwd)
  end

  def click_sign_in
    driver.find_element(:id, "username").submit
  end
end
