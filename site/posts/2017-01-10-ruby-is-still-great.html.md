+++
title = "Ruby is still great!"
+++

I realized something today:

**Ruby is still great.**

I've spent the last couple of weeks digging into some of the newer/fancier/shinier technologies that have been in the limelight of the development world lately -- specifically Elixir, Phoenix and Elm -- and while I've thoroughly enjoyed them all (and instantly had a bunch of fun ideas for things to build with them), I also realized once more how much I like Ruby, and what kind of project it's still a great choice for.

### [Elixir]

Elixir sure is a lot of fun. It's a purely functional language that sits on top of BEAM (aka the Erlang VM). It was my first time playing with functional programming, and also my first contact with Erlang. And what I've seen is really great! I could imagine doing more FP in the future, and I definitely want a version of the `|>` operator in every language. :>

I had not touched Erlang before, but wow, it's very impressive. OTP really is a great fit for networked, concurrent applications -- no big surprise there, considering its origins --, so I'm pretty confident that it will play _some_ role in my work life in the future.

### [Phoenix]

I'm not 100% sold on Phoenix, Elixir's most visible web application framework. This is not Phoenix' fault; 9 out 10 web applications simply don't _need_ the power that Phoenix and its Erlang underpinnings provide, and in these cases, developing them with Rails will be _much_ faster. This, of course, is a bit unfair; it's simply not very easy to compete with a decade-old ecosystem.

But the stuff that Phoenix adds to the mix where Erlang can really shine -- like WebSocket support -- is really, _really_ cool. In a recent client gig, we built a Phoenix-powered WebSocket server that can easily support hundreds of thousands of simultaneously connected users on just a small handful of servers without breaking a sweat -- try that with ActionCable!

When talking to other Phoenix users, it became apparent that only very few of them build normal CRUD apps that generate HTML -- the most common use cases at the moment appear to be JSON APIs and realtime applications. As you know, I'm a big "generate HTML on the server" kind of guy, and I felt very alone with this. I'm looking forward to seeing how Phoenix (and its ecosystem) will evolve over the next couple of years, and I've made a list of things I intend to contribute to it myself when I get the chance.

### [Elm]

Elm is a fun (and also functional) language for building client-side web applications. I believe reading somewhere that compiling to JavaScript is supposed to be merely an implementation detail, but it feels like the language is now firmly stuck in the world of in-browser applications. I felt it was a very nice alternative to stacks like React and Redux, and ended up building a very simple [clicker game], which felt like a perfect fit for the language. I could see myself using this more in the future, at least for those apps that require more complex client-side logic.

### But what about Ruby?

After spending all this time with these exciting technologies and thinking about some glorious (or at least fun) things to build with them, I ended up building a small tool I needed with Ruby -- and realized that I still love it very much. It's not terribly fast, it doesn't really do much for concurrency or parallelism, but it's just _so nice_.

The tool I wrote is a static site generator -- yes, yet another one -- that I'm now using to create and maintain this and some other sites. It performs some funky magic tricks that are really only possible (or at least feasible) to do with an interpreted, loosely-typed, object-oriented language. I think you're going to like it!

So, what are we to take away from this? All programming languages are exciting. Some are faster, others are more flexible. There is no linear scale that makes language X better than language Y; be smart and choose the best tool for the job.


[Elixir]: http://elixir-lang.org/
[Phoenix]: http://www.phoenixframework.org/
[Elm]: http://www.elm-lang.org/
[clicker game]: https://gist.github.com/hmans/6e8163cc35cab237fa65577b610dd78c
