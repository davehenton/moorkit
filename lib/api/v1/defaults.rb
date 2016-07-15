module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        content_type :json, 'application/json'
        format :json
        default_format :json

        rescue_from :all do
          error!("Internal Server Error", 500)
        end

        before do
          error!('401 Unauthorized', 401) unless is_authenticated?
          @api_request = save_api_request_context.call(
            method: request.request_method,
            path: request.path,
            payload: params,
            headers: headers
          )
        end

        helpers do

          def authorization_header
            headers["Authorization"]
          end

          def is_authenticated?
            @authenticated ||= !authorization_header.nil? && authenticate
          end

          def authenticate
            true
            #context = Sherlock::ApiKey.authenticate_api_key_context
            #context.call(id: bearer_token[:id], secret: bearer_token[:secret])
          end

          def bearer_token
            token = authorization_header.split(/[\s:]/) if authorization_header.present?
            if token.is_a?(Array) && token.count == 3 && token.first =~ /BEARER/i then
              { id: token.second, secret: token.third }
            else
              nil
            end
          end

          def current_api_request
            @api_request
          end

          def save_api_request_context
            Moorkit::ApiRequest.save_context
          end
        end
      end
    end
  end
end
