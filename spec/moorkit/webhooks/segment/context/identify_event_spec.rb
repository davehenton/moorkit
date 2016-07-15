require 'spec_helper'
require 'moorkit/webhooks/segment/context/identify_event'

RSpec.describe Moorkit::Webhooks::Segment::Context::IdentifyEvent do
  let(:logger) { double(:logger, info: true, debug: true) }
  let(:uuid) { '12345678-1234-1234-1234-123456789012' }
  let(:email) { 'jimmy@jimmyjohns.com' }
  let(:payload) { {geo_state: "IL"}.merge({ userId: uuid}).merge({traits: {email: email}}) }
  let(:user_upsert_context) { double(:user_upsert_context, call: true) }
  let(:context) { described_class.new(user_upsert_context: user_upsert_context, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(payload: payload) }

    it { is_expected.to eq(true) }

    it 'calls user_upsert_context with valid arguments' do
      expect(user_upsert_context).to receive(:call).with(uuid: uuid, email: email, details: payload)
      subject
    end

    context 'when uuid is not valid' do
      let(:uuid) { '1' }

      it 'does not upsert a user' do
        expect(user_upsert_context).not_to receive(:call)
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
        allow(user_upsert_context).to receive(:call).and_raise(StandardError.new("Unknown Error"))
      end

      it 'is expected to raise an UnknownError' do
        expect { subject }.to raise_error described_class::UnknownError
      end
    end
  end
end
