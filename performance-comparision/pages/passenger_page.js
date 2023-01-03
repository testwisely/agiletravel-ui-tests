const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PassengerPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async enterFirstName(first_name) {
    await this.driver.fill("input[name='passengerFirstName']", first_name);    
  }

  async enterLastName(last_name) {
		await this.driver.fill("input[name='passengerLastName']", last_name);
  }

  async clickNext() {
    await this.driver.click("input:has-text('Next')");
  }
};

module.exports = PassengerPage;
