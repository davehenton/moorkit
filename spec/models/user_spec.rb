require 'rails_helper'

RSpec.describe User, type: :model do
  let(:details) { {traits: {'geo_state' => 'IL'}}}
  subject { described_class.new(details:details) }

  it { is_expected.to be_a(described_class) }

  it 'allows direct access to datail keys [:traits]' do
    [:traits].each do |key|
      expect(subject.send key).to eq(details[key])
    end
  end
end
