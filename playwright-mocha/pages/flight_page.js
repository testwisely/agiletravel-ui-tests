const AbstractPage = require('./abstract_page');

class FlightPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async selectTripType(trip_type) {
    const radios = await this.driver.$$("input[name=tripType]");
    if (trip_type == "oneway") {
  await radios[1].check();
    } else  {
        await radios[0].check();
    }
  }

  async selectDepartFrom(city) {
    await this.driver.selectOption("select[name='fromPort']", city);
  }

  async selectArriveAt(city) {
    await this.driver.selectOption("select[name='toPort']", city);
  }

  async selectDepartDay(day) {
    await this.driver.selectOption("select[name='departDay']", day);
  }

  async selectDepartMonth(month_year) {
     await this.driver.selectOption("#departMonth", month_year);
  }

  async selectReturnDay(day) {
    await this.driver.selectOption("select[name='returnDay']", day);

  }

  async selectReturnMonth(month_year) {
    await this.driver.selectOption("#returnMonth", month_year);
  }

  async clickContinue() {
    await this.driver.click("input:has-text('Continue')");
  }
};

module.exports = FlightPage;
