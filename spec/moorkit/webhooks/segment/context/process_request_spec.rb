require 'spec_helper'
require 'moorkit/webhooks/segment/context/process_request'
require 'active_record'

RSpec.describe Moorkit::Webhooks::Segment::Context::ProcessRequest do
  let(:logger) { double(:logger, debug: true) }
  let(:api_request_id) { '12345678-1234-1234-1234-123456789012' }
  let(:payload) { {"geo_state":"IL"} }
  let(:event_type) { "identify" }
  let(:api_request) { double(:api_request, payload: payload.merge({"type" => event_type})) }
  let(:api_request_model) { double(:api_request_model, find: api_request) }
  let(:segment_factory) { double(:segment_factory, identify_event_context: identify_event_context) }
  let(:identify_event_context) { double(:identify_event_context, call: true) }
  let(:context) { described_class.new(segment_factory: segment_factory, api_request_model: api_request_model, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(api_request_id: api_request_id) }

    it { is_expected.to eq(true) }

    it 'finds the api_request by api_request_id' do
      expect(api_request_model).to receive(:find).with(api_request_id)
      subject
    end

    it 'retrieves the corresponding context Segment::Context::<event_type>Event' do
      expect(segment_factory).to receive(:identify_event_context)
      subject
    end

    it 'sends the ApiRequest payload to the <event_type>Event, excluding the :type key' do
      expect(identify_event_context).to receive(:call).with(payload: payload)
      subject
    end

    context 'when event is not supported' do
      let(:event_type) { 'unknown' }

      before(:each) do
        allow(segment_factory).to receive(:unknown_event_context).
          and_raise(NoMethodError.new('undefined method :unknown_event_context'))
      end

      it { is_expected.to be(true) }

      it 'does not attempt to retrieve the corresponding context Segment::Context::<event_type>Event' do
        expect(segment_factory).not_to receive(:unknown_event_context)
        subject
      end
    end

    context 'when no ApiRequest is found' do
      before(:each) do
        allow(api_request_model).to receive(:find).
          and_raise(ActiveRecord::RecordNotFound.new("couldn't find ApiRequest with 'id'=#{api_request_id}"))
      end

      it 'is expected to raise a ProcessRequestError' do
        expect { subject }.to raise_error described_class::ProcessRequestError
      end
    end
  end
end
