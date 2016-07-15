require 'api_helper'
require 'api/v1/defaults'
require 'api/v1/verify'

RSpec.describe API::V1::Verify  do
  let(:payload) { {email: "jimmy@jimmyjohns.com"}.to_json }
  let(:bearer_token) { "Bearer api_key:secret"}
  let(:headers) { {"Authorization": bearer_token, "Content-Type":"application/json" } }
  let(:is_auth) { true }
  let(:api_request) { double(:ApiRequest, id: "11ba0909-068b-489e-a8f6-9c4dd6e2b41d") }
  let(:api_key) { double(:ApiKey, id: "99ff0909-068b-489e-a8f6-9c4dd6e2f99f") }
  let(:save_api_request_context) { double(:save_api_request_context, call: api_request) }
  let(:authenticate_context) { double(:auth_context, call: is_auth) }
  let(:sherlock_api_request) { class_double("Sherlock::ApiRequest").as_stubbed_const }
  let(:sherlock_api_key) { class_double("Sherlock::ApiKey").as_stubbed_const }
  let(:api_key_model) { class_double("ApiKey").as_stubbed_const }

  before(:each) do
    allow(sherlock_api_key).to receive(:authenticate_api_key_context).and_return(authenticate_context)
    allow(sherlock_api_request).to receive(:save_api_request_context).and_return(save_api_request_context)
    allow(api_key_model).to receive(:find).and_return(api_key)
  end

  it 'returns a 200 response' do
    get '/api/v1/verify.json', payload, headers
    expect(response).to have_http_status(200)
  end

end
