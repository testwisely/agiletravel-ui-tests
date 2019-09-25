require 'rubygems'
require "json"
require 'active_support/all'
require 'selenium-webdriver'
require 'capybara/rspec'
require 'rspec'
# Capybara cheatsheet
# https://gist.github.com/zhengjia/428105


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
$BASE_URL = "https://travel.agileway.net"

Capybara.default_driver = :selenium
Capybara.app_host = $BASE_URL


# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include Capybara::DSL

  if defined?(TestWiseRuntimeSupport)  # TestWise 5
    include TestWiseRuntimeSupport
  else
    include TestWiseSupport
  end

  #
  # An Example helper function
  #
  # In you test case, you can use
  #
  #   login_as("homer", "Password")
  #   login_as("bart")  # the password will be default to 'TestWise'
  #   login("lisa")     # same as login_as
  #
  #
  # def login_as(username, password = "TestWise")
  #   enter_text("username", username)
  #   enter_text("password", password)
  #   click_link("Login")
  # end
  # alias login login_as


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
    $TESTWISE_PROJECT_BASE_URL || ENV['BASE_URL'] || default
  end


  def browser
    @browser
  end

  def driver
    @browser
  end

  def	page_text
    @browser.find_element(:tag_name => "body").text
  end

  def sign_in(username, password)
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    find_button('Sign in').click
  end

  def sign_off
    click_link("Sign off")
  end

  def browser_options
    the_browser_type =  browser_type.to_s
    if the_browser_type == "chrome"
      the_chrome_options = Selenium::WebDriver::Chrome::Options.new  
      # make the same behaviour as Python/JS
      # leave browser open until calls 'driver.quit'
      the_chrome_options.add_option("detach", true)
      
      if $TESTWISE_BROWSER_HEADLESS || ENV["BROWSER_HEADLESS"] == "true"
        the_chrome_options.add_argument('--headless')  
      end
      return {:browser => :chrome, :options => the_chrome_options}
      
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
  
end
