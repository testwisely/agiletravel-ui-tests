from pages.abstract_page import AbstractPage

from selenium import webdriver
from selenium.webdriver.support.ui import Select

class FlightPage(AbstractPage):

  def select_trip_type(self, trip_type):
    self.driver.find_element_by_xpath("//input[@name='tripType' and @value='" + trip_type + "']").click()

  def select_depart_from(self, from_port):
    Select(self.driver.find_element_by_name("fromPort")).select_by_visible_text(from_port)

  def select_arrive_at(self, to_port):
    Select(self.driver.find_element_by_name("toPort")).select_by_visible_text(to_port)

  def select_depart_day(self, depart_day):
    Select(self.driver.find_element_by_name("departDay")).select_by_visible_text(depart_day)

  def select_depart_month(self, depart_month):
    Select(self.driver.find_element_by_name("departMonth")).select_by_visible_text(depart_month)

  def select_return_day(self, return_day):
    Select(self.driver.find_element_by_name("returnDay")).select_by_visible_text(return_day)

  def select_return_month(self, return_month):
    Select(self.driver.find_element_by_id("returnMonth")).select_by_visible_text(return_month)

  def click_continue(self):
    self.driver.find_element_by_xpath("//input[@value='Continue']").click()
