module PostExtensions
  def url
    ::File.join(parent ? parent.url : "/", name_with_date)
  end

  def name_with_date
    date = data['date'] || Date.today
    "#{date.year}/#{date.month}/#{date.day}/#{slug}"
  end

  def slug
    full_name.sub(%r{^(\d\d\d\d\-\d\d?\-\d\d?)\-}, "")
  end
end

extend PostExtensions
