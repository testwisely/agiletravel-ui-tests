var webdriver = require('selenium-webdriver'),
                By = webdriver.By,
                until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

test.describe('Payment', function () {

  test.before(function() {
     this.timeout(timeOut);
      driver = new webdriver.Builder()
          .forBrowser('chrome')
          .build();
  });

  test.beforeEach(function() {
    this.timeout(timeOut);
    driver.get('http://travel.agileway.net');
	driver.findElement(webdriver.By.name('username')).sendKeys('agileway');
	driver.findElement(webdriver.By.name('password')).sendKeys('testwise');
	driver.findElement(webdriver.By.name('commit')).click();
  });

  test.after(function() {
    driver.quit();
  });

  test.it('[5] Book flight with payment', function() {
      this.timeout(timeOut);	  
  	 driver.findElement(By.xpath("//input[@name='tripType' and @value='oneway']")).click();	
  	 driver.findElement(By.name("fromPort")).sendKeys("New York");
  	 driver.findElement(By.name("toPort")).sendKeys("Sydney");
  	 driver.findElement(By.name("departDay")).sendKeys("02");
  	 driver.findElement(By.name("departMonth")).sendKeys("May 2016");
  	 driver.findElement(By.xpath("//input[@value='Continue']")).click();

  	 driver.findElement(By.name("passengerFirstName")).sendKeys("Bob");
  	 driver.findElement(By.name("passengerLastName")).sendKeys("Tester");
  	 driver.findElement(By.xpath("//input[@value='Next']")).click();

  	 driver.findElement(By.xpath("//input[@name='card_type' and @value='visa']")).click();		 
  	 driver.findElement(By.name("card_number")).sendKeys("4242424242424242");
  	 driver.findElement(By.xpath("//input[@value='Pay now']")).click();
	 driver.sleep(10000) 
	 driver.findElement(By.tagName("body")).getText().then(function(text){
	      assert(text.contains("Booking number"))
	  });	 
  });


});