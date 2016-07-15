module Moorkit
  module Webhooks
    module Segment
      module Context
        class ProcessRequest

          class ProcessRequestError < StandardError; end
          SUPPORTED_TYPES = ["identify"]

          def initialize(segment_factory:, api_request_model:, logger:)
            @segment_factory = segment_factory
            @api_request_model = api_request_model
            @logger = logger
          end

          def call(api_request_id:)
            api_request = @api_request_model.find(api_request_id)

            payload = api_request.payload
            event_type = payload.delete("type")

            if SUPPORTED_TYPES.include? event_type
              @segment_factory.send("#{event_type}_event_context").call(payload: payload)
            end

            true
          rescue ActiveRecord::RecordNotFound => e
            raise ProcessRequestError.new(e)
          end
        end
      end
    end
  end
end
