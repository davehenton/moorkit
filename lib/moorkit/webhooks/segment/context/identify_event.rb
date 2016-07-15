require 'support/tools'

module Moorkit
  module Webhooks
    module Segment
      module Context
        class IdentifyEvent

          class UnknownError < StandardError; end

          def initialize(member_upsert_context:, logger:)
            @member_upsert_context = member_upsert_context
            @logger = logger
          end

          def call(payload:)
            sso_uuid = payload[:userId]
            if Support::Tools.is_uuid?(sso_uuid)
              @member_upsert_context.call(sso_uuid: sso_uuid, details: payload)
            else
              @logger.info "did not record payload where userId: #{payload[:userId]} and anonymousId: #{payload[:anonymousId]}"
            end

            return true

          rescue => e
            raise UnknownError.new("#{e.class}: #{e}")
          end

        end
      end
    end
  end
end
