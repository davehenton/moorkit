Then /^the background job should create a member with uuid "([^"]*)"$/ do |uuid|
  user = User.where(uuid: uuid).first
  expect(user).to be_a(User)
end
