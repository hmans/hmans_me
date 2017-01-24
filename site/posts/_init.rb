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
end

extend_parent do
  on_setup do
    # Move posts to their correct date URL.
    posts.each do |post|
      # Move it to a node representing the date (eg. 2017/01/11)
      post.parent = get_date_node(post.date)
    end
  end

  def posts
    @posts ||= pages
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
