load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "User Login" do
  include TestHelper
  include LoadTestHelper
  
  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    # driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:all) do
    count = $db.get_first_value("SELECT count(*) FROM timings")
    puts "count(*): #{count}"
    $db.execute('select * from timings') do |row|
      puts row.inspect + "\n"
    end
    @driver.quit unless debugging?
  end

  it "User sign in and sign out" do
    3.times do
      log_time("Visit Home Page") { driver.get(site_url) }
      visit("/login")
      driver.find_element(:id, "username").send_keys("agileway")
      driver.find_element(:id, "password").send_keys("testwise")
      log_time("Sign in") { driver.find_element(:name, "commit").click }
      log_time("Sign out") { visit("/logout") }
    end
  end
  
end
