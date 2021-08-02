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

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages

var FlightPage = require('../pages/flight_page.js')
var PassengerPage = require('../pages/passenger_page.js')

// END: import pages


describe('Passenger', function() {

  before(async function() {
    this.timeout(timeOut);
    driver = new webdriver.Builder().forBrowser(helper.browserType()).setChromeOptions(helper.chromeOptions()).build();
    driver.manage().window().setRect({width: 1027, height: 700, x: 30, y: 78})
  });

  beforeEach(async function() {
    this.timeout(timeOut);
    await driver.get(helper.site_url());
    await helper.login(driver, "agileway", "testwise");
  });

  after(function() {
    if (!helper.is_debugging()) {
      driver.quit();
    }
  });

  it('[4] Can enter passenger details', async function() {
    this.timeout(timeOut);

    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("oneway")
    await flight_page.selectDepartFrom("New York")
    await flight_page.selectArriveAt("Sydney")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("May 2016")
    await flight_page.clickContinue()

    let passenger_page = new PassengerPage(driver)
    await passenger_page.clickNext();
    await driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
      assert(the_page_text.includes("Must provide last name"))
    });

    await passenger_page.enterFirstName("Bob")
    await passenger_page.enterLastName("Tester")
    await passenger_page.clickNext();

    // purposely an assertion failure
    await driver.findElement(By.name("holder_name")).getAttribute("value").then(function(val) {
      assert.equal("Wendy Tester", val)
    });

  });


});
