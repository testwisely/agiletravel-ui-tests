TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'rwebspec'

require 'test/unit/assertions'

# Template version: RC-0.1

# Include all pages defined under /pages, same used in RSpec
load File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

include RWebSpec::Core
include RWebSpec::Assert

# Uncomment the following tow lines if you want to handle pop up windows
# require File.join(File.dirname(__FILE__), "..", "..", "popup_handler_helper.rb")
# include PopupHandlerHelper

$BASE_URL = $TESTWISE_PROJECT_BASE_URL
$BASE_URL ||= "http://travel.agileway.net" # Change here


def browser_type
  if $TESTWISE_BROWSER then
    $TESTWISE_BROWSER.downcase.to_sym
  elsif ENV["BROWSER"]
    ENV["BROWSER"].downcase.to_sym
  else
    RUBY_PLATFORM =~ /mingw/ ? "ie".to_sym : "firefox".to_sym
  end
end


browser = RWebSpec::WebBrowser.new($BASE_URL, nil, :browser => browser_type)


World(Test::Unit::Assertions)

# before each test case
Before do
  @browser = browser  
end

After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.exception.message}"
  end
end

at_exit do
  @browser.close if @browser
end

## Helper methods 
# - you can use these functions in your step definition files (_steps.rb)
# 

def reset_database
  # not implemented  
  
  # $base_url = base_url = $BASE_URL
  # @browser.goto("#{base_url}/reset")
  # @browser.goto("#{base_url}/")
end
