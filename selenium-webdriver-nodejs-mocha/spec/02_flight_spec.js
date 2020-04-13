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

test.describe('Flight', function() {

    test.before(function() {
        this.timeout(timeOut);
        driver = new webdriver.Builder().forBrowser('chrome')
                 .setChromeOptions(helper.chromeOptions()).build();
        driver.manage().window().setSize(1280, 720);
        driver.manage().window().setPosition(30, 78);
        driver.get('https://travel.agileway.net');
        helper.login(driver, "agileway", "testwise");
    });

    test.beforeEach(function() {
        this.timeout(timeOut);
        driver.get('https://travel.agileway.net');
    });

    test.after(function() {
        if (process.env.RUN_IN_TESTWISE == "true" && process.env.TESTWISE_RUNNING_AS == "test_case") {
            console.log("leave browser open");
        } else {
            driver.quit();
        }
    });

    test.it('[3] Return trip', function() {
        this.timeout(timeOut);
        driver.findElement(By.xpath("//input[@name='tripType' and @value='return']")).click();
        driver.findElement(By.name("fromPort")).sendKeys("Sydney");
        driver.findElement(By.name("toPort")).sendKeys("New York");
        driver.findElement(By.name("departDay")).sendKeys("02");
        driver.findElement(By.name("departMonth")).sendKeys("May 2016");
        driver.findElement(By.name("returnDay")).sendKeys("04");
        driver.findElement(By.name("returnMonth")).sendKeys("June 2016");
        driver.findElement(By.xpath("//input[@value='Continue']")).click();
        driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
            assert(the_page_text.includes("2016-05-02 Sydney to New York"))
            assert(the_page_text.includes("2016-06-04 New York to Sydney"))
        });
    });


    test.it('[2] One-way trip', function() {
        this.timeout(timeOut);
        driver.findElement(By.xpath("//input[@name='tripType' and @value='oneway']")).click();
        driver.findElement(By.name("fromPort")).sendKeys("New York");
        driver.findElement(By.name("toPort")).sendKeys("Sydney");
        driver.findElement(By.name("departDay")).sendKeys("02");
        driver.findElement(By.name("departMonth")).sendKeys("May 2016");
        driver.findElement(By.xpath("//input[@value='Continue']")).click();

        driver.findElement(By.tagName("body")).getText().then(function(the_page_text) {
            assert(the_page_text.includes("2016-05-02 New York to Sydney"))
        });
    });



});
