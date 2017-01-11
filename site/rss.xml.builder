xml.instruct! :xml, :version => "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Hendrik Mans"
    xml.author "Hendrik Mans"
    xml.description "Software-Development, Mobiles Devices, Photography"
    xml.link "https://www.codingfish.com"
    xml.language "en"

    for post in blog_posts.first(10)
      xml.item do
        xml.title post.data["title"]
        xml.author "Hendrik Mans"
        xml.pubDate post.data["date"].iso8601
        url = "http://hmans.io" + post.url
        xml.link url
        xml.guid url

        xml.description post.body
      end
    end
  end
end
