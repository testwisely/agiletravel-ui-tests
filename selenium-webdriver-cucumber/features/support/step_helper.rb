# Used in steps
#   include StepHelper

module StepHelper
  def goto_home_page
    $base_url = base_url = ENV["BASE_URL"] || $BASE_URL
    @driver.navigate.to("#{base_url}")
  end

  # if your applicant supports reset datbase
  def reset_database
    $base_url = base_url = ENV["BASE_URL"] || $BASE_URL
    @driver.navigate.to("#{base_url}/reset")
    goto_home_page
  end

  def sign_in(user, pass)
    @driver.find_element(:id, "username").send_keys(user)
    @driver.find_element(:id, "password").send_keys(pass)
    @driver.find_element(:xpath, "//input[@value=\"Sign in\"]").click
  end

  def sign_off
    @driver.find_element(:link_text, "Sign off").click
  end
end
