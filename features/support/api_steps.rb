Given /^I am a valid API user with Bearer token "(.*?)"$/ do |token|
  header 'Authorization', "Bearer #{token}"
  id, shared_secret = token.split(":")
  shared_secret_hash = BCrypt::Password.create(shared_secret)
  ApiKey.create(id: id, shared_secret_hash: shared_secret_hash)
end

Given /^I am a invalid API user with Bearer token "(.*?)"$/ do |token|
  header 'Authorization', "Bearer #{token}"
end
