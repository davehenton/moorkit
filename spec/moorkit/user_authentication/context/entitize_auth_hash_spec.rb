require 'spec_helper'
require 'moorkit/user_authentication/context/entitize_auth_hash'

RSpec.describe Moorkit::UserAuthentication::Context::EntitizeAuthHash do
  let(:logger) { double(:logger, debug: true) }
  let(:context) { described_class.new(logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    subject { context.call(auth_hash: auth_hash) }
    let(:auth_hash) {{
      "provider": "PawPatrol",
      "uid": "111188882222444492222",
      "info": {
        "name": "Jimmy Johns",
        "email": "jimmy@johns.com",
        "first_name": "Jimmy",
        "last_name": "Johns",
      },
      "credentials": {
        "token": "token",
        "expires_at": 1468507430,
      },
    }}

    it { is_expected.to be_a(Moorkit::UserAuthentication::Entity::AuthPayload) }

    it 'matches key values' do
      expect(subject.provider).to eq("PawPatrol")
      expect(subject.uid).to eq("111188882222444492222")
      expect(subject.first_name).to eq("Jimmy")
      expect(subject.last_name).to eq("Johns")
      expect(subject.email).to eq("jimmy@johns.com")
      expect(subject.token).to eq("token")
      expect(subject.expires_at).to eq(1468507430)
    end

    context "when first and last name are not provided" do

      before(:each) do
        auth_hash[:info].delete(:first_name)
        auth_hash[:info].delete(:last_name)
      end

      it "splits #{name} name and assigns accordingly" do
        auth_hash[:info][:name] = "Jay Jo Johns"
        expect(subject.last_name).to eq("Johns")
        expect(subject.first_name).to eq("Jay Jo")
      end

      it "splits #{name} name and assigns accordingly" do
        auth_hash[:info][:name] = "Jay Jo-Johns"
        expect(subject.last_name).to eq("Jo-Johns")
        expect(subject.first_name).to eq("Jay")
      end
    end
  end
end
