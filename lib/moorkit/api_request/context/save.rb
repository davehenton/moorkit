require 'json'

module Moorkit
  module ApiRequest
    module Context
      class Save

        def initialize(api_request_model:, logger:)
          @api_request_model = api_request_model
          @logger = logger
        end

        def call(method:, path:, headers:, payload: nil)
          entity = @api_request_model.create(
            method: method,
            path: path,
            payload: payload,
            headers: redact_authorization(headers)
          )
          return entity
        end

        private

        def redact_authorization(headers)
          headers.each do |k,v|
            v.replace("[REDACTED]") if (k.to_s =~ /Authorization/i)
          end
        end

      end
    end
  end
end
