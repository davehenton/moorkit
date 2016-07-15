require 'spec_helper'
require 'jobs/moorkit/webhooks/segment'

RSpec.describe Jobs::Moorkit::Webhooks::Segment do
  let(:api_request_id) { '12345678-1234-1234-1234-123456789012' }
  let(:opts) { {"api_request_id" => api_request_id} }
  let(:api_request) { double(:api_request, payload: payload.merge({"type": event_type})) }
  let(:process_request_context) { double(:process_request_context, call: true) }
  subject { described_class }

  describe "self.perform" do
    subject { described_class.perform(opts) }

    before(:each) do
      allow(Moorkit::Webhooks::Segment).to receive(:process_request_context).and_return(process_request_context)
    end

    it { is_expected.to eq(true) }

    it 'sends the api_request_id to the process_request_context' do
      expect(process_request_context).to receive(:call).with(api_request_id: api_request_id)
      subject
    end

    context 'when api_request_id is not a valid uuid' do
      let(:api_request_id) { 1 }

      it 'raises an InvalidUse error' do
        expect { subject }.to raise_error Jobs::Error::InvalidUse
      end
    end
  end

end
