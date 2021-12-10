const {test, expect } = require('@playwright/test');
const { chromium } = require('playwright');
var assert = require('assert');

const timeOut = 15000;
let driver, page, browser, context

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
var FlightPage = require('../pages/flight_page.js')

// END: import pages
describe('Flight', function() {

  before(async function() {
    this.timeout(5000)
    browser = await chromium.launch({
      headless: false,
      executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    });
    context = await browser.newContext();
    driver = page = await context.newPage();
    await driver.goto('https://travel.agileway.net');
    await driver.fill("#username", "agileway")
    await driver.fill("#password", "testwise")
    await driver.click("input:has-text('Sign in')")
  });

  beforeEach(async function() {
    this.timeout(5000)
    await driver.goto('https://travel.agileway.net');

  });

  after(async function() {
    if (!helper.is_debugging()) {
      driver.close();
    }
  });

  it('[3] Return trip', async function() {
    this.timeout(15000)
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("return")
    await flight_page.selectDepartFrom("Sydney")
    await flight_page.selectArriveAt("New York")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("052021")
    await flight_page.selectReturnDay("04")
    // by default selectOption is by value, 
    // await flight_page.selectReturnMonth("June 2021")
    await flight_page.selectReturnMonth("062021")
    await flight_page.clickContinue()
    await driver.textContent("body").then(function(body_text) {
      //console.log(body_text)
      assert(body_text.contains("2021-05-02   Sydney to New York"))
      assert(body_text.contains("2021-06-04  New York to Sydney"))
    })
  });


  it('[2] One-way trip', async function() {
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("oneway")
    await flight_page.selectDepartFrom("New York")
    await flight_page.selectArriveAt("Sydney")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("052021")
    await flight_page.clickContinue()
    await driver.textContent("body").then(function(body_text) {
      //console.log(body_text)
      assert(body_text.contains("2021-05-02   New York to Sydney"))
    })
  });


});
