Rails.application.configure do
  config.good_job.preserve_job_records = true
  config.good_job.on_thread_error = -> (exception) { Rails.error.report(exception) }
  config.good_job.queues = '*'
  config.good_job.poll_interval = 30
  config.good_job.shutdown_timeout = 25 # seconds

  config.good_job.cleanup_preserved_jobs_before_seconds_ago = 14.days
  config.good_job.cleanup_interval_jobs = 1_000 # Number of executed jobs between deletion sweeps.
  config.good_job.cleanup_interval_seconds = 10.minutes # Number of seconds between deletion sweeps.
  config.good_job.smaller_number_is_higher_priority = true

  config.good_job.queue_select_limit = 1000

  config.good_job.cron = {
  }
end
