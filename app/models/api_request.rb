class ApiRequest < ActiveRecord::Base
  serialize :payload, HashSerializer
  serialize :headers, HashSerializer
  store_accessor :headers, :authorization, :content_type, :accept, :cookie, :host
end
