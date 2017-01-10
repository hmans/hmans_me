module SiteHelpers
  def poop
    "💩"
  end

  def blog_posts
    find('/posts').pages.sort_by {|p| p.data['date'] }.reverse
  end

  def page_title
    page.data["title"] ?
      "#{page.data["title"]} &middot; Hendrik Mans" :
      "Hendrik Mans, Web Person"
  end
end

extend SiteHelpers
