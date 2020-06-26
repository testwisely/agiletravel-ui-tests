var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');
var FlightPage = require('../pages/flight_page.js')
var PassengerPage = require('../pages/passenger_page.js')

test.describe('Passenger', function() {

  test.before(function() {
    this.timeout(timeOut);
    driver = new webdriver.Builder().forBrowser(helper.browserType()).setChromeOptions(helper.chromeOptions()).build();
    driver.manage().window().setSize(1280, 720);
    driver.manage().window().setPosition(30, 78);
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get(helper.site_url());
    helper.login(driver, "agileway", "testwise");
  });

  test.after(function() {
    if (!helper.is_debugging()) {
      driver.quit();
    }
  });

  test.it('[4] Can enter passenger details', function() {
    this.timeout(timeOut);

    let flight_page = new FlightPage(driver);
    flight_page.selectTripType("oneway")
    flight_page.selectDepartFrom("New York")
    flight_page.selectArriveAt("Sydney")
    flight_page.selectDepartDay("02")
    flight_page.selectDepartMonth("May 2016")
    flight_page.clickContinue()

    let passenger_page = new PassengerPage(driver)
    passenger_page.clickNext();
    driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
      assert(the_page_text.includes("Must provide last name"))
    });

    passenger_page.enterFirstName("Bob")
    passenger_page.enterLastName("Tester")
    passenger_page.clickNext();

    // purposely an assertion failure
    driver.findElement(By.name("holder_name")).getAttribute("value").then(function(val) {
      assert.equal("Wendy Tester", val)
    });

  });


});
