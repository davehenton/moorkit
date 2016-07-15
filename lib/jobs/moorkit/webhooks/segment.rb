require 'moorkit/webhooks/segment'
require 'jobs/error'
require 'support/tools'

module Jobs
  module Moorkit
    module Webhooks
      class Segment
        @queue = :segment

        def self.perform(opts = {})
          raise create_usage_error unless Support::Tools.is_uuid?(opts["api_request_id"])

          context = ::Moorkit::Webhooks::Segment.process_request_context
          context.call(api_request_id: opts["api_request_id"])
          true
        end

        def self.create_usage_error
          Jobs::Error::InvalidUse.new(":api_request_id is false")
        end
      end
    end
  end
end
