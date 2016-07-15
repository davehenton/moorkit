Given /^a Api Request with id "(.*?)" and paylod:?$/ do |api_request_id, payload|
  ApiRequest.create(id: api_request_id, method: "POST", path:"/api", payload: JSON.parse(payload)).id
end

Given /^I am a Worker processing a Segment identify job with api_request_id "(.*?)"$/ do |api_request_id|
  Jobs::Moorkit::Webhooks::Segment.perform({"api_request_id" => api_request_id})
end

Then /^a new user record should be created with uuid "(.*?)" and details:?$/ do |uuid, details|
  user = User.where(uuid: uuid).first
  json_details = JSON.parse(details)
  expect(user).to be_a(User)
  expect(user.details).to eq(json_details)
end
