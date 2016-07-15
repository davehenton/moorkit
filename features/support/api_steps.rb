
Given /^I have a VALID access token$/ do
  user = FactoryGirl.create(:user)
  doorkeeper_app = FactoryGirl.create(:doorkeeper_application)
  access_token = FactoryGirl.create(
    :doorkeeper_token,
    application_id: doorkeeper_app.id,
    resource_owner_id: user.id
  )
  header 'Authorization', "Bearer #{access_token.token}"
end

Given /^I have an INVALID access token$/ do
  access_token = "bad_token"
  header 'Authorization', "Bearer #{access_token}"
end
