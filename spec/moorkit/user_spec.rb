require 'spec_helper'
require 'moorkit/user'

RSpec.describe Moorkit::User do
  subject { described_class }
  let(:logger) { double(:logger) }

  before(:each) do
    class_double("User").as_stubbed_const
    class_double("Rails").as_stubbed_const
    allow(Rails).to receive(:logger).and_return(logger)
  end

  context '#upsert_context' do
    subject { described_class.upsert_context }

    it { is_expected.to be_a(described_class::Context::Upsert) }
  end

end
