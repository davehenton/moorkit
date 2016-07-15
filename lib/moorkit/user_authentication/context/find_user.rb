module Moorkit
  module UserAuthentication
    module Context
      class FindUser

        class InvalidAuthPayload < StandardError; end

        def initialize(user_auth_model:, logger:)
          @user_auth_model = user_auth_model
          @logger = logger
        end

        def call(auth_payload:)
          raise InvalidAuthPayload.new unless is_an_auth_payload?(auth_payload)
          user_auth = @user_auth_model.where(provider: auth_payload.provider, uid: auth_payload.uid).first
          user_auth.user unless user_auth.nil?
        end

        private

        def is_an_auth_payload?(auth_payload)
          auth_payload.is_a?(Moorkit::UserAuthentication::Entity::AuthPayload)
        end
      end
    end
  end
end
