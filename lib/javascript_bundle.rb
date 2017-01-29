require 'cache'

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

  private

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
