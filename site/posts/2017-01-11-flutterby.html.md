---
title: Introducing Flutterby!
---

<a class="embed" href="https://twitter.com/hmans/status/819227586446376960">11. Januar 2017</a>

So, here's my latest toy: **[Flutterby]**! It's -- at its core -- a static site generator built in Ruby. Yeah, just like Jekyll, minus the fantastic ecosystem that has had many years to mature. Well... :)

At its most basic, you use Flutterby to convert a [directory containing source files](https://github.com/hmans/hmans_me) into a directory containing [a beautiful static site](http://hmans.io). Assuming you have a computer with Ruby on it, it's easy to get started:

~~~ sh
# Install the gem. It's nice!
gem install flutterby

# Create a boilerplate project as a starting point
flutterby new mysite
cd mysite

# Start the development server on http://localhost:4004
flutterby serve
~~~

### But... why?!

I've had this very specific idea in my mind how such a thing should work, and I could not find it implemented in the wild. So it needed to be done! Also, creating is fun. :)

The fundamental difference between Flutterby and its peers is how it operates. Essentially, it iterates through three stages:

- **Stage 1**: read all the files from the source directory and convert them into a **graph of Ruby objects** that lives in RAM.
- **Stage 2**: apply some modest preprocessing, like importing JSON, YAML and TOML documents into the corresponding objects.
- **Stage 3**: render the site to disk (`flutterby build`) or via HTTP (`flutterby serve`).

This is great because your source directory is structured exactly like your generated site will be -- no special hidden top-level directories, it's just a hierarchy of _stuff_, just like your filesystem (or a website)!

This is also great because we can use the power of Ruby to get playful with this object graph. Flutterby offers a central `find` method that you use to query this graph. Want to render a list of blog posts? Just iterate through `find("/posts").pages`. Want to get some data out of a JSON file? Just talk to `find("users.json").data`.

But this is just the beginning. Flutterby can apply transformations to your files' contents, starting with simple things like rendering ERB or Slim templates, parsing Markdown, processing Sass. But you can also use Ruby in your project files to enhance the graph objects.

For example, you can easily add new view helpers through a `_view.rb` file:

~~~ ruby
def blog_posts
  find('/posts').pages
    .sort_by { |p| p.data['date'] }
    .reverse
end

def page_title
  page.data["title"] || "Unnamed Page"
end
~~~

Or how about dynamically creating new pages by copying existing objects and assigning new data to them? This is how I implemented [yearly archives](https://github.com/hmans/hmans_me/blob/master/site/archive/) for my blog:

~~~ ruby
module PostArchive
  def self.extended(base)
    base.create_archive_pages
  end

  def create_archive_pages
    # Load all blog posts and group them by year.
    all_posts = find("/posts").pages
    post_groups = all_posts.group_by { |p| p.data['date'].year }

    # For each year, create a new node with an index page.
    post_groups.each do |year, post|
      page = sibling("_page").copy(year.to_s)
      page.data['year'] = year
    end
  end
end

extend PostArchive
~~~

It's just Ruby -- go wild!

This entire approach gives you extreme flexibility with how to build and structure your projects. All that Flutterby sees is a graph of _stuff_. Unlike its peers, it doesn't know about _config files_ -- if you need configuration, just dump a [data file into your site tree](https://github.com/hmans/flutterby/blob/master/lib/templates/new_project/site/_config.toml) and read its values wherever your need them! There are no special `_layout` directories, and you don't need to reference a layout from your front matter -- they're just templates that, by default, apply to all pages in the current folder (and all included folders). There are no special `_post` directories; Flutterby doesn't even know what a blog is, but it makes it extremely easy to build one.

Since the dynamic parts are just Ruby, Flutterby is also easily to extend through gems. The plugin APIs aren't locked down yet, but things like the following will be trivial to package as a gem:

- New processors (here's [flutterby-coffeescript](https://github.com/hmans/flutterby-coffeescript/blob/master/lib/flutterby/coffeescript.rb) as an example)
- modules with helper methods that you can plug into your objects
- the one I'm most excited about: entire site sections, like a blog with tag archive pages. Just load the gem and mount its objects wherever in your site hierarchy you need them.

If you're curious, just generate a new site with `flutterby new` and look at its files. You will find it all very straight-forward!


### The immediate future

I don't want to leave the Flutterby gem at a very low version for too long, so I'll be trying to get it to a 1.0 release relatively soon -- what's missing right now is mostly nicer error handling, better documentation, and some fixes for `flutterby server`. Oh, and maybe a website! I wonder if there is a tool that could help...


### The long-term future

If you're still wondering why I ended up building _yet another static site generator_ -- of all things -- rest assured that generating static sites is not the only thing I'm trying to do with Flutterby. I have some fun ideas I want to try -- they will be the subject of future blog posts!

Stay tuned, and do give [Flutterby] a try -- I'm happy about all feedback!


[Flutterby]: https://github.com/hmans/flutterby
