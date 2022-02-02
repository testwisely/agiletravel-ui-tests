const {chromium} = require('playwright');
const assert = require('assert');
let browser;
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