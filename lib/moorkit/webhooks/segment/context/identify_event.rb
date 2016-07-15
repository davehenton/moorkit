require 'support/tools'

module Moorkit
  module Webhooks
    module Segment
      module Context
        class IdentifyEvent

          class UnknownError < StandardError; end

          def initialize(user_upsert_context:, logger:)
            @user_upsert_context = user_upsert_context
            @logger = logger
          end

          def call(payload:)
            if Support::Tools.is_uuid?(payload[:userId])
              @user_upsert_context.call(uuid: payload[:userId], email: email(payload[:traits]), details: payload)
            else
              @logger.info "did not record payload where userId: #{payload[:userId]} and anonymousId: #{payload[:anonymousId]}"
            end

            return true

          rescue => e
            raise UnknownError.new("#{e.class}: #{e}")
          end

          private

          def email(traits)
            traits[:email] unless traits.nil?
          end
        end
      end
    end
  end
end
