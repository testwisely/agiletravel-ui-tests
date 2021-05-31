require File.join(File.dirname(__FILE__), "abstract_page.rb")

class FooBarPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

    def abc
    driver.find_element(:xpath, "Sign off").click
  end
end
