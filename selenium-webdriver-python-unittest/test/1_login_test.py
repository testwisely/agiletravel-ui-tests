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

# load modules from parent dir, pages will be referred from there too.
sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper
from pages.login_page import LoginPage

class LoginTestCase(unittest.TestCase, TestHelper):

    @classmethod
    def setUpClass(cls):
        if os.environ.get('BROWSER') == "firefox":
          cls.driver = webdriver.Firefox()
        else:
          cls.driver = webdriver.Chrome(options = cls.browser_options())
          
        cls.save_driver_session()
        
        cls.driver.set_window_size(1280, 720)
        cls.driver.set_window_position(30, 78)
        
        executor_url = cls.driver.command_executor._url
        session_id = cls.driver.session_id
        print("WDURL: " + executor_url + ", session id: " + session_id);
        cls.puts("session id: " + session_id + ", WDURL: " + executor_url + "|");
        

    @classmethod
    def tearDownClass(cls):
        if not cls.is_debugging():
          cls.driver.quit()
        print("Not quiting");
        
    def setUp(self):
        self.driver.get(self.site_url())

    def test_sign_in_failed(self):
        # ...
        login_page = LoginPage(self.driver)
        login_page.enter_username("agileway")
        login_page.enter_password("badpass")
        login_page.click_sign_in()
        # self.assertIn("Demo Fail this test case", self.driver.find_element_by_tag_name("body").text)
        
    def test_sign_in_ok(self):
        # ...
        login_page = LoginPage(self.driver)
        login_page.enter_username("agileway")
        login_page.enter_password("testwise")
        login_page.click_sign_in()

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)