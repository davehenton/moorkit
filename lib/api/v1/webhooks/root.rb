module API
  module V1
    module Webhooks
      class Root < Grape::API
        resource :webhooks do
          mount API::V1::Webhooks::Segment
        end
      end
    end
  end
end
