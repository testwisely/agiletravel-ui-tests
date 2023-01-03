# Installation
	npm i -D @playwright/test
	npx playwright install
	npm i -g playwright
***Note: am experiencing issues when using global (-g) flag with @playwright/test install. DON'T USE GLOBAL INSTALL***

# Running Tests on Command Line
## Options
### Headed mode
	--headed

### Non Parallel 
	--workers=1

## Run all tests in `tests` folder
	npx playwright test

## Run specific file/s
	npx playwright test tests/01_login.spec.js tests/02_flight.spec.js

## Run test in file
	npx playwright test -g "login OK"
	npx playwright test tests/01_login.spec.js:3

# Generate XML
Playwright reporting. 

### JUnit Reporter
On bash:
	PLAYWRIGHT_JUNIT_OUTPUT_NAME=results.xml npx playwright test <file name> --reporter=junit

On playwright config file:
	// playwright.config.js
	// @ts-check

	/** @type {import('@playwright/test').PlaywrightTestConfig} */
	const config = {
	  reporter: [ ['junit', { outputFile: 'results.xml' }] ],
	};

	module.exports = config;


# Jest
## Installation
	npm install --save-dev jest

## Running tests
	npm run test