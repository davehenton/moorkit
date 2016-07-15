require 'moorkit/user_authentication/context/find_user'
require 'moorkit/user_authentication/context/create_user'
require 'moorkit/user_authentication/context/entitize_auth_hash'

module Moorkit
  module UserAuthentication

    class << self

      def find_user_context
        Context::FindUser.new(
          user_auth_model: ::UserAuthentication,
          logger: Rails.logger
        )
      end

      def create_user_context
        Context::CreateUser.new(
          user_model: ::User,
          user_auth_model: ::UserAuthentication,
          logger: Rails.logger
        )
      end

      def entitize_auth_hash_context
        Context::EntitizeAuthHash.new(logger: Rails.logger)
      end

    end
  end
end
