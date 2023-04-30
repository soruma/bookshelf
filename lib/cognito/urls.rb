# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
module Cognito
  class Urls
    AUTHORIZE_PATH = '/oauth2/authorize'
    TOKEN_PATH = '/oauth2/token'
    LOGIN_PATH = '/login'
    LOGOUT_PATH = '/logout'
    SIGNUP_PATH = '/signup'

    class << self
      @base_oauth_uri = nil
      @base_idp_uri = nil

      def init(domain, region)
        @base_oauth_uri = "https://#{domain}.auth.#{region}.amazoncognito.com"
        @base_idp_uri = "https://cognito-idp.#{region}.amazonaws.com"
      end

      def jwks_uri(pool_id)
        path = "/#{pool_id}/.well-known/jwks.json"
        URI.join(@base_idp_uri, path).to_s
      end

      def refresh_token_uri
        @base_idp_uri
      end

      def authorize_uri
        URI.join(@base_oauth_uri, AUTHORIZE_PATH).to_s
      end

      def token_uri
        URI.join(@base_oauth_uri, TOKEN_PATH).to_s
      end

      def login_uri(app_client_id, redirect_uri)
        path = "#{LOGIN_PATH}?response_type=code&client_id=#{app_client_id}&redirect_uri=#{redirect_uri}"
        URI.join(@base_oauth_uri, path).to_s
      end

      def logout_uri(app_client_id, redirect_uri)
        path = "#{LOGOUT_PATH}?response_type=code&client_id=#{app_client_id}&logout_uri=#{redirect_uri}"
        URI.join(@base_oauth_uri, path).to_s
      end

      def signup_uri(app_client_id, redirect_uri)
        path = "#{SIGNUP_PATH}?response_type=code&client_id=#{app_client_id}&redirect_uri=#{redirect_uri}"
        URI.join(@base_oauth_uri, path).to_s
      end
    end
  end
end
