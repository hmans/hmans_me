---
title: Flutterby Event Handling
blurb: in which I go into way too much detail about some upcoming new stuff in my own little static site generator.
---

[Flutterby](http://www.flutterby.run/) has a built-in HTTP server that will serve your website. Just like Flutterby does when you're exporting your site to its static version, the first thing it will do is read your source directory and build an in-process object graph from all the files it encounters. (This graph is the very core of everything that Flutterby does.)

When a file changes in the filesystem, we obviously want this change to be reflected when viewing the site, so this graph needs to be updated. The currently released version of Flutterby has a very brute-force approach to this: whenever it detects a change in the file system, it reloads _the entire graph from scratch_.

This works fine (and is faster than it sounds), but it's not a solid base for where I ultimately want to go with this framework. To this end, I'm currently adding code that, when a file is changed (or deleted, or added), will only reload, remove or add the node that was originally spawned from it. But when you're changing the graph dynamically, how do you keep things up-to-date?

### Shapeshifting the Site Graph

You may have code in your project that modifies the graph dynamically. For example, I have some code for this site that makes sure blog posts have URLs that reflect their individual dates: `/posts/2017/01/25/flutterby-events.html` instead of just `/posts/flutterby-events.html`.

Other frameworks may do this through URL rewriting hacks; in the world of Flutterby, you shapeshift the graph that represents your site before it gets exported (or served.) Yes, you literally create new directories and move files -- except that you do this purely in memory, by modifying the site graph.

You will typically do this from within initializers, special files named `_init.rb`. The code that does the filing of my blog posts currently looks like this:

~~~ ruby
on :setup do
  posts.each do |post|
    move_post(post)
  end
end

def move_post(post)
  post.parent = get_date_node(post.date)
end

# Find (or create) a child node structure that represents the given
# date (eg. "2017/04/01").
#
def get_date_node(date)
  year, month, day = date.strftime("%Y/%m/%d").split("/")

  yearly  = find(year) || create(year)
  monthly = yearly.find(month) || yearly.create(month)
  monthly.find(day) || monthly.create(day)
end
~~~

The `:setup` event will be triggered by Flutterby once the site graph has been created fully, and before Flutterby starts exporting or serving your site. This is where you would typically hook in to perform graph modifications.

In the `:setup` handler above, we iterate through the `posts` array (which is another helper that I've added that returns a list of all blog posts), and move each post to its correct date path.


### Reacting to events

Now here's the thing -- in this new world where any part of the site graph may be reloaded at any time, we need to be able to react on this in other parts of the tree -- for example, if the date of an existing blog post changes, we want to make sure that our blog section can move it to the new date URL.

Flutterby fires a `:reloaded` event when a node is reloaded, and we will use it to notify the root node of the blog so it can do its work. In the initializer code for our posts, let's do this:

~~~ ruby
on :reloaded do
  emit :post_reloaded, self
end
~~~

The `emit` method fires a new event that bubbles up the graph -- in other words, the originating node's parent, its own parent, and so on, up to the root node itself will be notified about it, and everyone gets a chance to react.

So, back in the blog section's code, we can now do this:

~~~ ruby
on :post_reloaded do |post|
  move_post(post)
end
~~~

Voila, now the blog section will keep re-filing posts into the correct folder when they change! You can see the complete code for my initializer [right here](https://github.com/hmans/hmans_me/blob/bf7e02b34369d804764f032b3ad4ceb67ec48fb7/site/posts/_init.rb).



### Final Notes

You may think that you don't not need this kind of flexibility when simply building a small static site -- and you'd be completely right. These features are primarily in preparation for Flutterby's "Live Mode", which essentially turns your site into a fully-fledged web application once you have the need for it.

Note that this stuff currently lives in an experimental branch and will very likely change another couple of times before landing in master.

For more information on Flutterby, check out its website, [flutterby.run](http://www.flutterby.run/).
