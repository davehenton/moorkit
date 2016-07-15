require 'spec_helper'
require 'moorkit/user_authentication/context/create_user'
require 'moorkit/user_authentication/entity/auth_payload'

RSpec.describe Moorkit::UserAuthentication::Context::CreateUser do
  let(:logger) { double(:logger, debug: true) }
  let(:provider) { 'PawPatrol' }
  let(:uid) { "3528facb-75df-4d25-9534-2186de6db26b" }
  let(:email) { "jimmy@johns.com" }
  let(:props) { {'provider' => provider, 'uid' => uid, 'email' =>  email} }
  let(:auth_payload) { Moorkit::UserAuthentication::Entity::AuthPayload.new(props) }
  let(:user) { double(:user, uuid: SecureRandom.uuid, details: {}, user_authentications: user_auth_model ) }
  let(:user_auth) { double(:user_auth, provider: provider, uid: uid) }
  let(:user_model) { double(:user_model, create: user) }
  let(:user_auth_model) { double(:user_auth_model, create: user_auth) }
  let(:context) { described_class.new(user_model: user_model, user_auth_model: user_auth_model, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(auth_payload: auth_payload) }

    it { is_expected.to eq(user) }

    context 'when user fails to create' do
      before(:each) do
        allow(user_model).to receive(:create).and_raise(StandardError)
      end

      it 'raises an InvalidUser error' do
        expect { subject }.to raise_error Moorkit::UserAuthentication::Context::CreateUser::InvalidUser
      end
    end

    context 'when user_authentication fails to create' do
      before(:each) do
        allow(user_auth_model).to receive(:create).and_raise(StandardError)
      end

      it 'raises an InvalidUser error' do
        expect { subject }.to raise_error Moorkit::UserAuthentication::Context::CreateUser::InvalidUserAuthentication
      end
    end
  end
end
