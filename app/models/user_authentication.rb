class UserAuthentication < ActiveRecord::Base
  serialize :data, HashSerializer
  belongs_to :user
end
