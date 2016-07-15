module Moorkit
  module Webhooks
    module Segment
      module Context
        class ProcessIdentifyRequests

          class ProcessIdentifyRequestsError < StandardError; end

          PATH = "/api/v1/webhooks/segment"
          IDENTIFY_TYPE = {type: "identify"}.to_json

          def initialize(identify_event_context:, api_request_model:, logger:)
            @identify_event_context = identify_event_context
            @api_request_model = api_request_model
            @logger = logger
          end

          def call(start_date:, end_date:)
            start_time = Time.now

            requests = @api_request_model.
              where(path: PATH).
              where("payload @> ?", IDENTIFY_TYPE).
              where("created_at BETWEEN ? AND ?", start_date, end_date).
              order(created_at: :asc)
            log("Identified #{requests.count} requests between #{start_date} and #{end_date}")

            requests.each do |req|
              payload = req.payload
              payload.delete(:type)
              @identify_event_context.call(payload: payload)
              log("Processed #{req.id} from #{req.created_at}")
            end

            log("Completed #{requests.count} in #{(Time.now - start_time).round(0)} seconds")
            true
          rescue => e
            log("#{e.class}:#{e}", :error)
            raise ProcessIdentifyRequestsError.new("#{e.class}:#{e}")
          end

          private

          def log(msg, level = :info)
            @logger.tagged("IdentifyRequests", level.to_s) {
              case level
              when :error; @logger.error msg
              else @logger.info msg
              end
            }
          end
        end
      end
    end
  end
end
