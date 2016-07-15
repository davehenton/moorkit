module Moorkit
  module UserAuthentication
    module Context
      class CreateUser

        class InvalidAuthPayload < StandardError; end
        class InvalidUser < StandardError; end
        class InvalidUserAuthentication < StandardError; end

        def initialize(user_model:, user_auth_model:, logger:)
          @user_model = user_model
          @user_auth_model = user_auth_model
          @logger = logger
        end

        #expects an Entity::AuthPayload
        def call(auth_payload:)
          raise InvalidAuthPayload.new unless is_an_auth_payload?(auth_payload)
          user = create_user(auth_payload)
          create_user_authentication(user, auth_payload)
          user
        end

        private

        def is_an_auth_payload?(auth_payload)
          auth_payload.is_a?(Moorkit::UserAuthentication::Entity::AuthPayload)
        end

        def create_user(auth_payload)
          user = @user_model.create(
            email: auth_payload.email,
            first_name: auth_payload.first_name,
            last_name: auth_payload.last_name
          )
        rescue => e
          raise InvalidUser.new(e)
        end

        def create_user_authentication(user, auth_payload)
          user.user_authentications.create(
            provider: auth_payload.provider,
            uid: auth_payload.uid,
            token: auth_payload.token,
            expires_at: auth_payload.expires_at
          )
        rescue => e
          raise InvalidUserAuthentication.new(e)
        end
      end
    end
  end
end
