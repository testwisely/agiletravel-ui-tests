
if ENV["TESTWISE_RUNTIME_DIR"] && !ENV["TESTWISE_RUNTIME_DIR"].strip.empty? && Dir.exist?(ENV["TESTWISE_RUNTIME_DIR"])
  require  File.join(ENV["TESTWISE_RUNTIME_DIR"], "testwise_listener.rb")
  require  File.join(ENV["TESTWISE_RUNTIME_DIR"], "testwise_runtime_support.rb")
end

module StepHelper
  
  if defined?(TestWiseRuntimeSupport)  
    include TestWiseRuntimeSupport
  end
    
  def driver
    @driver ||= Selenium::WebDriver.for(browser_type, browser_options)
  end

  ## Helper methods
  #
   
  def goto_home_page
    home_url = site_url
    home_url += "/index.html" if site_url.include?("file://")
    driver.get(home_url )
  end

  # if your applicant supports reset datbase
  def reset_database
    driver.navigate.to("#{site_url()}/reset")
    goto_home_page
  end

  def site_url(default = $BASE_URL)
    the_site_url =  $TESTWISE_PROJECT_BASE_URL || ENV["BASE_URL"]
    if the_site_url.nil? || the_site_url.empty?
      the_site_url = default
    end
    return the_site_url
  end
  
  def sign_in(user, pass)
    driver.find_element(:id, "username").send_keys(user)
    driver.find_element(:id, "password").send_keys(pass)
    driver.find_element(:xpath, "//input[@value=\"Sign in\"]").click
  end
  
  def sign_off
    driver.find_element(:link_text, "Sign off").click
  end
  
end
