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
var PaymentPage = require('../pages/payment_page.js')

test.describe('Payment', function() {

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

    test.it('[5] Book flight with payment', function() {
        this.timeout(timeOut);
        let flight_page = new FlightPage(driver);
        flight_page.selectTripType("oneway")
        flight_page.selectDepartFrom("New York")
        flight_page.selectArriveAt("Sydney")
        flight_page.selectDepartDay("02")
        flight_page.selectDepartMonth("May 2016")
        flight_page.clickContinue()

        let passenger_page = new PassengerPage(driver)
        passenger_page.enterFirstName("Bob")
        passenger_page.enterLastName("Tester")
        passenger_page.clickNext();

        let payment_page = new PaymentPage(driver)
        driver.findElement(By.xpath("//input[@name='card_type' and @value='visa']")).click();
        driver.findElement(By.name("card_number")).sendKeys("4242424242424242");
        driver.findElement(By.xpath("//input[@value='Pay now']")).click();
        driver.sleep(10000)
        driver.findElement(By.tagName("body")).getText().then(function(text) {
            assert(text.contains("Booking number"))
        });
    });

});
