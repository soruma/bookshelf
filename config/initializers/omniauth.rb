# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :cognito_idp,
    ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
    ENV.fetch('AWS_COGNITO_APP_CLIENT_SECRET', nil),
    client_options: {
      site: ENV.fetch('AWS_COGNITO_POOL_SITE', nil)
    },
    scope: 'email openid',
    user_pool_id: ENV.fetch('AWS_COGNITO_POOL_ID', nil),
    aws_region: ENV.fetch('AWS_COGNITO_REGION', nil)
  )
end
