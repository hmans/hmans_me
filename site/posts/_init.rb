module PostExtensions
  def slug
    name.sub(%r{^(\d\d\d\d\-\d\d?\-\d\d?)\-}, "")
  end
end

extend_siblings PostExtensions



module PostUrlsWithDays
  def posts
    @posts || begin
      @posts = pages
      move_posts
    end
  end

  def latest_posts
    @latest_posts ||= posts.sort_by {|p| p.data['date'] }.reverse
  end

  def move_posts
    # Move posts to their correct date URL.
    @posts.each do |post|
      # Move it to a node representing the date (eg. 2017/01/11)
      post.parent = get_date_node(post.data[:date])

      # Remove the date from the file name
      post.name   = post.slug
    end
  end

  def get_date_node(date)
    year, month, day = date.strftime("%Y/%m/%d").split("/")

    yearly  = find(year) || create(year)
    monthly = yearly.find(month) || yearly.create(month)
    monthly.find(day) || monthly.create(day)
  end
end

parent.extend PostUrlsWithDays
