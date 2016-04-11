require 'rubygems'
require 'watir'
require 'watir-classic'
require 'rspec'

# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"

# when running in TestWise, it will auto load TestWiseRuntimeSupport, ignore otherwise
if defined?(TestWiseRuntimeSupport)
  ::TestWise::Runtime.load_watir_support # for watir support
else
require "#{File.dirname(__FILE__)}/testwise_support.rb"
end

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "http://travel.agileway.net"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpecUtils
  
  if defined?(TestWiseRuntimeSupport)  # TestWise 5
    include TestWiseRuntimeSupport 
  else
    include TestWiseSupport
  end

  # Helper functions
  #  - extract common functions to reuse
  #  - normally done by developers
  def login_as(username, password = "testwise")
    browser.text_field(:name, "username").set(username)
    browser.text_field(:name, "password").set(password)
    browser.button(:value,"Sign in").click
    # browser.button(:src, /btn_signin\.gif/).click
  end

  def sign_off
    browser.link(:text, "Sign off").click
  end

  def site_url(default = $BASE_URL)
    $TESTWISE_PROJECT_BASE_URL || ENV["BASE_URL"] || default
  end

  def browser
    @browser
  end

end
