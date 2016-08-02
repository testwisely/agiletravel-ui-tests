var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('Passenger', function () {

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

  test.it('[4] Can enter passenger details (using page objects)', function() {
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    # now on passenger page
    passenger_page = PassengerPage.new(driver)
    passenger_page.click_next
    try_for(3) { expect(page_text).to include("Must provide last name") }
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next

    expect(driver.find_element(:name, "holder_name").attribute("value")).to eq("Bob Tester")
  });


});