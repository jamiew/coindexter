if Rails.env.production?

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISTOGO_URL']}
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL']}

    database_url = ENV['DATABASE_URL']

    Rails.logger.info("database_url is #{database_url}")

    if database_url
      concurrency = Sidekiq.options[:concurrency].to_i
      # This will be the case on Heroku deployed environments
      uri = URI.parse(database_url)
      puts "Original DATABASE_URL => #{uri}"
      pool_size = (concurrency * 1.6).round(0)
      params = {}
      params['pool'] = pool_size
      uri.query = "#{params.to_query}"
      ENV['DATABASE_URL'] = uri.to_s
      puts "Sidekiq Server is reconnecting with new pool size: #{params['pool']} - DATABASE_URL => #{uri}"
      ActiveRecord::Base.establish_connection
    end

    Rails.application.config.after_initialize do
      Rails.logger.info("DB Connection Pool size for Sidekiq Server before disconnect is: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
      ActiveRecord::Base.connection_pool.disconnect!

      ActiveSupport.on_load(:active_record) do
        config = Rails.application.config.database_configuration[Rails.env]
        config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
        # config['pool'] = ENV['WORKER_DB_POOL_SIZE'] || Sidekiq.options[:concurrency]
        config['pool'] = 16
        ActiveRecord::Base.establish_connection(config)

        Rails.logger.info("DB Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
      end
    end
  end

end  