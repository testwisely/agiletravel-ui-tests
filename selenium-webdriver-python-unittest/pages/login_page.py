
from abstract_page import AbstractPage

class LoginPage(AbstractPage):
  
  def login(self, user, password):
    self.driver.find_element_by_id("username").send_keys(user)
    self.driver.find_element_by_id("password").send_keys(password)
    self.driver.find_element_by_xpath("//input[@value='Sign in']").click()

  