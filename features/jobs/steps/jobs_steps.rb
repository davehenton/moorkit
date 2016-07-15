Given /^a Api Request with id "(.*?)" and paylod:?$/ do |api_request_id, payload|
  ApiRequest.create(id: api_request_id, payload: JSON.parse(payload)).id
end

Given /^I am a Worker processing a Segment identify job with api_request_id "(.*?)"$/ do |api_request_id|
  Jobs::Sherlock::Webhooks::Segment.perform({"api_request_id" => api_request_id})
end

Then /^a new member record should be created with sso_uuid "(.*?)" and details:?$/ do |sso_uuid, details|
  member = Member.where(sso_uuid: sso_uuid).first
  json_details = JSON.parse(details)
  expect(member).to be_a(Member)
  expect(member.details).to eq(json_details)
end
