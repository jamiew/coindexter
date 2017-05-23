Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:e836865d0592e401fc767331c9f7f740@greeneye.redistogo.com:10786/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:e836865d0592e401fc767331c9f7f740@greeneye.redistogo.com:10786/' }
end