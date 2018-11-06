require 'rubygems'
gem "selenium-webdriver"
require 'selenium-webdriver'
require 'rspec'


# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"

# when running in TestWise, it will auto load TestWiseRuntimeSupport, ignore otherwise
if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
else
require "#{File.dirname(__FILE__)}/testwise_support.rb"
end

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "https://travel.agileway.net"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpecUtils
  if defined?(TestWiseRuntimeSupport)  # TestWise 5
    include TestWiseRuntimeSupport 
  else
    include TestWiseSupport	 # TestWise 4
  end

  def browser_type
    if $TESTWISE_BROWSER then
      $TESTWISE_BROWSER.downcase.to_sym
    elsif ENV["BROWSER"]
      ENV["BROWSER"].downcase.to_sym      
    else
      :chrome
    end
  end
  alias the_browser browser_type

  def site_url(default = $BASE_URL)
    $TESTWISE_PROJECT_BASE_URL || ENV["BASE_URL"] || default
  end
	
  def browser_options
    the_browser_type =  browser_type.to_s
    if the_browser_type == "chrome"
      the_chrome_options = Selenium::WebDriver::Chrome::Options.new  
      if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
        the_chrome_options.add_argument('--headless')  
      end
      return :options => the_chrome_options
      
    elsif the_browser_type == "firefox"
      the_firefox_options = Selenium::WebDriver::Firefox::Options.new  
      if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
        the_firefox_options.add_argument('--headless')
      end
      return :options => the_firefox_options

    elsif the_browser_type == "ie"
      the_ie_options =  Selenium::WebDriver::IE::Options.new  
      if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
        # not supported yet?
        # the_ie_options.add_argument('--headless')
      end
      return :options => the_ie_options

    else
      
      return {}
    end
  end
	
  def driver
    @driver
  end
  
  def browser
    @driver
  end
  
  
  # got to path based on current base url
  def goto_page(path)
    driver.navigate.to(site_url + path)
  end
  
  def page_text
    driver.find_element(:tag_name => "body").text
  end
    
end
