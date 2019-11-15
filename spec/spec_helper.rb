# spec_helper.rb

# if use below, ci/rspec_reporter does not get output

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
