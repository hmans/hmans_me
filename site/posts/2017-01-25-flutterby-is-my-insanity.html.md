---
title: Flutterby Is My Insanity
---

**tl;dr** I've launched a [Flutterby website](http://www.flutterby.run) and released [Flutterby 0.6.0](https://github.com/hmans/flutterby/blob/master/CHANGES.md#060-2017-01-26). Also, I think the world has gone insane, and I'm very bad at writing release announcements.
{:.intro}

You know, I can be a pretty weird guy (as many of the people I have had the pleasure to work with in the past can probably confirm.) I take my work seriously (and I'd better, considering I'm a freelance provider of code and consulting); at the same time, I try (and preach) to _not_ take these things that we do _too_ seriously.

Yes, this is a bit of a paradox.

One of the ways I can be weird is how I build software, and what I use to build it. Judging by what many software developers out there would nowadays choose as their toolset of choice, my default stack is at best _boring_, or, depending on who you ask, _complete shit_. Check it out:

I use **Atom** for writing code, a code editor implemented in JavaScript that downloads as a 90 MB package and takes what feels like half a day to start up. Sometimes, it gets really slow for no apparent reason, and every now and then, it crashes completely. I _should_ be using Vim. But I'm not.

I build many of my web projects using **Ruby on Rails**, a framework that "everybody agrees"[^1] is slow, buggy, outdated, and promotes bad code practices (yes, all of these are things I've heard or read in the recent past.) According to popular development wisdom, I _should_ be using Elixir/Phoenix, or maybe Node.js. But I'm not.[^2]

Whenever I need to write JavaScript, I use **CoffeeScript** where I can, a language that literally makes serious JavaScript developers throw up, laugh, then throw up again, then laugh about having thrown up twice, and finally cry bitter tears of pity. I _should_ be using ES2015 or whatever with some sort of wacky build pipeline that only takes a day or five to set up. But I'm not.

See, the thing is that these tools may not be your cup of tea, but they're mine. They may not be the newest, fastest, shiniest, but I'm _familiar_ with them, and that makes me _fast_. Like, _really fast_. (Insert sales pitch here, eg. "hire me to find out just _how_ fast!!1")

And this is immensely valuable, much more so than using the latest shiny because your peers say so. This doesn't mean that there is no place for alternatives; Elixir, for example, is _fantastic_ for applications that need the power (or teams that prefer the functional approach to things.) Vim probably gives unholy superpowers to people who can fully command it. And JavaScript, well, JavaScript... I guess there's probably a reason why people are now building _everything_ with it. Some day I will learn what it is. Some day.

To cut an already too long story to short: I don't believe it matters that Rails copies instance variables from controller instances into a view object, a fact that makes "real developers" plea for mercy since they're still a bit shaken from the earlier torrent of vomit, laughter and tears.

I don't believe it matters that CoffeeScript doesn't follow "proper compiler design principles". If this is _really_ important to you, how do you feel about JavaScript in general?

I don't believe it matters that Atom takes a while to start up, at least it's being continually improved, with regular new builds, unlike _that other editor_, ahem.

This is my stack, and I am very good with it. Ruby is my favorite language. What's going on in the JavaScript world feels to me like complete and utter insanity. When I tried the otherwise excellent [Hugo] to build this website and found out that I need to set up my own JavaScript build pipeline just to compile some Sass to CSS, I gave up.

I gave up on all these new shinies. I gave up on a world that forces me to setup up things that are already obsolete once I'm done setting them up just to do something that works just fine out of the box in an integrated framework like Rails.

I wished for a world where the development world had stuck to at least a rough semblance of sanity. A world where people still enjoyed Ruby, this great language, even though it's neither statically typed nor as fast as JavaScript in V8. A world where good and simple solutions are valued higher than great, but complex ones.

A world where you can just put a `styles.css.scss` file into a directory and have it rendered to a `styles.css` in another.

If you also crave for this world, do give [Flutterby] a try; I'm convinced you'll enjoy it. I've just pushed version 0.6.0 of the gem and finally put up a website at [flutterby.run](http://www.flutterby.run/) (with [documentation](http://www.flutterby.run/docs/).) Enjoy!



[^1]: You'd be surprised by just how _many_ people seem to believe all these things.

[^2]: I am ramping up my Elixir efforts, though. Expect some bloggery soon!



[Hugo]: https://gohugo.io/
[Flutterby]: http://www.flutterby.run/
