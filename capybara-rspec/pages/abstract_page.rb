require "#{File.dirname(__FILE__)}/../testwise_support.rb"
require 'capybara/dsl'

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage 

  include Capybara::DSL
  
  # If want to use debug('message') to TestWise Console, uncomment the line below
  #
  # If want to use debug('message') to TestWise Console, uncomment the statements below
  #
	if defined?(TestWiseRuntimeSupport)
	  include TestWiseRuntimeSupport
  else
  	include TestWiseSupport
	end
	

  def initialize(text = "")
    # raise "Page text '#{text}' not found on #{self.class.name}" unless @browser.text.include?(text)	
  end
    
end
