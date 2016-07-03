var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('Payment', function () {

  test.before(function() {
     this.timeout(timeOut);
      driver = new webdriver.Builder()
          .forBrowser('chrome')
          .build();
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get('http://travel.agileway.net');
  });

  test.after(function() {
    driver.quit();
  });

  test.it('[5] Book flight with payment', function() {
	    flight_page = FlightPage.new(driver)
	    flight_page.select_trip_type("oneway")
	    flight_page.select_depart_from("Sydney")
	    flight_page.select_arrive_at("New York")

	    flight_page.select_depart_day("02")
	    flight_page.select_depart_month("May 2016")
	    flight_page.click_continue

	    # now on passenger page
	    passenger_page = PassengerPage.new(driver)
	    passenger_page.enter_last_name("Tester")
	    passenger_page.click_next

	    payment_page = PaymentPage.new(driver)
	    try_for(3) {  payment_page.select_card_type("master") }
	    payment_page.enter_holder_name("Bob the Tester")
	    payment_page.enter_card_number("4242424242424242")
	    payment_page.enter_expiry_month("04")
	    payment_page.enter_expiry_year("2016")
	    payment_page.click_pay_now
	    try_for(10) { expect(driver.page_source).to include("Booking number")}	 
  });


});