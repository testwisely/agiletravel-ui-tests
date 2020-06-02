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

const chrome = require("selenium-webdriver/chrome");
var helper = require('../test_helper');

var FlightPage = require('../pages/flight_page.js')

test.describe('Flight', function() {

    test.before(function() {
        this.timeout(timeOut);
        driver = new webdriver.Builder().forBrowser(helper.browserType()).setChromeOptions(helper.chromeOptions()).build();
        driver.manage().window().setSize(1280, 720);
        driver.manage().window().setPosition(30, 78);

        driver.get('https://travel.agileway.net');
        helper.login(driver, "agileway", "testwise");
    });

    test.beforeEach(function() {
        this.timeout(timeOut);
        driver.get(helper.site_url());
    });

    test.after(function() {
        if (!helper.is_debugging()) {
            driver.quit();
        }
    });

    test.it('[3] Return trip', function() {
        this.timeout(timeOut);
        let flight_page = new FlightPage(driver);
        flight_page.selectTripType("return")
        flight_page.selectDepartFrom("Sydney")
        flight_page.selectArriveAt("New York")
        flight_page.selectDepartDay("02")
        flight_page.selectDepartMonth("May 2016")
        flight_page.selectReturnDay("04")
        flight_page.selectReturnMonth("June 2016")
        flight_page.clickContinue()
		
        driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
            assert(the_page_text.includes("2016-05-02 Sydney to New York"))
            assert(the_page_text.includes("2016-06-04 New York to Sydney"))
        });
    });

    test.it('[2] One-way trip', function() {
        this.timeout(timeOut);
        let flight_page = new FlightPage(driver);
        flight_page.selectTripType("oneway")
        flight_page.selectDepartFrom("New York")
        flight_page.selectArriveAt("Sydney")
        flight_page.selectDepartDay("02")
        flight_page.selectDepartMonth("May 2016")
        flight_page.clickContinue()

        driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
            assert(the_page_text.includes("2016-05-02 New York to Sydney"))
        });
    });


});
