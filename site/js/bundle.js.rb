def uglify(node)
  Uglifier.new.compile(node.render)
end

output = ""
output << uglify(find("./app.js"))
output << uglify(find("./jquery-oembed.js"))
output << uglify(find("./turbolinks.js"))

output
