# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/../agileway_utils.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

    # Optional:
		# provide some general utility functions such as fail_safe { }
    #
    include AgilewayUtils

    # Optional:
		# TestWise Integration, supporting output text to TestWise Console with  puts('message') to TestWise Console
    #
    if defined?(TestWiseRuntimeSupport)
      include TestWiseRuntimeSupport
    end


    def initialize(driver, text = "")
      page_delay
      @driver = driver
      # TODO check the page text contains the given text
    end


    def driver
      @driver
    end

    alias browser driver

    # add delay on landing a web page. the default implementation is using a setting in TestWise IDE
    def page_delay
		
    end

end
