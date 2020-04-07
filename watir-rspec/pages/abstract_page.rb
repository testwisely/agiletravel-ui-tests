require "#{File.dirname(__FILE__)}/../agileway_utils.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

  # If want to use utility methods such as fail_safe { }, uncomment the line below 
  # 
  include AgilewayUtils

  # If want to use debug('message') to TestWise Console, uncomment the statements below
  #
	if defined?(TestWiseRuntimeSupport)
    include TestWiseRuntimeSupport
	end

  def initialize(driver, text = "")
    @driver = driver
    raise "Page text '#{text}' not found on #{self.class.name}" unless driver.text.include?(text)	    
  end

  def driver
    @driver
  end
  alias browser driver

  
end
