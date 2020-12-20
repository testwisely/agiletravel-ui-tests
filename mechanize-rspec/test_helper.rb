# require 'rubygems'
require "mechanize"
require "rspec"

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
$BASE_URL = "http://travel.agileway.net"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper
  include AgilewayUtils
  if defined?(TestWiseRuntimeSupport) # TestWise 5+
    include TestWiseRuntimeSupport
  end

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

  def site_url(default = $BASE_URL)
    $TESTWISE_PROJECT_BASE_URL || ENV["BASE_URL"] || default
  end

  def driver
    @driver
  end

  def browser
    @browser
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
      return
    end

    if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["RUN_IN_BUILDWISE_AGENT"].to_s == "true"
      puts(str[0..200])
    end
  end

  #
  # Usage
  #  log_time { browser.click_button('Confirm') }
  def log_time(msg, &block)
    start_time = Time.now
    Thread.current[:log] ||= []
    begin
      yield
    ensure
      end_time = Time.now
      format_date_time = start_time.strftime("%Y-%m-%d %H:%M:%S")
      puts("#{Thread.current[:id]}|#{msg}|#{Time.now - start_time}")
      @vu_reports[Thread.current[:id]] ||= []
      @vu_reports[Thread.current[:id]] << { "#{msg}": Time.now - start_time }
    end
  end
  
  # handle redirect
  def visit(url)
    the_resp = nil
    begin
      puts "url: #{url}"
      the_resp = Net::HTTP.get_response(URI.parse(url))
      #redirect:  <a href="http://other">redirected</a>
      url = the_resp["location"]
    end while the_resp.is_a?(Net::HTTPRedirection)
    return the_resp
  end
end
