class Rollout
  def initialize(redis)
    @redis = redis
  end

  def activate(feature, object)
    @redis.sadd(key(feature), "#{object.class.name}-#{object.id}")
  end

  def deactivate(feature, object)
    @redis.srem(key(feature), "#{object.class.name}-#{object.id}")
  end

  def active?(feature, object)
     @redis.sismember(key(feature), "#{object.class.name}-#{object.id}")
  end
  
  def inactive?(feature, object)
    !active?(feature, object)
  end

  private
    def key(name)
      "rollout-feature:#{name}"
    end
end
