# Currently not functional.

module PostArchive
  def setup
    load_years
    create_archive_pages
  end

  def load_years
    all_posts = parent.data[:posts]
    post_groups = all_posts.group_by { |p| p.data['date'].year }
    data[:years] = post_groups.keys
    puts data[:years].inspect
  end

  def create_archive_pages
    # For each year, create a new node with an index page.
    data[:years].each do |year|
      find("_page").copy(year.to_s, year: year)
    end
  end
end

parent.extend PostArchive
