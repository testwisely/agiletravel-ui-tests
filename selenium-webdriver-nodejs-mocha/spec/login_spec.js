var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('User Authentication', function () {

  test.before(function() {
     this.timeout(timeOut);
      driver = new webdriver.Builder()
          .forBrowser('chrome')
          .build();
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get('http://travel.agileway.net');
  });

  test.after(function() {
    driver.quit();
  });

  test.it('Invalid user', function() {
     this.timeout(timeOut);	  
     driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
     driver.findElement(webdriver.By.name('password')).sendKeys('badpass');
     driver.findElement(webdriver.By.name('commit')).click();
		 driver.getPageSource().then(function(page_source){
	     assert(page_source.contains("Invalid email or password"))
		 });
  });

  test.it('User can login successfully', function() {
     this.timeout(timeOut);	  
     driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
     driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
     driver.findElement(webdriver.By.name('commit')).click();
		 driver.getPageSource().then(function(page_source){
			 assert(page_source.contains("Welcome"))
	   });
	   driver.findElement(By.linkText("Sign off")).click();
  });


});