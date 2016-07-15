require 'spec_helper'
require 'support/tools'

RSpec.describe Support::Tools do
  describe '#deep_hash_merge' do
    let(:existing_hash) {  { address: {state: 'IL', zip:'60618'}, sso_uuid: '1', favs:[1,2,3], role: 'New' } }
    let(:new_hash) { {email: 'mickey@disney.com', role:'Active'} }
    subject { described_class.deep_hash_merge(existing_hash: existing_hash, new_hash: new_hash) }

    it 'merges two basic hashes together' do
      expect(subject).to eq(existing_hash.merge(new_hash))
    end

    context 'when merging nested hashes' do
      let(:new_hash) { { address: {street:'20 W Kinzie', zip: '60654' }} }
      let(:address) { existing_hash[:address].merge(new_hash[:address]) }
      let(:result_hash) { existing_hash.each { |k,v| v = (k == :address) ? address : v } }

      it 'combines the nested hash' do
        expect(subject).to eq(result_hash)
      end

      it 'concatenates the nested hash, keeping the newer values' do
        expect(subject[:address]).to include(:street, :state, :zip)
      end

      it 'keeps the newer values' do
        expect(subject[:address][:zip]).to eq(new_hash[:address][:zip])
      end
    end

    context 'when merging arrays' do
      let(:new_hash) { { sso_uuid: '1', favs: [3,4,'5'] } }

      it 'it concatenates and dedups array' do
        expect(subject[:favs]).to eq([1,2,3,4,'5'])
      end

      context 'when it''s an array of hashes' do
        let(:existing_hash) { {sso_uuid:1, favs:[{a:2}, {b:3}]} }
        let(:new_hash) { {sso_uuid:1, favs:[{a: 1}, {a: 2}]} }

        it 'concatenates to unique set' do
          expect(subject[:favs]).to eq([{a:2}, {b:3}, {a:1}])
        end

      end
    end
  end

  describe '#is_uuid?' do
    let(:value) { '22374524-8d18-410c-9140-fbf38ecdfe6c' }
    subject { described_class.is_uuid?(value) }

    it { is_expected.to be(true) }

    context 'value is a non uuid string' do
      let(:value) { '1' }

      it { is_expected.to be(false) }
    end

    context 'value is nil' do
      let(:value) { nil }

      it { is_expected.to be(false) }
    end
  end
end
