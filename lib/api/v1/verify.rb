module API
  module V1
    class Verify < Grape::API
      include API::V1::Defaults

      resource :verify do
        get do
          present :success, true
        end
      end
    end
  end
end
