require 'spec_helper'
require 'moorkit/webhooks/segment/context/identify_event'

RSpec.describe Moorkit::Webhooks::Segment::Context::IdentifyEvent do
  let(:logger) { double(:logger, info: true, debug: true) }
  let(:sso_uuid) { '12345678-1234-1234-1234-123456789012' }
  let(:email) { 'jimmy@jimmyjohns.com' }
  let(:payload) { {geo_state: "IL"}.merge({ userId: sso_uuid}).merge({traits: {email: email}}) }
  let(:member_upsert_context) { double(:member_upsert_context, call: true) }
  let(:context) { described_class.new(member_upsert_context: member_upsert_context, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(payload: payload) }

    it { is_expected.to eq(true) }

    it 'calls member_upsert_context with valid arguments' do
      expect(member_upsert_context).to receive(:call).with(sso_uuid: sso_uuid, details: payload)
      subject
    end

    context 'when sso_uuid is not valid' do
      let(:sso_uuid) { '1' }

      it 'does not upsert a member' do
        expect(member_upsert_context).not_to receive(:call)
        subject
      end

      it 'logs a message' do
        expect(logger).to receive(:info)
        subject
      end

      it { is_expected.to eq(true) }
    end

    context 'when an unknown error occurs' do

      before(:each) do
        allow(member_upsert_context).to receive(:call).and_raise(StandardError.new("Unknown Error"))
      end

      it 'is expected to raise an UnknownError' do
        expect { subject }.to raise_error described_class::UnknownError
      end
    end
  end
end
