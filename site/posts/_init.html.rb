module PostUrlsWithDays
  class YearlyNode < Flutterby::Node
    def emit_child(name)
      if name =~ %r{\A[0-9]+\Z}
        MonthlyNode.new(name, parent: self)
      end
    end
  end

  class MonthlyNode < Flutterby::Node
    def emit_child(name)
      if name =~ %r{\A[0-9]+\Z}
        DailyNode.new(name, parent: self)
      end
    end
  end

  class DailyNode < Flutterby::Node
  end

  def emit_child(name)
    if name =~ %r{\A[0-9]+\Z}
      YearlyNode.new(name, parent: self)
    end
  end



  def self.extended(base)
    base.move_posts
  end

  def move_posts
    # Store a reference to all posts for later
    data[:posts] = pages

    # Move posts to their correct date URL
    data[:posts].each do |post|
      target_name = post.data[:date].strftime("%Y/%m/%d")
      puts "Moving #{post.name} to #{target_name}"

      # move it to the new node
      post.parent = find(target_name)
      post.name   = post.slug
    end

    # Build an index of latest posts
    data[:latest_posts] = data[:posts].sort_by {|p| p.data['date'] }.reverse
  end
end


parent.extend PostUrlsWithDays
