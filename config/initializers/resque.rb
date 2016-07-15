require 'resque'
require 'resque/server'

Resque.redis = $redis

Resque.redis.namespace = "resque:Moorkit"

if ENV['MK_RESQUE_CREDS'] then
  Resque::Server.use(Rack::Auth::Basic) do |user, password|
    ENV['MK_RESQUE_CREDS'].eql? "#{user}:#{password}"
  end
end
