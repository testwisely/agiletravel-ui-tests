from pages.abstract_page import AbstractPage

from selenium import webdriver
from selenium.webdriver.support.ui import Select

class PassengerPage(AbstractPage):

  def enter_first_name(self, passenger_first_name):
    self.driver.find_element_by_name("passengerFirstName").send_keys(passenger_first_name)

  def enter_last_name(self, passenger_last_name):
    self.driver.find_element_by_name("passengerLastName").send_keys(passenger_last_name)

  def click_next(self):
    self.driver.find_element_by_name("passengerLastName").submit() 