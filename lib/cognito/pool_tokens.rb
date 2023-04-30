# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
module Cognito
  class PoolTokens
    def initialize(cognito_jwt_keys, token_hash)
      @cognito_jwt_keys = cognito_jwt_keys
      @token_hash = token_hash
      @token_cache = {}
    end

    def id_token = get_token('id_token')
    def access_token = get_token('access_token')

    # refresh token shouldn't be parsed
    def refresh_token = @token_hash.[]('refresh_token')

    private

    def get_token(key)
      return @token_cache[key] if @token_cache[key]

      @token_cache[key] = parse_token(@token_hash[key])
    end

    def parse_token(tok_str)
      hdr = jwt_header(tok_str)
      key = @cognito_jwt_keys.get(hdr['kid'], hdr['alg'])
      JSON::JWT.decode(tok_str, key)
    end

    def jwt_header(jwt_string)
      parts = jwt_string.split('.')
      raise "Not enough parts from JWT: #{jwt_string}" unless parts.length == 3

      JSON.parse(Base64.decode64(parts[0]))
    end
  end
end
