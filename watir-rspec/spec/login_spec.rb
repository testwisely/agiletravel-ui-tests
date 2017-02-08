load File.join(File.dirname(__FILE__), "..", "test_helper.rb")

# These lines are comments (starting with #)
#
describe "User Login" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new(browser_type)
    @browser.goto(site_url)
  end

  before(:each) do
    browser.goto $TESTWISE_PROJECT_BASE_URL || "http://travel.agileway.net" # set back to home page to start next one
  end

  after(:each) do
    failsafe { browser.link(:text, "Sign off").click }  unless debugging? 
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "Login OK" do
    home_page = HomePage.new(browser)
    home_page.enter_user_name "agileway"
    home_page.enter_password "testwise"
    home_page.click_sign_in
    try_for(3) { expect(browser.text).to include("Welcome agileway") }
  end

  it "Login failed (incorrect password)" do
    home_page = HomePage.new(browser)
    home_page.enter_user_name "agileway"
    home_page.enter_password "badPass"
    home_page.click_sign_in
    try_for(3) { expect(browser.text).to include("Invalid email or password") }
  end

end
