import unittest
import time
import datetime
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class LoginTestCase(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.driver = webdriver.Chrome()

    @classmethod
    def tearDownClass(cls):
        cls.driver.quit()

    def setUp(self):
        self.driver.get("http://travel.agileway.net")

    def wait_for_ajax_complete(self, max_seconds):
        count = 0
        while (count < max_seconds):
            count += 1
            is_ajax_complete = self.driver.execute_script("return window.jQuery != undefined && jQuery.active == 0");
            if is_ajax_complete:
                return
            else:
                time.sleep(1)
        raise Exception("Timed out waiting for AJAX call after %i seconds" % max_seconds)

    def test_select_flight(self):
        # ...
        self.driver.find_element_by_id("username").send_keys("agileway")
        self.driver.find_element_by_id("password").send_keys("testwise")
        self.driver.find_element_by_xpath("//input[@value='Sign in']").click()
        self.driver.find_element_by_xpath("//input[@name='tripType' and @value='oneway']").click()
        Select(self.driver.find_element_by_name("fromPort")).select_by_visible_text("New York")
        Select(self.driver.find_element_by_name("toPort")).select_by_visible_text("Sydney")
        Select(self.driver.find_element_by_name("departDay")).select_by_visible_text("04")
        Select(self.driver.find_element_by_name("departMonth")).select_by_visible_text("March 2016")
        self.driver.find_element_by_xpath("//input[@value='Continue']").click()
        time.sleep(1)


