var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;
// var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages

// END: import pages

describe('User Authentication', function() {

  before(async function() {
    this.timeout(timeOut);
    driver = new webdriver.Builder().forBrowser('chrome').setChromeOptions(helper.chromeOptions()).build();
    //driver.manage().window().setSize(1280, 720);
    //driver.manage().window().setPosition(30, 78);
  });

  beforeEach(async function() {
    this.timeout(timeOut);
    await driver.get(helper.site_url());
  });

  after(async function() {
    if (!helper.is_debugging()) {
      driver.quit();
    }
  });

  it('[1,2] Invalid user', async function() {
    this.timeout(timeOut);
    await helper.login(driver, "agileway", "badpass")
    await driver.getPageSource().then(function(page_source) {
      assert(page_source.contains("Invalid email or password"))
    });
  });

  it('User can login successfully', async function() {
    this.timeout(timeOut);
    await driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
    await driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
    await driver.findElement(webdriver.By.name('commit')).click();
    await driver.getPageSource().then(function(page_source) {
      assert(page_source.contains("Welcome"))
    });
    await driver.findElement(By.linkText("Sign off")).click();
    
  });


});
