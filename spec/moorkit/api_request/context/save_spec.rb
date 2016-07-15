require 'spec_helper'
require 'moorkit/api_request/context/save'
require 'json'

RSpec.describe Moorkit::ApiRequest::Context::Save do
  let(:logger) { double(:logger, debug: true) }
  let(:api_request_entity) { double(:api_request_entity, id: 1) }
  let(:api_request_model) { double(:api_request_model, create: api_request_entity) }
  let(:context) { described_class.new(api_request_model: api_request_model, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    let(:method) { "GET" }
    let(:path) { "/api/v1/verify" }
    let(:payload) { {'type':'identify'} }
    let(:headers) { {'authorization':'api_key:shared_secret', 'Content-Type':'application/json'} }
    subject { context.call(method: method, path: path, headers: headers, payload: payload) }

    it { is_expected.to eq(api_request_entity) }

    context 'when Authorization header provided' do
      let(:json_updated ) { headers.merge({'authorization':'[REDACTED]'}) }
      it 'the value is replaced with [REDACTED]' do
        expect(api_request_model).to receive(:create).with(
          method: method,
          path: path,
          payload: payload,
          headers: json_updated
        )
        subject
      end
    end
  end
end
