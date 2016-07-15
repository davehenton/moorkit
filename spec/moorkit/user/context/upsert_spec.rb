require 'spec_helper'
require 'moorkit/user/context/upsert'
require 'json'

RSpec.describe Moorkit::User::Context::Upsert do
  let(:logger) { double(:logger, debug: true) }
  let(:uuid) { "3528facb-75df-4d25-9534-2186de6db26b" }
  let(:existing_details) { {role:'Parent', geo_city:'Chicago'} }
  let(:existing_email) { 'a@b.com' }
  let(:user_entity) { double(:user_entity, uuid: uuid, details: existing_details) }
  let(:user_array) { [user_entity] }
  let(:user_model) { double(:user_model, new: user_entity, where: user_array) }
  let(:context) { described_class.new(user_model: user_model, logger: logger) }

  describe "#new" do
    subject { context }

    it { is_expected.to be_a(described_class) }
  end

  describe "#call" do
    let(:new_email) { 'b@c.com' }
    let(:new_details) { {role:'Seeker', region: 'Chicago'} }
    let(:merged_details) { {sitter_rank: 5} }
    let(:new_user_entity) { double(:user_entity, uuid: uuid, details: existing_details) }
    let(:tools) { class_double(Support::Tools).as_stubbed_const }
    subject { context.call(uuid: uuid, details: new_details)}

    before(:each) do
      allow(user_entity).to receive(:update!).and_return(new_user_entity)
      allow(tools).to receive(:deep_hash_merge).and_return(merged_details)
    end

    it { is_expected.to eq(user_entity) }

    it "merges the existing details with the new details" do
      expect(tools).to receive(:deep_hash_merge).with(existing_hash: existing_details, new_hash: new_details)
      subject
    end

    it 'it updates user with merged details' do
      expect(user_entity).to receive(:update!).with(details: merged_details)
      subject
    end

    context 'when user exists' do
      it 'is not expected to create a new user' do
        expect(user_model).not_to receive(:new)
        subject
      end
    end

    context 'when user does not exist' do
      let(:user_array) { [] }

      it 'is expected to create a new user with the uuid' do
        expect(user_model).to receive(:new).with(uuid: uuid, details: {})
        subject
      end
    end
  end
end
