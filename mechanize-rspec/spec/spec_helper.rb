# spec_helper.rb
#
# Different from test_helper.rb in up directory, this is a speical file to configure RSpec execution.
# This one tell RSpec include stdout and stderr in test report.
#

# if use below, ci/rspec_reporter does not get output
# only when run in BuildWise Agent, catpure output in result junit xml files
if ENV["RUN_IN_BUILDWISE_AGENT"] == "true" 
  RSpec.configure do |config|
    
    # register around filter that captures stdout and stderr
    config.around(:each) do |example|
    
        stdout, stderr = StringIO.new, StringIO.new
        $stdout, $stderr = stdout, stderr

        example.run

        example.metadata[:stdout] = $stdout.string
        example.metadata[:stderr] = $stderr.string

        $stdout = STDOUT
        $stderr = STDERR
    end
  end
end  
