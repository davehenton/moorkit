require 'moorkit/api_request/context/save'

module Moorkit
  module ApiRequest

    class << self

      def save_context
        Context::Save.new(
          api_request_model: ::ApiRequest,
          logger: Rails.logger
        )
      end

    end
  end
end
