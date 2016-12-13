class SidekiqCronWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'sidekiq_cron'

  def perform(*args)
    Rails.logger.error "Sidekiq Cron Worker executed at #{Time.now}"
  end
end
