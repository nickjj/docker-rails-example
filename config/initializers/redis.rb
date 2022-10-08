# to fix issue with redis deprecation warning. more info:
# https://makandracards.com/makandra/510011-version-5-of-the-ruby-redis-gem-removes-redis-current
module RedisHelpers
  class << self
    def redis
      @redis ||= Redis.new(:url => (ENV["REDIS_URL"] || 'redis://redis:6379/1'))
    end
  end
end