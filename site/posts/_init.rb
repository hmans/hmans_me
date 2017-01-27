# This is where we extend all of this folder's siblings, which happen to be
# blog posts. Yay!
#
extend_siblings do
  # Extend all blog posts with a `#date` helper method that provides
  # easy access to data.date. Yes, I'm lazy.
  #
  def date
    data.date
  end

  def draft?
    !!data.draft
  end

  # When this node is reloaded (eg. because the originating file was modified),
  # emit a :post_reloaded event that the blog section can react on.
  #
  on :reloaded do
    emit :post_reloaded, self
  end
end

# The parent of this initialization node is the blog section itself, so
# let's teach it some tricks.
#
extend_parent do
  on :setup do
    posts.each do |post|
      move_post(post)
    end
  end

  on :post_reloaded do |post|
    move_post(post)

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
