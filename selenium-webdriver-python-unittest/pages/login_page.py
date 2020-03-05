from pages.base_page import BasePage

class LoginPage(BasePage):

  def enter_username(self, user):
    self.driver.find_element_by_id("username").send_keys(user)
 
  def enter_password(self, password):
    self.driver.find_element_by_id("password").send_keys(password)

  def click_sign_in(self):
    self.driver.find_element_by_xpath("//input[@value='Sign in']").click()
