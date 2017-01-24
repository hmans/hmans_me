# What follows is my sorry excuse for a JavaScript bundling API.
# This, of course, would be extracted into Flutterby or a plugin gem.
# You will find the code that actually uses this further down the file.

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


# This is where we get to use the API:

bundle = JavaScriptBundle.new

bundle << find("./app.js")
bundle << find("./jquery-oembed.js")
bundle << find("./turbolinks.js")

bundle.uglify
