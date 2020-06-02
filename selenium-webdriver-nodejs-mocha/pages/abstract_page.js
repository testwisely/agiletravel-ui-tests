var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;
    
class AbstractPage {
  
    constructor(driver) {
        this.driver = driver;
    }

};


module.exports = AbstractPage;
