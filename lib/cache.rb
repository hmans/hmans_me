module Cache
  def self.get(key)
    store[key]
  end

  def self.set(key, value)
    store[key] = value
  end

  def self.fetch(key)
    get(key) || set(key, yield)
  end

  def self.store
    $cache ||= {}
  end
end
