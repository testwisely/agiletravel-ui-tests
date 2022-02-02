const {chromium} = require('playwright');
const assert = require('assert');
let browser;

const timeOut = 15000;


// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
// END: import pages
describe('User Authentication', function() {

  before(async() => {
	  browser = await chromium.launch();
  });
  
  let page;
  
  beforeEach(async() => {
      page = await browser.newPage();
    await page.goto('https://travel.agileway.net');
  });

  after(async() => {
      await browser.close();
  });
  

  it('[1,2] Invalid user', async() => {
	  await page.fill('#username', 'agileway');
	  await page.fill('#password', 'badpass');
	  await page.click('text="Sign in"');

	  const locator = page.locator('#flash_alert');
  });
  
  it('User can login successfully', async() => {
	  await page.fill('#username', 'agileway');
	  await page.fill('#password', 'testwise');
	  await page.click('text="Sign in"');

	  await page.waitForSelector('#flash_notice');
	  const locator = page.locator('#flash_notice');
  });

});