require 'rails_helper'

RSpec.describe "Resque management", type: :request do
  let(:user) { nil }
  let(:pw) { nil }
  let(:env) { {
    'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  } }

  context 'when correct basic auth credentials provided' do
    let(:user) {  ENV['MK_RESQUE_CREDS'].split(':').first }
    let(:pw) {  ENV['MK_RESQUE_CREDS'].split(':').second }

    it 'authenticate and redirect to overview page' do
      get '/resque', {}, env
      expect(response).to have_http_status(302)
    end
  end

  context 'when no basic auth credentials provided' do
    it 'to return a 401 - UnAuthorized status' do
      get '/resque', {}, env
      expect(response).to have_http_status(401)
    end
  end
end
