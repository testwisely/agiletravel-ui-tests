require "#{File.dirname(__FILE__)}/../rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/../testwise_support.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

  # If want to use utility methods such as fail_safe { }, uncomment the line below 
  # 
  include RWebSpecUtils

  # If want to use debug('message') to TestWise Console, uncomment the statements below
  #
	if defined?(TestWiseRuntimeSupport)
    include TestWiseRuntimeSupport
  else
  	include TestWiseSupport
	end

  def initialize(driver, text = "")
    page_delay
    @driver = driver
    raise "Page text '#{text}' not found on #{self.class.name}" unless driver.text.include?(text)	    
  end

  def driver
    @driver
  end
  alias browser driver

  # add delay on landing a web page. the default implementation is using a setting in TestWise IDE 
  def page_delay
    if $TESTWISE_PAGE_DELAY && $TESTWISE_PAGE_DELAY.to_i > 0 && $TESTWISE_PAGE_DELAY.to_i < 100
      sleep $TESTWISE_PAGE_DELAY.to_i
    end 
  end
  
end
