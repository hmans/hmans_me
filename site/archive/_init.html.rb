module PostArchive
  def self.extended(base)
    base.load_years
    base.create_archive_pages
  end

  def load_years
    all_posts = find("/posts").pages
    post_groups = all_posts.group_by { |p| p.data['date'].year }
    data[:years] = post_groups.keys
  end

  def create_archive_pages
    # For each year, create a new node with an index page.
    data[:years].each do |year|
      find("_page").copy(year.to_s, year: year)
    end
  end
end

parent.extend PostArchive
