require 'rubygems'
require 'selenium-webdriver'
gem "minitest"
# require "minitest/autorun"
require 'minitest/spec'

# load page classes
require File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_webdriver_support # for selenium webdriver support
end

$BASE_URL = "http://travel.agileway.net"

def the_browser
  if $TESTWISE_BROWSER then
    $TESTWISE_BROWSER.downcase.to_sym
  elsif ENV["BROWSER"] &&  ENV["BROWSER"].size > 1
    ENV["BROWSER"].downcase.to_sym
  else
    :chrome
  end
end
driver = Selenium::WebDriver.for(the_browser)

World(Minitest::Assertions)

Before do
  @driver = driver
  goto_home_page
end

# before the process ends
at_exit do
  driver.close if driver && !debugging?
end

def debugging?
  if ENV["TESTWISE_DEBUGGING"].to_s == "true" && ENV["TESTWISE_RUNNING_AS"] == "test_case"
    return true
  end
  return $TESTWISE_DEBUGGING && $TESTWISE_RUNNING_AS == "test_case"
end


## Helper methods
#
def goto_home_page
  $base_url = base_url = $TESTWISE_PROJECT_BASE_URL || $BASE_URL
  @driver.navigate.to("#{base_url}")
end

# if your applicant supports reset datbase
def reset_database
  $base_url = base_url = $TESTWISE_PROJECT_BASE_URL || $BASE_URL
  @driver.navigate.to("#{base_url}/reset")
  goto_home_page
end

def sign_in(user, pass)
  @driver.find_element(:id, "username").send_keys(user)
  @driver.find_element(:id, "password").send_keys(pass)
  @driver.find_element(:xpath,"//input[@value=\"Sign in\"]").click
end
