# When a post is created, let's extend it with the module above, and sort
# it into the correct day node.
#
on :created do |post|
  if post.page?
    post.extend PostExtension
    move_post(post)
  end
end

# When a post is deleted, reset the currently memoized posts data.
#
on :deleted do |post|
  if post.page? && post != self
    reset_posts
  end
end

# When a post is reloaded, move it (if the date has changed) and reset
# the memoized post data.
#
on :reloaded do |post|
  if post.page? && post != self
    move_post(post)
    reset_posts
  end
end



# This is an extension we'll load into newly created posts.
#
module PostExtension
  def date
    data.date
  end

  def draft?
    !!data.draft
  end
end

# A module with extensions for the blog section itself.
#
module BlogExtension
  def reset_posts
    # Reset the previously memoized ivars so they get refreshed the
    # next time they're used.
    @posts = nil
    @latest_posts = nil
  end

  def move_post(post)
    post.parent = get_date_node(post.date)
  end

  def posts
    @posts ||= descendants.select(&:page?)
  end

  def latest_posts
    @latest_posts ||= posts.sort_by(&:date).reverse
  end

  # Find (or create) a child node structure that represents the given
  # date (eg. "2017/04/01").
  #
  def get_date_node(date)
    year, month, day = date.strftime("%Y/%m/%d").split("/")

    yearly  = find(year) || create(year)
    monthly = yearly.find(month) || yearly.create(month)
    monthly.find(day) || monthly.create(day)
  end
end

extend BlogExtension
