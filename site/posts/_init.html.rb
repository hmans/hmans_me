module PostUrlsWithDays
  def self.extended(base)
    base.move_posts
    base.build_latest_post_index
  end

  def move_posts
    # Store a reference to all posts so we can still query these
    # objects later.
    data[:posts] = pages

    # Move posts to their correct date URL.
    data[:posts].each do |post|
      # Move it to a node representing the date (eg. 2017/01/11)
      post.parent = get_date_node(post.data[:date])

      # Remove the date from the file name
      post.name   = post.slug
    end
  end

  def build_latest_post_index
    data[:latest_posts] = data[:posts].sort_by {|p| p.data['date'] }.reverse
  end

  def get_date_node(date)
    yearly  = find(date.year) || create(date.year)
    monthly = yearly.find(date.month) || yearly.create(date.month)
    monthly.find(date.day) || monthly.create(date.day)
  end
end

parent.extend PostUrlsWithDays
