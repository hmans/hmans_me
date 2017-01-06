def blog_posts
  find('/posts').pages.sort_by {|p| p.data['date'] }.reverse
end
