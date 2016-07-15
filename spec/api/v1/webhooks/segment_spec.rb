require 'api_helper'
require 'api/v1/defaults'
require 'api/v1/webhooks/segment'

RSpec.describe API::V1::Webhooks::Segment  do
  let(:payload) { {email: "jimmy@jimmyjohns.com"}.to_json }
  let(:bearer_token) { "Bearer api_key:secret"}
  let(:headers) { {"Authorization": bearer_token, "Content-Type":"application/json" } }
  let(:is_auth) { true }
  let(:api_request) { double(:ApiRequest, id: "11ba0909-068b-489e-a8f6-9c4dd6e2b41d") }
  let(:api_key) { double(:ApiKey, id: "99ff0909-068b-489e-a8f6-9c4dd6e2f99f") }
  let(:save_api_request_context) { double(:save_api_request_context, call: api_request) }
  let(:authenticate_context) { double(:auth_context, call: is_auth) }
  let(:sherlock_api_request) { class_double("Moorkit::ApiRequest").as_stubbed_const }
  let(:resque) { class_double("Resque").as_stubbed_const }
  let(:jobs_segment) { class_double("Jobs::Moorkit::Webhooks::Segment").as_stubbed_const }
  let(:job_payload) { {api_request_id: api_request.id} }

  before(:all) do
    #engine_routes = Proc.new { mount APITest::DefaultsTester => "/api_test" }
    #Rails.application.routes.send :eval_block, engine_routes
  end

  before(:each) do
    allow(sherlock_api_request).to receive(:save_context).and_return(save_api_request_context)
    allow(resque).to receive(:enqueue).and_return(true)

  end

  it 'returns a 201 response' do
    post '/api/v1/webhooks/segment.json', payload, headers
    expect(response.status).to eq(201)
  end

  it 'enqueues a Resque Job' do
    expect(resque).to receive(:enqueue).with(jobs_segment, job_payload)
    post '/api/v1/webhooks/segment.json', payload, headers
  end
end
