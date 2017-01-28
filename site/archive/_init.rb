root.on(:created) do |node|
  if node.url == "/posts"
    generate_yearly_archives!
  end
end

def yearly_archives
  @yearly_archives
end

def generate_yearly_archives!
  @yearly_archives = begin
    logger.info "Generating yearly archives!"
    find('/posts').posts.map { |p| p.data.date.year }.uniq.map do |year|
      logger.info "Creating yearly archive page for #{year}"
      find("_page").copy(year.to_s, year: year)
    end
  end
end
