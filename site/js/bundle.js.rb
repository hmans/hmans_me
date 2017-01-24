# My sorry excuse for an API:

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
    @nodes.compact.map(&:render).join("\n")
  end

  def uglify
    Uglifier.new.compile(concatenate)
  end
end


# Use that API
bundle = JavaScriptBundle.new

bundle << find("./app.js")
bundle << find("./jquery-oembed.js")
bundle << find("./turbolinks.js")

bundle.uglify
