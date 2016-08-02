var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('Flight', function () {

  test.before(function() {
     this.timeout(timeOut);
      driver = new webdriver.Builder()
          .forBrowser('chrome')
          .build();
		 driver.get('http://travel.agileway.net');
		 driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
		 driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
		 driver.findElement(webdriver.By.name('commit')).click();
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get('http://travel.agileway.net');
  });

  test.after(function() {
    driver.quit();
  });

  test.it('[3] Return trip', function() {
	   driver.findElement(By.xpath("//input[@name='tripType' and @value='return']")).click();
  });

  test.it('[2] One-way trip', function() {
	   driver.findElement(By.xpath("//input[@name='tripType' and @value='oneway']")).click();	
  });


/* 
  it "" do
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    expect(page_text).to include("2016-05-02 Sydney to New York")
    expect(page_text).to include("2016-06-04 New York to Sydney")
  end

  it "[2] One-way trip" do
    flight_page = FlightPage.new(driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.click_continue

    expect(page_text).to include("2016-05-02 Sydney to New York")
  end
*/


});