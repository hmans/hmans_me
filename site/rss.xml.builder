xml.instruct!
xml.rss version: "2.0", 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title "Hendrik Mans"
    xml.description "Hi, I'm Hendrik! I do code things and blog things and thingy things. This is where I occasionally post ramblings about some of them."
    xml.link "http://hmans.io"
    xml.language "en"
    xml.generator "Flutterby #{Flutterby::VERSION}"
    xml.tag! "atom:link", href: "http://hmans.io/rss.xml", rel: "self", type: "application/rss+xml"

    for post in blog_posts.first(10)
      xml.item do
        xml.title post.data["title"]
        xml.author "hendrik@mans.de (Hendrik Mans)"
        xml.pubDate post.data["date"].to_time.rfc822
        url = "http://hmans.io" + post.url
        xml.link url
        xml.guid url, isPermaLink: true

        xml.description post.body
      end
    end
  end
end
