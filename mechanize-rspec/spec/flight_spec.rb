load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Performance Testing - Select Flight" do
  include TestHelper

  before(:all) do
    @vu_reports = {}
    @browser = ::Mechanize.new
    @browser.redirect_ok = true
  end

  after(:all) do
  end

  it "Select Flight" do
    log_time("Visit home page") { @browser.get(site_url) }  # with redirect
    login_form = @browser.page.forms.first
    login_form.field_with(name: "username").value = "agileway"
    login_form.field_with(:name => "password").value = "testwise"
    log_time("Login") { @browser.submit(login_form, login_form.button_with(:name => "commit")) }
    expect(@browser.page.body).to include("Signed in!")

    flight_form = @browser.page.forms.first
    flight_form.radiobutton_with(:name => "tripType", :value => "oneway").check
    flight_form.field_with(:name => "fromPort").value = "Sydney"
    flight_form.field_with(:name => "toPort").value = "New York"
    log_time("Select Flight") { @browser.submit(flight_form) }
    expect(@browser.page.body).to include("oneway trip")
  end
end
