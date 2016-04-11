load File.dirname(__FILE__) + '/../test_helper.rb'

describe "User Can Login"  do
  include TestHelper

  before(:all) do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => browser_type)
    end
  end

  before(:each) do
    visit("/")
  end

  it "User can login" do
    sign_in("agileway", "testwise")
    expect(page.has_content?('Signed in!')).to be_truthy
    sign_off
  end

  it "User failed to sign in due to invalid password" do
    sign_in("agileway", "badpass")
    expect(page.has_content?('Invalid email or password')).to be_truthy
  end

end
