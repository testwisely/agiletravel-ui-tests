const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PaymentPage extends AbstractPage {

    constructor(driver) {
        super(driver);
    }

	select_visa() {
        this.driver.findElement(By.xpath("//input[@name='card_type' and @value='visa']")).click();
	}
	
	enterCardNumber(card_no) {
		this.driver.findElement(By.name("card_number")).sendKeys(card_no);
	}
	
	clickPayNow() {
        this.driver.findElement(By.xpath("//input[@value='Pay now']")).click()
	}
    
};

module.exports = PaymentPage;
