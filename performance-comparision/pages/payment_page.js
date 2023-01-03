const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PaymentPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async enterHolderName(holder_name) {
    await this.driver.locator("[name=holder_name]").fill(holder_name);
  }

  async enterCardNumber(card_number) {
    await this.driver.locator("[name=card_number]").fill(card_number);
  }

  async enterExpiryMonth(expiry_month) {
    await this.driver.selectOption("select[name='expiry_month']", expiry_month);
  }

  async enterExpiryYear(expiry_year) {
    await this.driver.selectOption("select[name='expiry_year']", expiry_year);
  }

  async selectCardType(card_type) {
     await this.driver.locator("//input[@name='card_type' and @value='" + card_type +  "']").click();
   //  await driver.find_element(:xpath, "//input[@name='card_type' and @value='" + card_type +  "']").click
  }

  async clickPayNow() {
    await this.driver.click("input:has-text('Pay now')");
  }

};

module.exports = PaymentPage;
