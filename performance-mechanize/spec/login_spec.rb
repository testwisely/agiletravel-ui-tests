load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Performance Testing - Login" do
  include TestHelper

  before(:all) do
    @vu_reports = {}
    @browser = ::Mechanize.new
    @browser.redirect_ok = true
  end

  after(:all) do
    #@browser.quit
  end

  it "Sign in and sign off" do
    log_time("Visit home page") { @browser.get(site_url) }  # with redirect
    #File.open("/tmp/a.html", "w").write(page_resp.body)
    login_form = @browser.page.forms.first
    login_form.field_with(name: "username").value = "agileway"
    login_form.field_with(:name => "password").value = "testwise"
    log_time("Login") { @browser.submit(login_form, login_form.button_with(:name => "commit")) }
    expect(@browser.page.body).to include("Signed in!")
    log_time("Sign off") { @browser.page.link_with(:text => "Sign off").click }
  end
end
