require 'spec_helper'
require 'moorkit/user_authentication'

RSpec.describe Moorkit::UserAuthentication do
  subject { described_class }
  let(:logger) { double(:logger) }

  before(:each) do
    class_double("UserAuthentication").as_stubbed_const
    class_double("User").as_stubbed_const
    class_double("Rails").as_stubbed_const
    allow(Rails).to receive(:logger).and_return(logger)
  end

  context '#find_user_context' do
    subject { described_class.find_user_context }
    it { is_expected.to be_a(described_class::Context::FindUser) }
  end

  context '#create_user_context' do
    subject { described_class.create_user_context }
    it { is_expected.to be_a(described_class::Context::CreateUser) }
  end

  context '#entitize_auth_hash_context' do
    subject { described_class.entitize_auth_hash_context }
    it { is_expected.to be_a(described_class::Context::EntitizeAuthHash) }
  end

end
