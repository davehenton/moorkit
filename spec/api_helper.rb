require 'rails_helper'

RSpec.configure do |config|
  # Allow spec/api to use the request example grou
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec\/api/
end
