# spec_helper.rb

# if use below, ci/rspec_reporter does not get output

RSpec.configure do |config|

  # only when run in BuildWise Agent, catpure output in result junit xml files
    
    # register around filter that captures stdout and stderr
    config.around(:each) do |example|
    
      if ENV["RUN_IN_BUILDWISE_AGENT"] == "true" 
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
