require 'ci/reporter/rspec' # version 1.0.0
require 'fileutils'
# Overrides default example failed behaviour to add saving screenshot to the reports dir.
#
# Prerequiste: the test script requires defines $browser
#    @driver = $driver = Selenium::WebDriver.for(browser_type)
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
	
      	if $driver && $driver.respond_to?("save_screenshot") # shall be set in test script           
      	   reports_dir  =  ENV['CI_REPORTS'] || File.expand_path("#{Dir.getwd}/spec/reports")
           begin
             screenshots_dir = File.join(reports_dir, "screenshots")
             FileUtils.mkdir_p(screenshots_dir) unless File.exists?(screenshots_dir)
           
             spec_file_name = File.basename(notification.example.file_path)
             saved_to = File.join(screenshots_dir, spec_file_name)
            
             FileUtils.mkdir_p(saved_to) unless File.exists?(saved_to)
        	   example_name =  notification.example.description 
             # with folder, not using full_description      
        	   $driver.save_screenshot(File.join(saved_to, "#{example_name}.png"))
           rescue  => e
             # don't cause build to stop if errors happens
             fio = File.open( File.join(reports_dir, "error.log"), "a")
             fio.puts(e)
             fio.puts(e.backtrace)
             fio.flush
             fio.close
           end
           
      	end
  
      end

    end
  end
end
