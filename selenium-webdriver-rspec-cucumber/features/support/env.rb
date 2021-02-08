require 'rubygems'
require 'selenium-webdriver'

#require 'webdrivers' 

gem "minitest"
# require "minitest/autorun"
require 'minitest/spec'

require File.join(File.dirname(__FILE__), "step_helper.rb")
include StepHelper

# load page classes
require File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
end

$BASE_URL = "https://travel.agileway.net"

def the_browser
  if $TESTWISE_BROWSER then
    $TESTWISE_BROWSER.downcase.to_sym
  elsif ENV["BROWSER"] &&  ENV["BROWSER"].size > 1
    ENV["BROWSER"].downcase.to_sym
  else
    :chrome
  end
end
$driver = Selenium::WebDriver.for(the_browser)

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


