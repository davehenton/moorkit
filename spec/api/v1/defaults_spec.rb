require 'api_helper'
require 'api/v1/defaults'
require 'bcrypt'

module APITest
  class DefaultsTester < Grape::API
    include API::V1::Defaults

    resource :test do
      post do
        present api_request: current_api_request
      end
    end
  end
end

RSpec.describe APITest::DefaultsTester  do
  let(:payload) { {email: "jimmy@jimmyjohns.com"}.to_json }
  let(:bearer_token) { "Bearer api_key:secret"}
  let(:headers) { {"Authorization": bearer_token, "Content-Type":"application/json" } }
  let(:is_auth) { false }
  let(:api_request) { double(:ApiRequest, id: "11ba0909-068b-489e-a8f6-9c4dd6e2b41d") }
  let(:api_key) { double(:ApiKey, id: "99ff0909-068b-489e-a8f6-9c4dd6e2f99f") }
  let(:save_api_request_context) { double(:save_api_request_context, call: api_request) }
  let(:authenticate_context) { double(:auth_context, call: is_auth) }
  let(:moorkit_api_request) { class_double("Moorkit::ApiRequest").as_stubbed_const }

  before(:all) do
    engine_routes = Proc.new { mount APITest::DefaultsTester => "/api_test" }
    Rails.application.routes.send :eval_block, engine_routes
  end

  before(:each) do
    allow(moorkit_api_request).to receive(:save_context).and_return(save_api_request_context)
  end

  context 'POST with invalid authorization' do
    it 'returns a 401 response' do
      post '/api_test/v1/test.json', payload
      expect(response.status).to eq(401)
    end
  end

  context 'POST with valid authorization' do
    let(:is_auth) { true }

    before(:each) do
      post '/api_test/v1/test.json', payload, headers
    end

    it 'returns a 201 response' do
      expect(response.status).to eq(201)
    end

    it 'returns an api_request object' do
      api_request = JSON.parse(response.body)["api_request"]
      expect(api_request["name"]).to eq("ApiRequest")
    end

    context 'and unknown server error occurs' do
      let(:save_api_request_context) { 21 }

      it 'returns a 500 response' do
        expect(response).to have_http_status(500)
      end
    end

  end

end
