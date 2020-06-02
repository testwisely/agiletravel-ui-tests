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

sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper

from pages.login_page import LoginPage
from pages.flight_page import FlightPage

class FlightTestCase(unittest.TestCase, TestHelper):

  @classmethod
  def setUpClass(cls):
    # open_browser method defined in test_helper.py
    cls.driver = cls.open_browser();
    cls.driver.set_window_size(1280, 720)
    cls.driver.set_window_position(30, 78)

    cls.driver.get(cls.site_url())
    login_page = LoginPage(cls.driver)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()

  @classmethod
  def tearDownClass(cls):
    time.sleep(1)
    cls.driver.quit()

  def setUp(self):
    self.driver.get(self.site_url())

  def test_select_return_flight(self):
    flight_page = FlightPage(self.driver)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2016")
    flight_page.select_return_day("04")
    flight_page.select_return_month("June 2016")
    flight_page.click_continue

    time.sleep(1)

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)
