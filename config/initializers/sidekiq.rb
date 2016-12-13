redis_url = YAML.load(ERB.new(File.read(File.join('config', 'redis.yml'))).result)[Rails.env.to_s]['url']

Sidekiq.configure_server do |config|
  config.redis = { :url => redis_url, :namespace => 'sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => redis_url, :namespace => 'sidekiq' }
end

# sidekiq cron
cron_file = "config/cron.yml"

if File.exists?(cron_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(cron_file)
end

require "./lib/tasks/sidekiq_cron_worker"
