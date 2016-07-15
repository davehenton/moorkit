require 'rails_helper'

RSpec.describe UserAuthentication, type: :model do
  let(:data) { {provider: "google", uid: 11111} }
  subject { described_class.new(data:data) }

  it { is_expected.to be_a(described_class) }

end
