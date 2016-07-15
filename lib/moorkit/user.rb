require 'moorkit/user/context/upsert'

module Moorkit
  module User

    class << self

      def upsert_context
        Context::Upsert.new(
          user_model: ::User,
          logger: Rails.logger
        )
      end

    end
  end
end
