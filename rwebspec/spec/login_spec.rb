load File.dirname(__FILE__) + '/../test_helper.rb'

describe "User Login" do
  include TestHelper

  before(:all) do
    open_browser(:browser => browser_type)
  end

  after(:all) do
    close_browser unless debugging?
  end
  
  test_case "User can sign in OK" do
    sign_in("agileway", "testwise")
    assert_text_present("Welcome agileway")
    sign_off
  end

  test_case "User failed to sign in due to invalid password" do
    sign_in("agileway", "bad pass")
    sleep 1
    assert_text_present("Invalid email or password")
  end
end
