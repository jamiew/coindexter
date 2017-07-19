OmniAuth.config.full_host = Rails.env.production? ? 'https://coindexter.io' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
   client_options: {
      site: 'https://graph.facebook.com/v2.10', 
      authorize_url: "https://www.facebook.com/v2.10/dialog/oauth"
    }
end