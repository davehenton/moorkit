require 'resque'
require 'resque/server'

Resque.redis = $redis

Resque.redis.namespace = "resque:Moorkit"

unless ENV.fetch('MK_RESQUE_CREDS', nil).nil? then
  Resque::Server.use(Rack::Auth::Basic) do |user, password|
    ENV['MK_RESQUE_CREDS'].eql? "#{user}:#{password}"
  end
end
