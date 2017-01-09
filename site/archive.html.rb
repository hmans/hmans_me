def filter!
  self.ext = nil

  all_posts = find("/posts").pages

  post_groups = all_posts.group_by do |p|
    # We need to make sure the post's data has been extracted
    # by now. We shouldn't really have to do this here -- I'll
    # figure out something smarter when I've had coffee.
    p.extract_data!

    p.data['date'].year
  end

  # For each year, create a new node with an index page.
  post_groups.each do |year, post|
    Flutterby::Node.new "#{year}.html",
      parent: self,
      source: "hi from #{year}!"
  end
end
