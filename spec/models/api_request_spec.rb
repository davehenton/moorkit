require 'model_helper'

RSpec.describe ApiRequest, type: :model do
  let(:method) { "GET" }
  let(:path) { '/path' }
  let(:headers) { {
    authorization: "Bearer [REDACTED]",
    content_type: "application/json",
    accept: "application/json",
    cookie: "",
    host: "example.com"} }
  let(:payload) { { sso_uuid: "1" } }
  subject { described_class.new(method: method, path: path, headers: headers, payload: payload) }

  it { is_expected.to be_a(described_class) }

  it 'is invalid with a duplicate request_uuid' do
    original = described_class.create(method: method, path: path)
    subject.id = original.id
    expect { subject.save }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'allows direct access to payload keys [:authorization, :content_type, :accept, :cookie, :host]' do
    [:authorization, :content_type, :accept, :cookie, :host].each do |key|
      expect(subject.send key).to eq(headers[key])
    end
  end
end
