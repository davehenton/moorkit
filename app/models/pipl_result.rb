class PiplResult < ActiveRecord::Base
  belongs_to :members
  serialize :request, HashSerializer
  serialize :response, HashSerializer
  store_accessor :response, :http_status_code, :person_count, :search_id, :person
end
