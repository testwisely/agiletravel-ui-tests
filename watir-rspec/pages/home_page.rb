load File.dirname(__FILE__) + '/abstract_page.rb'

class HomePage < AbstractPage

  def initialize(browser)
    # the super() calles the initialize() in parent class, in this case, web_page.rb
    super(browser, "Agile Travel")
  
  end

  def enter_user_name(user_name)
    browser.text_field(name: "username").set(user_name)
  end

  def enter_password(password)
    browser.text_field(name: "password").set(password)
  end

  def click_sign_in
    #    browser.button(:src, /btn_signin\.gif/).click
    browser.button(value: "Sign in").click
  end

end
