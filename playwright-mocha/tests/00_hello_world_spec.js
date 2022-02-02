const {chromium} = require('playwright');
const assert = require('assert');
let browser;

describe('Sandbox', function() {
	before(async() => {
	  browser = await chromium.launch({
		  headless: false
	  });
	});

	after(async () => {
	  await browser.close();
	});

	let page;

	beforeEach(async() => {
	  page = await browser.newPage();
	});

	afterEach(async () => {
	  await page.close();
	});

	it('should work', async () => {
	  await page.goto('https://www.example.com/');
	  assert.equal(await page.title(), 'Example Domain');
	});
	
    it('[1,2] Invalid user', async() => {
	  await page.goto('https://travel.agileway.net');
		
  	  await page.fill('#username', 'agileway');
  	  await page.fill('#password', 'badpass');
  	  await page.click('text="Sign in"');

  	  const locator = page.locator('#flash_alert');
    });
});