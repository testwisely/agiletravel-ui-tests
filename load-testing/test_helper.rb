# require 'rubygems'
gem "selenium-webdriver"
require 'selenium-webdriver'
require 'rspec'

# include utility functions such as 'page_text', 'try_for', 'fail_safe', ..., etc.
require "#{File.dirname(__FILE__)}/agileway_utils.rb"

# when running in TestWise, it will auto load TestWiseRuntimeSupport, ignore otherwise
if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
end

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "https://travel.agileway.net"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include AgilewayUtils
  if defined?(TestWiseRuntimeSupport)  # TestWise 5+
    include TestWiseRuntimeSupport 
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
    the_browser_type = browser_type.to_s

    if the_browser_type == "chrome"
      the_chrome_options = Selenium::WebDriver::Chrome::Options.new
      # make the same behaviour as Python/JS
      # leave browser open until calls 'driver.quit'
      the_chrome_options.add_option("detach", true)

      if ENV["BROWSER_HEADLESS"] == "true"
        the_chrome_options.add_argument("--headless")
      end

      if defined?(TestWiseRuntimeSupport)
        browser_debugging_port = get_browser_debugging_port() rescue 19218 # default port
        puts("Enabled chrome browser debug port: #{browser_debugging_port}")
        the_chrome_options.add_argument("--remote-debugging-port=#{browser_debugging_port}")
      else
        # puts("Chrome debugging port not enabled.")
      end

      return :options => the_chrome_options

    elsif the_browser_type == "firefox"
      the_firefox_options = Selenium::WebDriver::Firefox::Options.new
      if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
        the_firefox_options.add_argument("--headless")
      end
      return :options => the_firefox_options
    elsif the_browser_type == "ie"
      the_ie_options = Selenium::WebDriver::IE::Options.new
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
  def visit(path)
    driver.navigate.to(site_url + path)
  end
  
  def page_text
    driver.find_element(:tag_name => "body").text
  end
  
  def debugging?
    return ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["TESTWISE_RUNNING_AS"] == "test_case"
  end
  
  # prevent extra long string generated test scripts that blocks execution when running in 
  # TestWise or BuildWise Agent
  def safe_print(str)
    return if str.nil? || str.empty?
    if (str.size < 250)
      puts(str)
      return;
    end
    
    if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["RUN_IN_BUILDWISE_AGENT"].to_s == "true"
      puts(str[0..200])
    end
  end
  
  def login_as(user, pass = "testwise")
    driver.find_element(:id, "username").send_keys(user)
    driver.find_element(:id, "password").send_keys(pass)
    driver.find_element(:name, "commit").click
  end

  def logout
    driver.find_element(:link_text, "Sign off").click
  end
  
end
