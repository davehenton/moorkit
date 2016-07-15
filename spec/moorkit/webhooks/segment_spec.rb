require 'spec_helper'
require 'moorkit/webhooks/segment'
require 'moorkit/user'

RSpec.describe Moorkit::Webhooks::Segment do
  subject { described_class }
  let(:logger) { double(:logger) }
  let(:member) { class_double(Moorkit::User).as_stubbed_const }
  let(:upsert_context) { double(:upsert_context) }

  before(:each) do
    class_double("ApiRequest").as_stubbed_const
    class_double("Rails").as_stubbed_const
    allow(member).to receive(:upsert_context).and_return(upsert_context)
    allow(Rails).to receive(:logger).and_return(logger)
  end

  context '#process_request_context' do
    subject { described_class.process_request_context }

    it { is_expected.to be_a(Moorkit::Webhooks::Segment::Context::ProcessRequest) }
  end

  context '#process_identify_requests_context' do
    subject { described_class.process_identify_requests_context }

    it { is_expected.to be_a(Moorkit::Webhooks::Segment::Context::ProcessIdentifyRequests) }
  end

  context '#identify_event_context' do
    subject { described_class.identify_event_context }

    it { is_expected.to be_a(Moorkit::Webhooks::Segment::Context::IdentifyEvent) }
  end
end
