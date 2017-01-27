extend_parent do
  on :setup do
    # For each year, create a new node with an index page.
    years.each do |year|
      find("_page").copy(year.to_s, year: year)
    end
  end

  def years
    @years ||= find('/posts').posts.map { |p| p.date.year }.uniq
  end
end
