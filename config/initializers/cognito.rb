# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
require 'cognito_jwt_keys'
require 'cognito_urls'

if ENV['AWS_COGNITO_DOMAIN'].present?
  CognitoUrls.init(ENV.fetch('AWS_COGNITO_DOMAIN', nil),
                   ENV.fetch('AWS_COGNITO_REGION', nil))

  CognitoJwtKeysProvider.init(ENV.fetch('AWS_COGNITO_POOL_ID', nil))
else
  Rails.logger.debug 'Skipping Cognito initialization'
end
