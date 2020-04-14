# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/../agileway_utils.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage 

  
  # If want to use utility methods such as fail_safe { }, uncomment the line below 
  # 
  include AgilewayUtils

  # If want to use debug('message') to TestWise Console, uncomment the line below
  #
	if defined?(TestWiseRuntimeSupport)
	  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
	end
  

  def initialize(driver, text = "")
    @browser = driver
    # TODO check the page text contains the given text	
  end

  
  def browser
    @browser
  end
  
  def driver
    @browser
  end
  
end
