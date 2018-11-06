var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('Passenger', function () {

  test.before(function() {
    this.timeout(timeOut);
    driver = new webdriver.Builder()
          .forBrowser('chrome')
          .build();
    driver.manage().window().setSize(1280, 720);    
    driver.manage().window().setPosition(30, 78);
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get('https://travel.agileway.net');
  	driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
  	driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
  	driver.findElement(webdriver.By.name('commit')).click();
  });

  test.after(function() {
    driver.quit();
  });

  test.it('[4] Can enter passenger details', function() {
     this.timeout(timeOut);	  
 	 driver.findElement(By.xpath("//input[@name='tripType' and @value='oneway']")).click();	
 	 driver.findElement(By.name("fromPort")).sendKeys("New York");
 	 driver.findElement(By.name("toPort")).sendKeys("Sydney");
 	 driver.findElement(By.name("departDay")).sendKeys("02");
 	 driver.findElement(By.name("departMonth")).sendKeys("May 2016");
 	 driver.findElement(By.xpath("//input[@value='Continue']")).click();
	 
 	 driver.findElement(By.xpath("//input[@value='Next']")).click();
	 driver.findElement(By.tagName("body")).getText().then(function(the_page_text){
	   assert(the_page_text.includes("Must provide last name"))
	 });
	 
 	 driver.findElement(By.name("passengerFirstName")).sendKeys("Bob");
 	 driver.findElement(By.name("passengerLastName")).sendKeys("Tester");
 	 driver.findElement(By.xpath("//input[@value='Next']")).click();
	 
	 driver.findElement(By.name("holder_name")).getAttribute("value").then(function(val){
		assert.equal("Bob Tester", val)
	 });

  });


});
