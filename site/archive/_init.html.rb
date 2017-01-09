def filter!
  # Remove this node's extension because we're going to turn it
  # into a folder, anyway. (It only has an extra HTML extension
  # because otherwise, the processing wouldn't kick in!)
  self.ext = nil

  # Load all blog posts and group them by year.
  all_posts = find("/posts").pages
  post_groups = all_posts.group_by { |p| p.data['date'].year }

  # For each year, create a new node with an index page.
  post_groups.each do |year, post|
    page = sibling("_page").copy(year.to_s)
    page.data['year'] = year
  end
end
