# The script will generate MadCow scirpt from a well structure Selenium WebDriver + Page automated tests.
gem "sexp_processor"
gem "ruby_parser"
require 'active_support/all'

require File.join(File.dirname(__FILE__), "project_file.rb")
require File.join(File.dirname(__FILE__), "ruby_file.rb")

class PageOperation
  
  attr_accessor :page_name
  attr_accessor :operation_name
  attr_accessor :control_name  
  attr_accessor :control_type
  attr_accessor :value  

end


$page_operations = []

def getControlNameByPageOperation(page_name, method_name)

  controlName = if method_name =~ /^select_(\w+)/
    $1.camelize(:lower) + "Dropdown" # maybe returned ControlType as welll 
  elsif method_name =~ /^click_(\w+)_link/
    $1.camelize(:lower) + "Link"  
  elsif method_name =~ /^click_(\w+)_button/
    $1.camelize(:lower) + "Button"  
  elsif method_name =~ /^click_(\w+)/
    $1.camelize(:lower) + "Button" 
  elsif method_name =~ /^enter_(\w+)/
    $1.camelize(:lower) + "Box" 
  end
  
  new_page_operation = PageOperation.new
  new_page_operation.page_name = page_name
  new_page_operation.operation_name = method_name
  new_page_operation.control_name = controlName
  
  $page_operations << new_page_operation

  controlName ||= method_name
  return controlName
end

spec_dir = "/Users/zhimin/work/consultancy/4impact/selenium-webdriver-rspec/spec"
page_dir = File.expand_path File.join(spec_dir, "..", "pages")

page_files = Dir.glob("#{page_dir}/*_page.rb")
page_files.each do |page_file|
  next if page_file.include?("abstract_page")
  ruby_file = TestWise::RubyFile.new(page_file)

  mapping_lines = []
  
  ruby_file.method_ranges.each do |hash|
    puts 
    page_name = File.basename(page_file).gsub(".rb", "")
    
    hash.each do |method_name, lines_range|
      next if method_name == "initialize"
      if lines_range.first + 1 == lines_range.last
        # only one line        
        
        controlName = getControlNameByPageOperation(page_name, method_name)        
        the_single_line = ruby_file.lines[lines_range.first]
        
        if the_single_line =~ /driver.find_element\(:(\w+),\s*"(\S+)"\)/
          locator = $1
          value = $2
          the_mapping_line = "#{controlName}.#{locator} = #{value}"
          mapping_lines <<  the_mapping_line
        end
        
      end
            
    end
  end

  puts mapping_lines.join("\n")
end


puts $page_operations.inspect

spec_files = Dir.glob("#{spec_dir}/*_spec.rb")
spec_files.each do |spec_file|
  puts spec_file
  test_file = TestWise::RubyFile.new(spec_file)
  test_file.lines.each do |line|
    line.strip!
    if line =~ /sleep\s+(\d+)/
      puts "waitSeconds = #{$1}"
    elsif line =~ /^(\w+_page)\.(\w+)\("(.*)"\)$/
      page_name = $1
      operation_name = $2
      value = $3
      
      the_page_operation = $page_operations.select{|x| x.page_name == page_name && x.operation_name == operation_name}.first
      if the_page_operation
        puts "" + the_page_operation.control_name  + ".value = " + value
      end
      
    end
    
  end
end
