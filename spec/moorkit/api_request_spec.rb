require 'spec_helper'
require 'moorkit/api_request'

RSpec.describe Moorkit::ApiRequest do
  subject { described_class }
  let(:logger) { double(:logger) }

  before(:each) do
    class_double("ApiRequest").as_stubbed_const
    class_double("Rails").as_stubbed_const
    allow(Rails).to receive(:logger).and_return(logger)
  end

  context '#save_api_request_context' do
    subject { described_class.save_context }

    it { is_expected.to be_a(described_class::Context::Save) }
  end

end
