load File.dirname(__FILE__) + '/abstract_page.rb'

class ConfirmationPage < AbstractPage

  def initialize(browser)
    super(browser, "")
  end
  
end
