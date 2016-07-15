Then /^the background job should create a member with sso_uuid "([^"]*)"$/ do |sso_uuid|
  member = Member.where(sso_uuid: sso_uuid).first
  expect(member).to be_a(Member)
end
