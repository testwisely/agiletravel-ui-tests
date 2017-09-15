require 'ci/reporter/rspec' # version 1.0.0
require 'fileutils'
# Overrides default example failed behaviour to add saving screenshot to the reports dir.
#
# Prerequiste: the test script requires defines $browser
#    @driver = $browser = Selenium::WebDriver.for(browser_type)
#
# 
# Save to folder: ENV['CI_REPORTS'] || reports under current folder
# File name: screenshot-(FULL Test Case Name).png
# 
module CI::Reporter
  module RSpec3
    class Formatter
	        
      def example_failed(notification)
	  
        # In case we fail in before(:all)
        example_started(nil) if @suite.testcases.empty?

        failure = Failure.new(notification)

        current_spec.finish
        current_spec.name = notification.example.full_description
        current_spec.failures << failure
	
      	if $browser && $browser.respond_to?("save_screenshot") # shall be set in test script           
      	   reports_dir  =  ENV['CI_REPORTS'] || File.expand_path("#{Dir.getwd}/spec/reports")
           screenshots_dir = File.join(reports_dir, "screenshots")
           FileUtils.mkdir_p(screenshots_dir) unless File.exists?(screenshots_dir)
           
           spec_file_name = File.basename(notification.example.full_path)
           saved_to = File.join(screenshots_dir, spec_file_name)
            
           FileUtils.mkdir_p(saved_to) unless File.exists?(saved_to)
      	   example_name =  notification.example.full_description           
      	   $browser.save_screenshot(File.join(saved_to, "#{example_name}.png"))
      	end
  
      end

    end
  end
end
