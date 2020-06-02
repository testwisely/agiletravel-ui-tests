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

test.describe('User Authentication', function() {

    test.before(function() {
        this.timeout(timeOut);
        driver = new webdriver.Builder().forBrowser('chrome')
                 .setChromeOptions(helper.chromeOptions()).build();
        driver.manage().window().setSize(1280, 720);
        driver.manage().window().setPosition(30, 78);
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

    test.it('[1,2] Invalid user', function() {
        this.timeout(timeOut);
        helper.login(driver, "agileway", "badpass")
        driver.getPageSource().then(function(page_source) {
            assert(page_source.contains("Invalid email or password"))
        });
    });

    test.it('User can login successfully', function() {
        this.timeout(timeOut);
        driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
        driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
        driver.findElement(webdriver.By.name('commit')).click();
        driver.getPageSource().then(function(page_source) {
            assert(page_source.contains("Welcome"))
        });
        driver.findElement(By.linkText("Sign off")).click();
    });


});
