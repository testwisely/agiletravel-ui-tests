require "rubygems"
require "selenium-webdriver"

#require 'webdrivers'

# include utility functions such as 'page_text', 'try_for', 'fail_safe', ..., etc.
require File.join(File.dirname(__FILE__), "..", "..", "agileway_utils.rb")
include AgilewayUtils

gem "minitest"
# require "minitest/autorun"
require "minitest/spec"

require File.join(File.dirname(__FILE__), "step_helper.rb")
include StepHelper

# load page classes
require File.join(File.dirname(__FILE__), "..", "..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
end

$BASE_URL = "https://travel.agileway.net"

def browser_type
  if $TESTWISE_BROWSER
    $TESTWISE_BROWSER.downcase.to_sym
  elsif ENV["BROWSER"]
    ENV["BROWSER"].downcase.to_sym
  else
    :chrome
  end
end

alias the_browser browser_type

def browser_options
  the_browser_type = browser_type.to_s

  if the_browser_type == "chrome"
    the_chrome_options = Selenium::WebDriver::Chrome::Options.new
    # make the same behaviour as Python/JS
    # leave browser open until calls 'driver.quit'
    the_chrome_options.add_option("detach", true)

    # if Selenium unable to detect Chrome browser in default location
    # the_chrome_options.binary = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"

    if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
      the_chrome_options.add_argument("--headless")
    end

    # the_chrome_options.binary = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"

    if defined?(TestWiseRuntimeSupport)
      browser_debugging_port = get_browser_debugging_port() rescue 19218 # default port
      puts("Enabled chrome browser debug port: #{browser_debugging_port}")
      the_chrome_options.add_argument("--remote-debugging-port=#{browser_debugging_port}")
    else
      # puts("Chrome debugging port not enabled.")
    end

    if Selenium::WebDriver::VERSION =~ /^3/
      if defined?(TestwiseListener)
        return :options => the_chrome_options, :listener => TestwiseListener.new
      else
        return :options => the_chrome_options
      end
    else
      if defined?(TestwiseListener)
        return :capabilities => the_chrome_options, :listener => TestwiseListener.new
      else
        return :capabilities => the_chrome_options
      end
    end
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

# a possible issue with Cucumber 4.0, 
# in dry run mode, still invoke new driver instance
unless ENV["CUCUMBER_DRY_RUN"] && ENV["CUCUMBER_DRY_RUN"] == "true"
  $driver = Selenium::WebDriver.for(browser_type, browser_options)
end

World(Minitest::Assertions)

Before do
  @driver = $driver
  goto_home_page
end

# before the process ends
at_exit do
  $driver.close if $driver && !debugging?
end

def debugging?
  if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["TESTWISE_RUNNING_AS"] == "test_case"
    return true
  end
  return $TESTWISE_DEBUGGING && $TESTWISE_RUNNING_AS == "test_case"
end
