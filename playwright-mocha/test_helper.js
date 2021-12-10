const { test, expect } = require('@playwright/test');
const { chromium } = require('playwright');
var assert = require('assert');

const fs = require('fs');
const path = require('path');

function debuggingPort() {
    var port_number = Math.floor((Math.random() * 40000) + 16000);
    var port_number_str = "" + port_number;
    fs.writeFile(portFile(), port_number_str, function(err) {});
    return port_number_str;
}

function getDebuggingPort() {
  return fs.readFileSync(portFile());
}

function portFile() {
  var port_number_file_path = path.join(__dirname, "port_number.txt")
  return port_number_file_path;
}

module.exports = {

    browserType: function() {
        if (process.env.BROWSER) {
            return process.env.BROWSER;
        } else {
            return "chrome";
        }
    },

    chromeOptions: function() {
        opts = new chrome.Options();
        opts.addArguments("--remote-debugging-port=" + debuggingPort());
        return opts;
    },

    debuggingChromeOptions: function() {
        opts = new chrome.Options();
        var debugging_address = "127.0.0.1:" + getDebuggingPort();
        opts.options_["debuggerAddress"] = debugging_address;
        return opts;
    },

    is_debugging: function() {
        return (process.env.RUN_IN_TESTWISE == "true" && process.env.TESTWISE_RUNNING_AS == "test_case");
    },

    site_url: function() {
        if (process.env.BASE_URL) {
            return process.env.BASE_URL;
        } else {
            return "https://travel.agileway.net";
        }
    },

};

// BEGIN: user functions
async function login(driver, username, password) {
    await driver.findElement(webdriver.By.name('username')).sendKeys(username);
    await driver.findElement(webdriver.By.name('password')).sendKeys(password);
    await driver.findElement(webdriver.By.name('commit')).click();
}

// END: user functions


// BEGIN: module exports
module.exports.login = login;

// END: module exports