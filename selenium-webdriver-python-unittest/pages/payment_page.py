from pages.base_page import BasePage

from selenium import webdriver
from selenium.webdriver.support.ui import Select

class PaymentPage(BasePage):

  def enter_holder_name(self, holder_name):
    self.driver.find_element_by_name("holder_name").send_keys(holder_name)

  def enter_card_number(self, card_number):
    self.driver.find_element_by_name("card_number").send_keys(card_number)

  def enter_expiry_month(self, expiry_month):
    Select(self.driver.find_element_by_name("expiry_month")).select_by_visible_text(expiry_month)

  def enter_expiry_year(self, expiry_year):
    Select(self.driver.find_element_by_name("expiry_year")).select_by_visible_text(expiry_year)

  def click_pay_now(self):
    self.driver.find_element_by_xpath("//input[@value='Pay now']").click()
 
  def select_card_type(self, card_type):
    self.driver.find_element_by_xpath("//input[@name='card_type' and @value='" + card_type + "']").click()
  