const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PassengerPage extends AbstractPage {

    constructor(driver) {
        super(driver);
    }

	enterFirstName(first_name) {
    	this.driver.findElement(By.name("passengerFirstName")).sendKeys("Bob");
	}
	
	enterLastName(last_name) {
    	this.driver.findElement(By.name("passengerLastName")).sendKeys("Tester");
	}
	
	clickNext() {
        this.driver.findElement(By.xpath("//input[@value='Next']")).click();		
	}
};

module.exports = PassengerPage;
