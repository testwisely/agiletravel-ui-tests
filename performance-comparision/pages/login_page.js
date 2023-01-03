const AbstractPage = require('./abstract_page');

class LoginPage extends AbstractPage {

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

  async enterUsername(username) {
    await this.driver.fill("#username", username);
  }

  async enterPassword(passwd) {
    await this.driver.fill("#password", passwd);
  }

  async checkRememberMe() {
    await this.driver.click("#remember_me");
  }

  async clickSignIn() {
     await this.driver.click("input:has-text('Sign in')");
  }

};

module.exports = LoginPage;
