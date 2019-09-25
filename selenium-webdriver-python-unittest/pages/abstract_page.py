# Abstract class to initialize the base page that will be called from all pages

class AbstractPage(object):
    
  def __init__(self, driver):
     self.driver = driver
        
  