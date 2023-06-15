# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
module Cognito
  class JwtKeysProvider
    class << self
      @jwt_keys = nil

      def init(pool_id)
        resp = Excon.get(key_url(pool_id))
        keys = JSON.parse(resp.body)
        keymap = keys['keys'].to_h do |key|
          [key['kid'], JSON::JWK.new(key)]
        end
        @jwt_keys = Cognito::JwtKeys.new(keymap)
      end

      def keys
        @jwt_keys
      end

      def key_url(pool_id)
        Cognito::Urls.jwks_uri(pool_id)
      end
    end
  end

  class JwtKeys
    def initialize(keymap)
      @keys = keymap
    end

    def get(key_id, alg = 'RS256')
      key = @keys[key_id]

      raise "No such JWK `#{key_id}`: #{@keys.keys}" unless key

      raise "Algorithm not compatible #{key[:alg]} != #{alg}" unless key[:alg] == alg

      key
    end
  end
end
