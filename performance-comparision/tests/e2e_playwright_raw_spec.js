const {  test, expect } = require('@playwright/test');
const { chromium } = require('playwright');
var path = require("path");
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
describe('E2E Playwright', function() {
	this.timeout(5000);
  before(async function() {
    browser = await chromium.launch({
      headless: false,
    });
    context = await browser.newContext();
    driver = page = await context.newPage();
  });

  beforeEach(async function() {
    await driver.goto('https://travel.agileway.net');
  });

  after(async function() {
      browser.close();
  });

  afterEach(async function() {
  });

  it('End to End Playwright', async function() {
    this.timeout(5000)
    await driver.locator('text=Login').click()
    await driver.fill("#username", "agileway")
    await driver.fill("#password", "testwise")
    await driver.click("#remember_me")
    await driver.click("input:has-text('Sign in')")
    await driver.textContent("body").then(function(body_text) {
      //console.log(body_text)
      assert(body_text.contains("Signed in"))
    });
    
    const trip_radio = await driver.$$("input[name=tripType]");
    await trip_radio[1].check();
    await driver.selectOption("select[name='fromPort']", "New York");
    await driver.selectOption("select[name='toPort']", "Sydney");
    await driver.selectOption("select[name='departDay']", "02");
    await driver.selectOption("#departMonth", "052021");
    await driver.click("input:has-text('Continue')");
    
		await driver.fill("input[name='passengerFirstName']", "Bob");    
		await driver.fill("input[name='passengerLastName']", "Tester");
    await driver.click("input:has-text('Next')");

    const card_type_radio = await driver.$$("input[name='card_type']");
    await card_type_radio[1].check();
		await driver.fill("input[name='holder_name']", "Bob the Tester");
		await driver.fill("input[name='card_number']", "4242424242424242");
    await driver.selectOption("select[name='expiry_month']", "04");
    await driver.selectOption("select[name='expiry_year']", "2016");
    await driver.click("input:has-text('Pay now')");
  });

});
