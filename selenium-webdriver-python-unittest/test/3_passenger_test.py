import unittest
import xmlrunner
import time
import datetime
import sys
import os
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class PassengerTestCase(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if os.environ['BROWSER'] == "firefox":
          cls.driver = webdriver.Firefox()
        else:
          cls.driver = webdriver.Chrome()
        cls.driver.set_window_size(1280, 720)
        cls.driver.set_window_position(30, 78)

    @classmethod
    def tearDownClass(cls):
        cls.driver.quit()

    def setUp(self):
        self.driver.get("https://travel.agileway.net")

    def test_enter_passenger_details(self):
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
        self.driver.find_element_by_name("passengerFirstName").send_keys("Wendy")
        self.driver.find_element_by_name("passengerLastName").send_keys("Tester")
        self.driver.find_element_by_xpath("//input[@value='Next']").click()
        
        self.assertEqual("Wendy Tester", self.driver.find_element_by_name("holder_name").get_attribute("value"))

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)