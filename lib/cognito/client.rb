# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
module Cognito
  class Client
    def initialize(params = {})
      @pool_id = params[:pool_id] || ENV.fetch('AWS_COGNITO_POOL_ID', nil)
      @client_id = params[:client_id] || ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil)
      @client_secret = params[:client_secret] || ENV.fetch('AWS_COGNITO_APP_CLIENT_SECRET', nil)
      @redirect_uri = params[:redirect_uri]
    end

    def get_pool_tokens(authorization_code)
      resp = post_token(authorization_code)

      unless resp.status == 200
        Rails.logger.warn("Invalid code: #{authorization_code}: #{resp.body}")
        return nil
      end

      Cognito::PoolTokens.new(Cognito::JwtKeysProvider.keys, JSON.parse(resp.body))
    end

    # From: https://medium.com/tensult/how-to-refresh-aws-cognito-user-pool-tokens-d0e025cedd52
    def refresh_id_token(refresh_token)
      resp = post_refresh_token(refresh_token)
      return nil if resp.status != 200

      json = JSON.parse(resp.body)

      # Key names are different here, so need to translate :-/
      tokens = {
        'id_token' => json['AuthenticationResult']['IdToken'],
        'access_token' => json['AuthenticationResult']['AccessToken']
      }

      Cognito::PoolTokens.new(Cognito::JwtKeysProvider.keys, tokens)
    end

    private

    def post_token(authorization_code)
      params = {
        grant_type: 'authorization_code',
        code: authorization_code,
        client_id: @client_id,
        redirect_uri: @redirect_uri
      }

      Excon.post(Cognito::Urls.token_uri,
                 user: @client_id,
                 password: @client_secret,
                 body: URI.encode_www_form(params),
                 headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    end

    def post_refresh_token(refresh_token)
      params = {
        ClientId: @client_id,
        AuthFlow: 'REFRESH_TOKEN_AUTH',
        AuthParameters: {
          REFRESH_TOKEN: refresh_token,
          SECRET_HASH: @client_secret
        }
      }

      hdrs = {
        'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth',
        'Content-Type': 'application/x-amz-json-1.1'
      }

      Excon.post(Cognito::Urls.refresh_token_uri,
                 headers: hdrs,
                 body: params.to_json)
    end
  end
end
