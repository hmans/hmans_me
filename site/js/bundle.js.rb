# What follows is my sorry excuse for a JavaScript bundling API.
# This, of course, would be extracted into Flutterby or a plugin gem.
# You will find the code that actually uses this further down the file.


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

class JavaScriptBundle
  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def <<(node)
    if node
      @nodes << node
    end
  end

  def concatenate
    @nodes.compact.map(&:render).join(";")
  end

  def uglify
    Cache.fetch(cache_key) do
      uglify!
    end
  end

  def cache_key
    "bundle-#{newest_timestamp}"
  end

  def newest_timestamp
    @nodes.map(&:timestamp).max
  end

  def uglify!
    Uglifier.compile(concatenate)
  end
end


# This is where we get to use the API:
bundle = JavaScriptBundle.new

find("./_bundle").children.each do |node|
  bundle << node
end

bundle.uglify
