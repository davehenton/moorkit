require 'moorkit/webhooks/segment'
require 'jobs/error'

module Jobs
  module Moorkit
    module Webhooks
      class Segment
        @queue = :segment

        def self.perform(opts = {})
          raise create_usage_error if opts["api_request_id"].nil?
          context = ::Moorkit::Webhooks::Segment.process_request_context
          context.call(api_request_id: opts["api_request_id"])
          true
        end

        def self.create_usage_error
          Jobs::Error::InvalidUse.new(":api_request_id is invalid")
        end
      end
    end
  end
end
