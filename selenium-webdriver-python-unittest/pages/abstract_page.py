from selenium import webdriver
from selenium.webdriver.support.ui import Select

class AbstractPage(object):

  def __init__(self, driver):
    self.driver = driver
