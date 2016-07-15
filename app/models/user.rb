class User < ActiveRecord::Base
  serialize :details, HashSerializer
  store_accessor :details, :traits
  has_many :user_authentications
end
