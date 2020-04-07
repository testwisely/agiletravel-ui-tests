require 'capybara/dsl'

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage 

  include Capybara::DSL
  
	if defined?(TestWiseRuntimeSupport)
	  include TestWiseRuntimeSupport
	end
	

  def initialize(text = "")
    # raise "Page text '#{text}' not found on #{self.class.name}" unless @browser.text.include?(text)	
  end
    
end
