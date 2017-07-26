require 'mailgun'

Mailgun.configure do |config|
  config.api_key = ENV["MAILGUN_API_KEY"]
  config.domain = 'updates@coindexter.io'
end
