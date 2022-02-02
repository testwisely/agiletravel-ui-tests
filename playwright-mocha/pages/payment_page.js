const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PaymentPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async select_visa() {
    await this.driver.findElement(By.xpath("//input[@name='card_type' and @value='visa']")).click();
  }

  async enterCardNumber(card_no) {
    await this.driver.findElement(By.name("card_number")).sendKeys(card_no);
  }

  async clickPayNow() {
    await this.driver.findElement(By.xpath("//input[@value='Pay now']")).click()
  }

};

module.exports = PaymentPage;
