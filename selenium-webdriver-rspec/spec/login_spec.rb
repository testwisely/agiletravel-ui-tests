load File.dirname(__FILE__) + '/../test_helper.rb'

describe "User Login" do
  include TestHelper

  before(:all) do
    @driver = $browser = Selenium::WebDriver.for(browser_type)
    driver.navigate.to(site_url)
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[1] Can sign in OK" do
    goto_page("/login")
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "testwise")  
    # selenium does not have browser.text yet
    try_for(3) {  driver.page_source.include?("Welcome").should == true }
    driver.find_element(:link_text, "Sign off").click
  end

  it "[1] User failed to sign in due to invalid password", :tag => "showcase" do
    goto_page("/login")
    login_page = LoginPage.new(driver)
    login_page.login("agileway", "badpass")
    driver.page_source.include?("Invalid email or password").should == true
  end

end
