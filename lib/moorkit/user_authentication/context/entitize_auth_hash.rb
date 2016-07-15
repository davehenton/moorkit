require 'moorkit/user_authentication/entity/auth_payload'

module Moorkit
  module UserAuthentication
    module Context
      class EntitizeAuthHash

        def initialize(logger:)
          @logger = logger
        end

        def call(auth_hash:)
          info = auth_hash[:info]
          creds = auth_hash[:credentials]
          name = info[:name].split(' ')

          Moorkit::UserAuthentication::Entity::AuthPayload.new({
            email: info[:email],
            first_name: info[:first_name] || name.slice(0, name.length - 1).join(' '),
            last_name: info[:last_name] || name.last,
            uid: auth_hash[:uid],
            provider: auth_hash[:provider],
            token: creds[:token],
            expires_at: creds[:expires_at],
            data: auth_hash
          })
        end
      end
    end
  end
end
