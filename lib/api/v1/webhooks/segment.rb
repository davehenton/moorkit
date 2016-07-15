module API
  module V1
    module Webhooks
      class Segment < Grape::API
        include API::V1::Defaults

        resource :segment do

          post do
            Resque.enqueue(Jobs::Moorkit::Webhooks::Segment, {api_request_id: current_api_request.id})
            present :success, true
          end
        end
      end
    end
  end
end
