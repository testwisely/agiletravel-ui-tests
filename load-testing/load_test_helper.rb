require "sqlite3"

require "json"
require "net/http"
require "multipart_body"
require "openssl"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#if $db.nil?
$db = SQLite3::Database.new(":memory:")
$db.execute(<<EOS)
  CREATE TABLE timings (
    id integer,
    operation varchar(255),
    start_time datetime,
    duration bigint,
    successful tinyint,
    error text,
    PRIMARY KEY(id)
  )
EOS
#end

$log_time_stmt = $db.prepare(<<EOS)
  INSERT INTO timings(operation, start_time, duration, successful, error) VALUES(:operation, :start_time, :duration, :successful, :error)
EOS

module LoadTestHelper

  # monitor current execution using
  #
  # Usage
  #  log_time { browser.click_button('Confirm') }
  def log_time(operation, &block)
    start_time = (Time.now.to_f * 1000).to_i
    error_occurred = nil
    begin
      yield
    rescue => e
      error_occurred = e.to_s
    ensure
      # puts [operation, start_time, (Time.now - start_time), 1].inspect

      if error_occurred
        $log_time_stmt.execute(:operation => operation, :start_time => start_time, :duration => (Time.now.to_f * 1000).to_i - start_time, :successful => 0, :error => error_occurred)
      else
        $log_time_stmt.execute(:operation => operation, :start_time => start_time, :duration => (Time.now.to_f * 1000).to_i - start_time, :successful => 1)
      end
    end
  end

  def dump_timings
    count = $db.get_first_value("SELECT count(*) FROM timings")
    puts "count(*): #{count}"
    data = []
    $db.execute("select * from timings") do |row|
      hash = {}
      hash[:operation] = row[1]
      hash[:start_ts] = row[2]
      hash[:duration] = row[3]
      hash[:success] = row[4]
      hash[:error] = row[5] 
      data << hash   
      puts row.inspect + "\n"
    end

    #TODO post to BuildWise Server
    post_results_to_buildwise_server(0, data)
  end
  
  
  def post_results_to_buildwise_server(build_id, timings)
    # the below envrionment variable shall be set by BuildWise Agent
    server_uri = ENV["BUILDWISE_SERVER"]
    agent_name = ENV["AGENT_NAME"]
    
    if server_uri.nil? || server_uri.strip.empty?
      return
    end
      
    reply = post_load_test_timings(server_uri, "/parallel/builds/#{build_id}/report_load_test_result",
       { :build_id => build_id, 
         :agent_name => agent_name, 
         :timings_json => timings.to_json
       }
    )
  end
  
  def post_load_test_timings(server_uri, path, hash)
    build_id = hash[:build_id]
    param_part_1 = Part.new("timings_json", hash[:timings_json])
    param_part_2 = Part.new("agent_name", hash[:agent_name])
    screenshot_zip = hash[:screenshot_zip] rescue nil

    boundary = "---------------------------#{rand(10000000000000000000)}"
    if screenshot_zip && File.exists?(screenshot_zip)
      s = File.open(screenshot_zip, "rb") { |io| io.read }
      file_part = Part.new(:name => "screenshot_zip", :body => s, :filename => "screenshot.zip", :content_type => "text/plain")

      body = MultipartBody.new [param_part_1, param_part_2, file_part], boundary
    else
      body = MultipartBody.new [param_part_1, param_part_2], boundary
    end

    uri = URI.parse(server_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new path
    request.body = body.to_s
    request["Cookie"] = "Agent=#{hash[:agent_name]};"
    request["Connection"] = "keep-alive"
    request["Content-Type"] = "multipart/form-data; boundary=#{boundary}"
    reply = http.request(request)
  end
  
  def load_test_repeat
    the_repeat_count = ENV["LOAD_TEST_REPEAT"].to_i rescue 1
    the_repeat_count = 1 if the_repeat_count < 1
    return the_repeat_count
  end
  
end
