require 'sqlite3'

#if $db.nil? 
$db = SQLite3::Database.new(':memory:')
$db.execute(<<EOS)
  CREATE TABLE timings (
    id integer,
    operation varchar(255),
    start_time datetime,
    duration decimal(10, 5),
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
    start_time = Time.now
		error_occurred = nil
    begin
      yield
    rescue => e
		  error_occurred = e.to_s
    ensure
		  # puts [operation, start_time, (Time.now - start_time), 1].inspect
			if error_occurred
				$log_time_stmt.execute(:operation => operation, :start_time => start_time, :duration => Time.now - start_time, :successful => 0, :error => error_occurred)
			else				
				$log_time_stmt.execute(:operation => operation, :start_time => start_time.to_i, :duration => Time.now - start_time, :successful => 1 )
			end
				
    end
  end
  
  
  def dump_timings
    count = $db.get_first_value("SELECT count(*) FROM timings")
    puts "count(*): #{count}"
    $db.execute("select * from timings") do |row|
      puts row.inspect + "\n"
    end
  end
  
end
