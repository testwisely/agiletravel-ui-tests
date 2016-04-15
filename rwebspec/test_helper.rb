require 'rubygems'
require 'rwebspec'

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# The default base URL for running from command line or continuous build process
$BASE_URL = "http://travel.agileway.net"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpec::RSpecHelper
  include RWebSpec::Core

  def sign_in(username, password)
    enter_text("username", username)
    enter_text("password", password)
    click_button("Sign in")
  end
  
  def sign_off
    click_link("Sign off")
  end

  # decide browser type in order
  #   $TESTWISE_BROWSER: set in TestWise IDE
  #   ENV['BROWSER']:
  #   not set: if on windows choose IE, otherwise Chrome
  def browser_type
    if $TESTWISE_BROWSER then
      $TESTWISE_BROWSER.downcase.to_sym
    elsif ENV["BROWSER"]
      ENV["BROWSER"].downcase.to_sym
    else
      RUBY_PLATFORM =~ /mingw/ ? "ie".to_sym : "firefox".to_sym
    end
  end

  def site_url(default = $BASE_URL)
    $TESTWISE_PROJECT_BASE_URL || ENV['BASE_URL'] || default
  end      
end
