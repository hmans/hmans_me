module PostExtensions
  def slug
    name.sub(%r{^(\d\d\d\d\-\d\d?\-\d\d?)\-}, "")
  end
end

extend PostExtensions
