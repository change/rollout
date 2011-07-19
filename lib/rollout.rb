class Rollout
  def initialize(redis)
    @redis = redis
  end

  def activate(feature, object = nil)
    @redis.sadd(key(feature), val(object))
  end

  def deactivate(feature, object = nil)
    @redis.srem(key(feature), val(object))
  end

  def active?(feature, object = nil)
     @redis.sismember(key(feature), val(object))
  end
  
  def inactive?(feature, object = nil)
    !active?(feature, object)
  end

  private
    def key(name)
      "rollout-feature:#{name}"
    end

    def val(object)
      object.nil? ? "APP" : "#{object.class.name}-#{object.id}"
    end
end
