# What follows is my sorry excuse for a JavaScript bundling API.
# This, of course, would be extracted into Flutterby or a plugin gem.

require 'javascript_bundle'

bundle = JavaScriptBundle.new

find("./_bundle").children.each do |node|
  bundle << node
end

bundle.uglify
