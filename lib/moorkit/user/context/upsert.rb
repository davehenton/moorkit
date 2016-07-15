require 'json'
require 'support/tools'

module Moorkit
  module User
    module Context
      class Upsert

        def initialize(user_model:, logger:)
          @user_model = user_model
          @logger = logger
        end

        def call(uuid:, email:, details: {})
          user = find_or_create_user(uuid: uuid)

          user.update!(
            email: email,
            details: Support::Tools.deep_hash_merge(existing_hash: user.details, new_hash: details)
          )

          return user
        end

        private

        def find_or_create_user(uuid:)
          user = @user_model.where(uuid: uuid).first
          user = @user_model.new(uuid: uuid, details: {}) if user.nil?
          return user
        end
      end
    end
  end
end
