# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage < RWebSpec::AbstractWebPage

  def initialize(driver, text = "")
    super(driver, text)	
  end

  
end
