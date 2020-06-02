const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PassengerPage extends AbstractPage {

    constructor(driver) {
        super(driver);
    }

	enterFirstName(first_name) {
    	this.driver.findElement(By.name("passengerFirstName")).sendKeys(first_name);
	}
	
	enterLastName(last_name) {
    	this.driver.findElement(By.name("passengerLastName")).sendKeys(last_name);
	}
	
	clickNext() {
        this.driver.findElement(By.xpath("//input[@value='Next']")).click();		
	}
};

module.exports = PassengerPage;
