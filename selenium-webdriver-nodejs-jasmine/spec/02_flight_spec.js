var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;
//var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

const chrome = require("selenium-webdriver/chrome");
var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages

var FlightPage = require('../pages/flight_page.js')

// END: import pages

describe('Flight', function() {

  beforeAll(async function() {
    driver = new webdriver.Builder().forBrowser(helper.browserType()).setChromeOptions(helper.chromeOptions()).build();
    driver.manage().window().setRect({width: 1027, height: 700, x: 30, y: 78})
    await driver.get('https://travel.agileway.net');
    await helper.login(driver, "agileway", "testwise");
  });

  beforeEach(async function() {
    await driver.get(helper.site_url());
  });

  afterAll(async function() {
    if (!helper.is_debugging()) {
      driver.quit();
    }
  });

  it('[3] Return trip', async function() {
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("return")
    await flight_page.selectDepartFrom("Sydney")
    await flight_page.selectArriveAt("New York")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("May 2016")
    await flight_page.selectReturnDay("04")
    await flight_page.selectReturnMonth("June 2016")
    await flight_page.clickContinue()

    await driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
      assert(the_page_text.includes("2016-05-02 Sydney to New York"))
      assert(the_page_text.includes("2016-06-04 New York to Sydney"))
    });
  });

  it('[2] One-way trip', async function() {
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("oneway")
    await flight_page.selectDepartFrom("New York")
    await flight_page.selectArriveAt("Sydney")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("May 2016")
    await flight_page.clickContinue()

    await driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
      assert(the_page_text.includes("2016-05-02 New York to Sydney"))
    });
  });


});
