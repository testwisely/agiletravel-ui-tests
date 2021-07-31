const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class FlightPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async selectTripType(trip_type) {
    await this.driver.findElement(By.xpath("//input[@name='tripType' and @value='" + trip_type + "']")).click();
  }

  async selectDepartFrom(city) {
    await this.driver.findElement(By.name("fromPort")).sendKeys(city);
  }

  async selectArriveAt(city) {
    await this.driver.findElement(By.name("toPort")).sendKeys(city);
  }

  async selectDepartDay(day) {
    await this.driver.findElement(By.name("departDay")).sendKeys(day);
  }

  async selectDepartMonth(month_year) {
    await this.driver.findElement(By.name("departMonth")).sendKeys(month_year);
  }

  async selectReturnDay(day) {
    await this.driver.findElement(By.name("returnDay")).sendKeys(day);
  }

  async selectReturnMonth(month_year) {
    await this.driver.findElement(By.name("returnMonth")).sendKeys(month_year);
  }

  async clickContinue() {
    await this.driver.findElement(By.xpath("//input[@value='Continue']")).click();
  }
};

module.exports = FlightPage;
