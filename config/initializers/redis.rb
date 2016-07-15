rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

$redis = Redis.new(url: ENV['MK_REDIS_URL'])
