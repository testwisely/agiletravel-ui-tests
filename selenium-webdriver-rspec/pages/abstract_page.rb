# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/../rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/../testwise_support.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage 

  
  # If want to use utility methods such as fail_safe { }, uncomment the line below 
  # 
  include RWebSpecUtils

  # If want to use debug('message') to TestWise Console, uncomment the line below
  #
	if defined?(TestWiseRuntimeSupport)
	  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
  else
  	include TestWiseSupport
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
