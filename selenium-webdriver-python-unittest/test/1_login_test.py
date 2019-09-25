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

sys.path.append(os.path.abspath('../pages'))
from login_page import LoginPage

class LoginTestCase(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if os.environ.get('BROWSER') == "firefox":
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

    def test_sign_in_failed(self):
        login_page = LoginPage(self.driver)
        login_page.login("agileway", "guess")
        # self.assertIn("Demo Fail this test case", self.driver.find_element_by_tag_name("body").text)
        
    def test_sign_in_ok(self):
        login_page = LoginPage(self.driver)
        login_page.login("agileway", "testwise")

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)