module API
  module V1
    class Root < Grape::API
      version 'v1', using: :path
      mount API::V1::Webhooks::Root
      mount API::V1::Verify
    end
  end
end
