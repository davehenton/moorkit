module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        content_type :json, 'application/json'
        format :json
        default_format :json

        use ::WineBouncer::OAuth2

        rescue_from WineBouncer::Errors::OAuthUnauthorizedError do
          error!("Unauthorized", 401)
        end

        rescue_from :all do
          error!("Internal Server Error", 500)
        end

        before do
          current_user && current_api_request
        end

        helpers do

          def current_user
            resource_owner
          end

          def current_token
            doorkeeper_access_token
          end

          def current_api_request
            @api_request ||= save_api_request_context.call(
              method: request.request_method,
              path: request.path,
              payload: params,
              headers: headers
            )
          end

          def save_api_request_context
            Moorkit::ApiRequest.save_context
          end
        end
      end
    end
  end
end
