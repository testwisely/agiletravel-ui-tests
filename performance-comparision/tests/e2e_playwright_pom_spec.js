const {test, expect } = require('@playwright/test');
const { chromium } = require('playwright');
var assert = require('assert');
const path = require('path');

const timeOut = 15000;
let driver, page, browser, context

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
var LoginPage = require('../pages/login_page.js')
var FlightPage = require('../pages/flight_page.js')
var PassengerPage = require('../pages/passenger_page.js')
var PaymentPage = require('../pages/payment_page.js')

// END: import pages
describe('End to End Playwright', function() {

  before(async function() {
    this.timeout(5000)
    browser = await chromium.launch({
      headless: false,
    });
    context = await browser.newContext();
    driver = page = await context.newPage();
    await driver.goto('https://travel.agileway.net');
  });

  beforeEach(async function() {
    this.timeout(5000)

  });
  
  afterEach(async function() {
    var testFileName = path.basename(__filename);
    await helper.save_screenshot_after_test_failed(page, this.currentTest, testFileName);
  });

  after(async function() {
    if (!helper.is_debugging()) {
      browser.close();
    }
  });

  it('E2E Playwright POM', async function() {
    this.timeout(5000)
    
    let login_page = new LoginPage(driver)
    await login_page.enterUsername("agileway")
    await login_page.enterPassword("testwise")
    await login_page.checkRememberMe()
    await login_page.clickSignIn()
    await driver.textContent("body").then(function(body_text) {
      assert(body_text.contains("Signed in"))
    });
    
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("oneway")
    await flight_page.selectDepartFrom("New York")
    await flight_page.selectArriveAt("Sydney")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("052021")
    await flight_page.clickContinue()

    let passenger_page = new PassengerPage(driver);
    await passenger_page.enterFirstName("Bob")
    await passenger_page.enterLastName("Tester")
    await passenger_page.clickNext();
    
    let payment_page = new PaymentPage(driver)
    await payment_page.selectCardType("master")
    await payment_page.enterHolderName("Bob the Tester")
    await payment_page.enterCardNumber("4242424242424242")
    await payment_page.enterExpiryMonth("04")
    await payment_page.enterExpiryYear("2016")
    await payment_page.clickPayNow()
  });


});
