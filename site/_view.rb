module SiteHelpers
  def poop
    "💩"
  end

  def blog_posts
    find('/posts').pages.sort_by {|p| p.data['date'] }.reverse
  end

  def page_title
    page.data["title"] ?
      "#{page.data["title"]} &middot; #{config["site_title"]}" :
      config["site_title"]
  end

  def config
    config_node.data
  end

  def config_node
    @config_node ||= find("/_config")
  end
end

extend SiteHelpers
