---
title: SPACERAGE!
blurb: in which I write about a dumb little HTML5 space game I've built to catch up with the world of HTML5 game development.
---

The last couple of weeks I've been working on [SPACERAGE], a dumb little 2D space shooter powered by HTML5. It's not a serious attempt at making a game, but rather an excuse to brush up on frontend development and get up to speed with Canvas/WebGL/web audio. The source is [available on GitHub](https://github.com/hmans/spacerage). Please don't mock me.

And yes, I made the game's music myself. My computer came with some free music software. Don't give me music software, ever. [Bad things will happen](https://soundcloud.com/hmans) when you do.

I'd like to blog about some things that I learned, and I'm going to do it in three parts that I will link to here once they're online:

- **Part 1 (you're looking at it): Technologies Used**
- Part 2: Pixi.js Tidbits
- Part 3: Writing HTLM5 Game Code


### HTML5 game development is awesome!

Sure, HTML5 is not going to give you the kind of performance you'll get from native code, but it's still _really good_ (and easily good enough for building smooth 2D games.) WebGL specifically is very impressive, with [increasingly wide support](http://caniuse.com/#search=webgl), and libraries like [Pixi.js] making it almost trivial to use.

Developing a game "in the browser" means being able to iterate incredibly fast, and to ship early versions to interested testers just by sending them a URL they can open in their browsers. And thanks to projects/products like [Apache Cordova](https://cordova.apache.org/) or [Cocoon], you can still ship the finished games as stand-alone mobile apps. Cocoon specifically is very impressive; now a cloud-based service, you can just upload your files (or point it at your game's URL), and it will spit out readily compiled iOS and Android packages that you can upload to the stores. This stuff has come a long way.

I also used the opportunity to catch up on [Progressive Web Apps](https://developers.google.com/web/progressive-web-apps/) ("PWA"), an emerging set of concepts and pseudo-standards driven by Google that, when implemented, allow your web-based application to act and feel more like a native app. SPACERAGE has a PWA manifest, allowing visitors to "install it as a web app" (yes, that is the awkward wording) from within Android Chrome. While generally interesting and easy to set up, I was disappointed to learn that fullscreen mode, my primary motivation to go PWA, [is not supported yet](https://twitter.com/ChromiumDev/status/822069102017675268). When playing SPACERAGE as a PWA on Android, you still awkwardly see the operating system's status and navigation bars. I'm sure this will improve over time, but today, PWAs will not save you from wrapping your web apps in native components like we've been doing for the last couple of years.


### CoffeeScript is lovely... if your brain works like mine

After a short-lived attempt at building the game with ES6, I eventually switched to [CoffeeScript]. There is nothing terribly wrong with ES6; it definitely is the version of JavaScript that we _should_ all be using. However, I consider CoffeeScript to simply be more fun to work with. When writing CoffeeScript, I'm getting very similar vibes to when I'm writing Ruby, and to me, that's a good thing.

You may be thinking that CoffeeScript's `@` shortcut for `this` is useless syntactic icing, but it's one of the things that make CoffeeScript so great for me. In JavaScript, it's `this` here and `this` there, it's `this` all over the place, and `@` minimizes that noise to a large extent. Call me shallow, but if ES6 had something comparable, I would probably make a more serious effort to use it.

I'm also really digging [Literate CoffeeScript](http://coffeescript.org/#literate), a variant of the language that is pure Markdown. Using it, your scripts become your documentation -- look at my game's [Util module](https://github.com/hmans/spacerage/blob/d646dc192de2962d37a76148e1f81dcb36bc7daf/app/util.litcoffee) for an example. That link is not a separate piece of documentation, it is the _actual script_ -- check out the source [here](https://raw.githubusercontent.com/hmans/spacerage/d646dc192de2962d37a76148e1f81dcb36bc7daf/app/util.litcoffee). That's just really cool, _especially_ when writing code for educational purposes.


### Pixi.js

The go-to framework for building HTML5 games these days appears to be good old [Phaser]. If you're starting out with game development and need a framework that does pretty much all of the heavy lifting, give it a try, it really is fantastic!

For my game, however, I chose not to use it. There are two very simple reasons for this: first, I wanted to learn more about the technologies behind frameworks like Phaser; second, SPACERAGE, simple as it is, actually has some design aspects that conflict with certain constraints established by Phaser (specifically, unlimited-size worlds with a rotating camera are simply something that Phaser is not designed for.)

So, I went with [Pixi.js], which happens to be the same rendering engine that Phaser uses, and eventually added [Howler](https://github.com/goldfire/howler.js) for audio, [Keymaster](https://github.com/madrobby/keymaster) for keyboard input, and [Tween.js](https://github.com/tweenjs/tween.js/) for tweening and lerping[^1].

Pixi essentially gives you a very high-level interface at a scene graph, a tree of display objects that will be rendered using WebGL, when available, or Canvas as fallback. At least as long as you're not terribly concerned with optimization, building a game (or anything that needs fast animated 2D graphics) with Pixi essentially amounts to loading images and setting up actors on your stage that use them.

Learning how to use Pixi was a bit of an adventure, since the available documentation unfortunately isn't all that great, but more on that in Part 2 of this blog series.

Generally speaking, glueing the afore-mentioned libraries together went much more smoothly than I anticipated; I never really missed the comforts that Phaser provides, and while I will keep recommending Phaser, I'm pretty sure that I will keep "rolling my own" in future game projects (if there are any.)


### What's next?

I will write about some specific things I learned about Pixi.js and HTML5 game development in general in upcoming parts 2 and 3 of this blog series. Stay tuned!



[^1]: "Inbetweening" and "Linear Interpolation". Look it up! ;)

[SPACERAGE]: https://spacerage.hmans.io
[Pixi.js]: http://www.pixijs.com/
[Cocoon]: https://cocoon.io/
[CoffeeScript]: http://coffeescript.org/
[Phaser]: https://phaser.io/
