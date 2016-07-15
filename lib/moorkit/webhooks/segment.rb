require 'moorkit/webhooks/segment/context/identify_event'
require 'moorkit/webhooks/segment/context/process_identify_requests'
require 'moorkit/webhooks/segment/context/process_request'


module Moorkit
  module Webhooks
    module Segment
      class << self

        def process_request_context
          Context::ProcessRequest.new(
            api_request_model: ::ApiRequest,
            segment_factory: self,
            logger: Rails.logger
          )
        end

        def process_identify_requests_context
          Context::ProcessIdentifyRequests.new(
            identify_event_context: identify_event_context,
            api_request_model: ::ApiRequest,
            logger: Rails.logger
          )
        end

        def identify_event_context
          Context::IdentifyEvent.new(
            member_upsert_context: Moorkit::User.upsert_context,
            logger: Rails.logger
          )
        end
      end
    end
  end
end
