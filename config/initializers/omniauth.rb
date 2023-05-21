# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :aws,
           client_id: ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
           client_secret: ENV.fetch('AWS_COGNITO_APP_CLIENT_SECRET', nil),
           client_options: { site: "https://#{ENV.fetch('AWS_COGNITO_DOMAIN', nil)}.auth.#{ENV.fetch('AWS_COGNITO_REGION', nil)}.amazoncognito.com" }
end

OmniAuth.config.logger = Rails.logger
