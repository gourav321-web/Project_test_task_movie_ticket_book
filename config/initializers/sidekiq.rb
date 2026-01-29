Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/1' } # Use an appropriate URL
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end

# config/initializers/sidekiq.rb
require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq.configure_server do |config|
  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  # Optional client configuration if needed
end

