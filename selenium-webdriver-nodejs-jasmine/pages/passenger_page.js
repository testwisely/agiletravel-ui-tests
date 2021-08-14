const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PassengerPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async enterFirstName(first_name) {
    await this.driver.findElement(By.name("passengerFirstName")).sendKeys(first_name);
  }

  async enterLastName(last_name) {
    await this.driver.findElement(By.name("passengerLastName")).sendKeys(last_name);
  }

  async clickNext() {
    await this.driver.findElement(By.xpath("//input[@value='Next']")).click();
  }
};

module.exports = PassengerPage;
