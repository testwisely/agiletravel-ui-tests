# Cucumber hooks
#  See https://www.relishapp.com/cucumber/cucumber/docs/writing-support-code

# Example hoook after each scenario
After do |scenario|
  if scenario.failed?
    # puts "* Scenario failed: "
  end
end

=begin
Before('@feature') do
  # do something useful
  puts "before feature"
end

After('@feature') do
  # do something useful  
  puts "after feature: #{driver}"
  driver.close if driver
end
=end