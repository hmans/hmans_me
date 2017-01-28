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
    @nodes.compact.map(&:render).join(";")
  end

  def uglify
    Uglifier.compile(concatenate)
  end
end


# This is where we get to use the API:
$output ||= begin
  bundle = JavaScriptBundle.new

  find("./_bundle").children.each do |node|
    bundle << node
  end

  bundle.uglify
end
