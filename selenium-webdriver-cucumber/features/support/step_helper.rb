# Used in steps
#   include StepHelper

module StepHelper
  
  def sign_off
    @driver.find_element(:link_text, "Sign off").click
  end

end
