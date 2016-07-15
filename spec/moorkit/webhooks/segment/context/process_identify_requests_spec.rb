require 'spec_helper'
require 'moorkit/webhooks/segment/context/process_identify_requests'
require 'active_record'

RSpec.describe Moorkit::Webhooks::Segment::Context::ProcessIdentifyRequests do
  let(:logger) { double(:logger, tagged: true, info: true, error: true, debug: true) }
  let(:start_date) { Time.parse('2015-01-01') }
  let(:end_date) { Time.parse('2016-07-01') }
  let(:payload) { {"geo_state":"IL"} }
  let(:event_type) { "identify" }
  let(:payload_with_type) { payload.merge({type: event_type}) }
  let(:api_request) { double(:api_request, payload: payload_with_type, id: 1, created_at: Time.parse('2016-01-01')) }
  let(:api_requests) { [api_request, api_request, api_request] }
  let(:api_request_model) { double(:api_request_model) }
  #let(:segment_factory) { double(:segment_factory, identify_event_context: identify_event_context) }
  let(:identify_event_context) { double(:identify_event_context, call: true) }
  let(:context) { described_class.new(
                    identify_event_context: identify_event_context,
                    api_request_model: api_request_model,
                    logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(start_date: start_date, end_date: end_date) }

    before(:each) do
      allow(api_request_model).to receive_message_chain(:where, :where, :where, :order => api_requests)
    end

    it { is_expected.to eq(true) }

    it 'calls identify_event for each api_request found' do
      expect(identify_event_context).to receive(:call).exactly(api_requests.count).times
      subject
    end

    it 'sends the ApiRequest payload to the identify_event, excluding the :type key' do
      expect(identify_event_context).to receive(:call).with(payload: payload)
      subject
    end

    context 'when an error occurs' do
      before(:each) do
        allow(api_request_model).to receive(:where).
          and_raise(StandardError.new)
      end

      it 'is expected to raise a ProcessIdentifyRequestsError' do
        expect { subject }.to raise_error described_class::ProcessIdentifyRequestsError
      end
    end
  end
end
