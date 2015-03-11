Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 1
$stdout.sync=true
Delayed::Worker.logger = Logger.new($stdout)
Delayed::Worker.logger.level = Logger::DEBUG

