root.on :created, "/posts" do
  emit :update_yearly_archives
end

on :update_yearly_archives do
  logger.info "Generating yearly archives!"

  @yearly_archives = find("/posts").posts.map { |p| p.data.date.year }.uniq.map do |year|
    logger.info "Creating yearly archive page for #{year}"
    find("_page").copy(year.to_s, year: year)
  end
end

def yearly_archives
  @yearly_archives
end
