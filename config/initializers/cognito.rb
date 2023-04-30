# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
require 'cognito/jwt_keys'
require 'cognito/urls'

if ENV['AWS_COGNITO_DOMAIN'].present?
  Cognito::Urls.init(ENV.fetch('AWS_COGNITO_DOMAIN', nil),
                     ENV.fetch('AWS_COGNITO_REGION', nil))

  Cognito::JwtKeysProvider.init(ENV.fetch('AWS_COGNITO_POOL_ID', nil))
else
  Rails.logger.debug 'Skipping Cognito initialization'
end
