OmniAuth.config.full_host = Rails.env.production? ? 'https://coindexter.io' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
end