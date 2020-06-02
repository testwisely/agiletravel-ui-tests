const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class FlightPage extends AbstractPage {

    constructor(driver) {
        super(driver);
    }

    selectTripType(trip_type) {
        this.driver.findElement(By.xpath("//input[@name='tripType' and @value='" + trip_type + "']")).click();
    }

    selectDepartFrom(city) {
        this.driver.findElement(By.name("fromPort")).sendKeys(city);
    }

    selectArriveAt(city) {
        this.driver.findElement(By.name("toPort")).sendKeys(city);
    }

	selectDepartDay(day) {
        this.driver.findElement(By.name("departDay")).sendKeys(day);
		
	}
	
	selectDepartMonth(month_year) {
        this.driver.findElement(By.name("departMonth")).sendKeys(month_year);		
	}
	
	selectReturnDay(day) {
        this.driver.findElement(By.name("returnDay")).sendKeys(day);		
	}
	
	selectReturnMonth(month_year) {
        this.driver.findElement(By.name("returnMonth")).sendKeys(month_year);
	}
      
	clickContinue() {
        this.driver.findElement(By.xpath("//input[@value='Continue']")).click();		
	}
};

module.exports = FlightPage;
