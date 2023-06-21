# Cucumber changed, if use --require, then steps/env not loaded
#   --help for details
if ENV["TESTWISE_CUCUMBER_FORMATTER"]
  require "#{ENV['TESTWISE_CUCUMBER_FORMATTER']}" 
else ENV["TESTWISE_RUNTIME_DIR"] && Dir.exists?(ENV["TESTWISE_RUNTIME_DIR"]) 
  if File.exist?("#{ENV['TESTWISE_RUNTIME_DIR']}/testwise_cucumber_formatter.rb")
    require "#{ENV['TESTWISE_RUNTIME_DIR']}/testwise_cucumber_formatter.rb"
  end
end