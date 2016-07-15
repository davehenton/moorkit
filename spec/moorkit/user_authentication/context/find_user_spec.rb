require 'spec_helper'
require 'moorkit/user_authentication/context/find_user'
require 'moorkit/user_authentication/entity/auth_payload'

RSpec.describe Moorkit::UserAuthentication::Context::FindUser do
  let(:logger) { double(:logger, debug: true) }
  let(:provider) { 'PawPatrol' }
  let(:uid) { "3528facb-75df-4d25-9534-2186de6db26b" }
  let(:auth_payload_entity) { Moorkit::UserAuthentication::Entity::AuthPayload }
  let(:auth_payload) { auth_payload_entity.new({'provider' => provider, 'uid' => uid}) }
  let(:user) { double(:user, uuid: SecureRandom.uuid, details: {} ) }
  let(:user_auth) { double(:user_auth, provider: provider, uid: uid, user:user) }
  let(:user_auth_array) { [user_auth] }
  let(:user_auth_model) { double(:user_auth_model, where: user_auth_array) }
  let(:context) { described_class.new(user_auth_model: user_auth_model, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(auth_payload: auth_payload) }

    context 'when user_auth exists' do
      it { is_expected.to eq(user) }
    end

    context 'when user_auth does not exist' do
      let(:user_auth_array) { [] }
      it { is_expected.to be_nil }
    end
  end
end
