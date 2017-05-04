---
title: Adventures of an Ancient Web Developer in JavaScript Land
blurb: in which I finally bite the bullet and catch up on all the crazy things that have been going on in the JavaScript world.
---

My friends, terrible things are afoot: **I have been diving, no, delving into the wondrous world of JavaScript**. Yes, JavaScript, the language and ecosystem I have been tirelessly mocking for the last decade or two! Shocking, I know.

See, a while back [this blog post][ancient] was making the rounds. It threw the term "Ancient Web Developer" at me. **Imagine my rage!** I was not happy. After flipping some tables and probably insulting some random people on Twitter (I don't remember, but it happens), I returned to my computer, read the rest of the article, and had an epiphany:

**The author was right.**

**I totally _am_ an Ancient Web Developer.**

Shit.

See, I've been developing for the web since 1996. **That's a full two decades.** And for all this time, I have been advocating the _good old style_ of building web applications -- render HTML on the server, and use JavaScript for progressive enhancement -- while the rest of the web development world was getting high on React components, Redux stores and Webpack bundles.

I have been ridiculing many of the things happening in that community, seeing the extreme frequency at which new libraries replaced each other, and balking at the scary tendency to over-apply these hammers to the various nails people were working on.

It was time for me, the Ancient Web Developer who hadn't really changed the way he builds web applications in 20+ years, to find out what the JavaScript craze was all about.

**Spoiler alert:** I still believe the web development community has gone nuts, but some stuff I've found actually surprised me (positively, too.)


### You know what? React is actually fine

The big name that has been representing the JavaScript insanity to me is, expectedly, [React], "a JavaScript library for building user interfaces" coming straight from the bowels (ick) of Facebook.

I took it for a serious spin, and guess what, it's actually _quite alright_. I now understand that React, as a library, is actually fine -- it's just a tool like any other -- but many people do more things with it than it is advertised to do, and that's where things start to break apart.

React says it's a library "for building user interfaces", but really most React apps use it as the C _and_ the V. Just google for [smart and dumb components](https://www.google.de/search?q=smart+and+dumb+components) and be amazed at how decades of architecture learnings are casually dismissed by people who were still in grade school while software developers were figuring out that separation of logic and presentation is _actually a neat idea_. Argh.

It seems that the React community at large is agreeing that you should use [Redux] to manage the state of your React app. Dan Abramov himself, creator of Redux, published [You Might Not Need Redux](https://medium.com/@dan_abramov/you-might-not-need-redux-be46360cf367), a blog post that I can only imagine has been largely ignored by everyone and their dog, because everyone and their dog _are_ using Redux for even the most simple applications.

(I have this lingering suspicion that most people who use Redux don't actually do it for the state container, but rather for the convenient `<Provider>` component and `connect` function that will expose it to a full component tree. Can anyone confirm?)

All this, of course, is not React's fault. But coming from a [framework](http://rubyonrails.org/) whose primary credo is "convention over configuration", now faced with a stack that basically preaches "do whatever the heck your friends do, and if you don't have any friends, Facebook", my mind boggles with many of the things going on in the React world.



### The Virtual DOM is a dangerously short-sighted abstraction

Naturally, I didn't only want to use these new toys, **but also gain a better understanding of how they work**. I learned that React uses something called a Virtual DOM, so I set out to understand what that is all about.

React and similar libraries allow you to reason about your application's UI without having to worry about the statefulness of the browser's DOM. React components allow you to simply specify the HTML output you want to see, and it will take care of (mostly) everything.

So how does React actually render your UI to the DOM?

The naive approach would involve simply rebuilding the entire DOM every time something in your UI changes. Since forcing the browser to recompute the document structure and layout is relatively expensive, this would be pretty slow, so the key is to reuse as much of the existing DOM as possible.

**React and friends solve this by only changing the parts of the DOM that need to be changed.** This generally works in three steps:

- Your complete UI is rendered "virtually", which involves generating a data structure that represents its (full) new state;
- This data structure is then compared against the one representing the _previous_ UI state (or, in some cases, the existing DOM structure);
- Any differences are then applied to the actual DOM.

(For further reading, I recommend [this series of Medium posts about building your own Virtual DOM implementation from scratch](https://medium.com/@deathmood/how-to-write-your-own-virtual-dom-ee74acc13060). Yes, I built one, too. It's a fun exercise!)

This entire abstraction works fine until you clash with the _interesting_ bits the stateful browser DOM provides, like form inputs or `contenteditable` elements.

**A simple example:** imagine your user is currently editing the contents of a form input, and while they're doing so, you re-render your UI. Unless you or your library of choice have taken steps to solve this issue (eg. [Uncontrolled Components](https://facebook.github.io/react/docs/uncontrolled-components.html) in React), you may end up overwriting the changes the user has made so far, changing their current caret position, or worse.

And this is where things get complicated again. **Some solutions go to great lengths to reconstruct functionality that the browser provides for free.** One bizarre piece of code that I saw was storing the form input's caret position as part of its Redux-controlled state!

So, yes, the Virtual DOM enables you to reason about your UI in a way that certainly has some advantages over old-school DOM manipulation, but be aware that you're abstracting away one partially complex system with another that is at least _just as complex_. **The whole thing is certainly not going to come for free**, and you better keep this in mind.

[This post](http://futurice.com/blog/reactive-mvc-and-the-virtual-dom) specifically irked me with the following statement:

> A similar technique has existed in game development long before React: re-render the game screen in every game loop, but only update the minimum portion of the screen which changed compared to the previously rendered screen.

I'm sorry to say that this is an utter misunderstanding of how games actually work, and a very short-sighted comparison. Games do redraw their scenes from scratch on every frame, but they do this **with the help of hardware that is built for nothing but this very purpose**. The Virtual DOM approach, on the other hand, actively **fights its host platform**. Games also perform absolutely _no_ diffing against a previous state; I'm guessing the author is thinking of techniques like _culling_ (the process of figuring out the parts of your scene that don't need to be drawn at all.)

If you believe Virtual DOMs are great at rendering stuff at 60 FPS because that's how games do it, too, you're going to put yourself in a world of hurt.

Think of this the next time a [harmless looking web page causes 100% CPU usage on your computer][nvite].


### There are some great React alternatives

There's a surprising number of React alternatives out there, and I'm happy to report that many of them are actually quite good, some of them even great.

**[Vue] has been gaining a lot of traction**. I'm not a huge fan of some parts of its API, but it offers a somewhat friendlier (and flexible) developer experience than React. For reasons that even I am struggling to understand, I am particularly fond of its [single-file component syntax](https://vuejs.org/v2/guide/single-file-components.html). It's cute!

**My personal favourite has been [Inferno]**, which largely copies React's API, but offers significantly better performance. (Incidentally, Inferno is so much faster than React that [Facebook promptly hired its main author](https://twitter.com/trueadm/status/813313438759919616) so he could make React faster. I'm guessing that the upcoming [React Fiber] is largely his work, and I'm expecting it to be quite good.)

If you're interested in even more alternatives, [Stefan Krause's performance benchmark](https://github.com/krausest/js-framework-benchmark) ([current results](http://www.stefankrause.net/js-frameworks-benchmark5/webdriver-ts/table.html)) is probably a good starting point.


### Server-side rendering is returning in style

Of course server-side rendering never went away, and as I've stated previously, I have been and will remain to be a big fan. **It's great to just push the final document over the wire** (which, in almost all cases, will be _vastly_ faster than pushing code that will render it on the client), it's good for SEO, it's crucial for [allowing machines to parse your stuff](http://microformats.org/wiki/microformats-2) -- there are numerous advantages to doing things on the server as opposed to the client.

**Should everything be always server-rendered?** Probably not. There _is_ a very good case for client-side applications and UI, I'm not going to argue with that. But if your web application primarily serves _content_, **you're not doing yourself any favours by _not_ rendering it on the server.**

The JavaScript UI framework community seems to be aware of these points, which is why there has recently been a significant push towards rendering component-based applications on the server (google "[universal javascript apps](https://www.google.de/search?q=universal+javscript+apps)".)

It may sound like a joke at first -- React et al are specifically tailored for client-side UI rendering and updating, right? -- but it actually makes a lot of sense: write a bunch of components, use them on the server to render the initial page state, and then (optionally) push their code to the client so they can keep operating dynamically. Yeah, I dig that.

**It feels great for building sites "outside-in"**; instead of building your JSON APIs first, you start with the overall look and structure of your site. Maybe you even render it statically at first; or you deploy a simple Node-based server. At some point, your components may do some additional work on the client, requesting data from JSON APIs that you then add to the server application as needed.

It's very different from building a web application with a framework with Ruby on Rails, but that's totally okay!

[Next.js](https://github.com/zeit/next.js/) is a framework for server-rendered React apps, and it's really quite impressive. Most importantly, it **strips away most of the boilerplate** that is usually required to get a non-trivial JavaScript-based web project going; you install it, generate an application skeleton with it, and _things just work_, without enormous configuration files piling up to the point of suffocating you.

[Nuxt.js](https://nuxtjs.org/) is similar, but uses Vue instead of React, and offers an even nicer development experience. Among other niceties, **it's even able to generate a fully static version of your site**, with your components rendered out to actual HTML files, ready to be copied to your favourite static site hosting service.

This is some impressive stuff. If you like Rails for its kick-ass developer experience and have been avoiding the JavaScript pit because of the complexity of _even getting started_, give these two a go and you will see that there's actually some sanity to be found here.


### Serverless is fun

I didn't get the notion of "serverless" applications for a long time. If there are no servers, what do these apps talk to? It took way too long for me to understand that "serverless" **does not refer to the absence of servers, but simply you not having to set up and maintain your own**.

The aspect of serverless applications that intrigued me the most have been **cloud functions** (eg. [Amazon Lambda](https://aws.amazon.com/lambda/), [Firebase Cloud Functions](https://firebase.google.com/docs/functions/) or [Azure Functions](https://azure.microsoft.com/en-us/services/functions/).) Instead of writing a single monolithic server application that takes care of your entire backend functionality, you write compact, discrete functions that react on incoming HTTP requests or specific database events and operate and scale independently.

If you can stomach the inherent vendor lock-in, that's, like, really cool.

I'm particularly fond of Google's [Firebase], which offers a developer experience that I've given up on expecting from AWS. (I haven't tried Microsoft's Azure so far, but I've been hearing good things.)


### I still love CoffeeScript

**I love [CoffeeScript]. There, I said it.** In the eyes of many a JavaScript professional, this disqualifies me completely. I can live with that.

When I tell people that I tend to write all my JavaScript code in CoffeeScript, I very often hear that there is no point to CoffeeScript any longer now that ES6/ES2015/ES2016/ES2017/etc. are around.

I don't understand that argument. Yes, ES6 and its various other incarnations are great, but for me, they fail at something that CoffeeScript excels at: **enabling me to write succinct code that just _feels great_.**

"Code that _feels great_?" -- I know, this will disqualify me even more.

See, I know it's a very fuzzy thing to say, but if this wasn't important to me, I would just have kept using Java instead of spending most of the last 12 years [writing Ruby code](https://hmans.io/posts/2017/01/10/ruby-is-still-great.html). The Rubyists among you will understand.

Ultimately, I don't consider CoffeeScript to be some kind of alternative language that happens to compile to JavaScript, but rather _shorthand_ for it, similar to how Haml/Slim/Jade/Pug are shorthand for HTML or Sass is shorthand for CSS.

I also spent a couple of days trying [LiveScript](http://livescript.net/), which is a fork of a fork (of a fork... right?) of CoffeeScript that adds a whole bunch of features, some of them really cool; but ultimately the language felt too heavily loaded with _stuuuuff_. Also, CoffeeScript has a very clear future ([CoffeeScript 2](http://coffeescript.org/v2/), which compiles to ES2015+, is currently in beta), while the overall activity around LiveScript appears to be miniscule.

I'd also like to give [TypeScript](https://www.typescriptlang.org/) a try at some point. I'm not crazy about types, but I'm happy to find out what TypeScript does to my Javascripting. Considering it's pretty much the polar opposite of CoffeeScript, I'm not counting on it winning me over, though.

(I'd be cool with [Elm], though. But more on that in another post.)


### It's incredibly hard to keep up

One of the most difficult things for me the last couple of weeks was to actually **_cope_ with the amount of stuff I was sponging up**.

No matter which programming language popularity chart you look at, you will find JavaScript at or at least near the very top. The popularity margin it has over, say, good old Ruby, is absolutely staggering.

**And this shows; there is _so much stuff_!** No matter what you're looking for, you will likely be able to find a package for it on NPM. Probably more than one!

This also means that **there is a whole lot of refuse out there**; packages that are simply _bad_ or _broken_, or have been abandoned, deprecated, and/or superseded. This in itself is not a terrible thing -- no software project lives forever, and I myself am guilty of abandoning projects while they're still young -- but packages that should not be used for whatever reasons are rarely marked as such in any obvious manner.

This often leads to situations where you google for a specific tool, find something that looks just like what you need, start using it, and then you eventually find out that it has been put into maintenance mode (if at all) and there is now a successor project that you should be using instead. And to top things off, very often this successor project is an over-engineered, incomplete mess. Ouch.

Even if you find something that's great _and_ actively maintained, it's possible that by the time you get familiar with it, there will be a new hotness everybody is expected to adopt.

This, of course, is not sustainable. I'm hoping things will slowly settle down over the years while everyone is figuring out best practices and patterns. Yeah, I had to chuckle while writing that sentence, too.

[A tweet! By me! How quaint!](https://twitter.com/hmans/status/859768504932859905){:.embed}


### "Woah... I know JavaScript!"

The craziest and most surprising result from my time with all these new toys and tools is that **I am warming up to the idea of using JavaScript much more**.

I'm very late to the party, and some of my preferences will be at odds with the community at large, so maybe I can label myself as a _rogue_ JavaScript developer? Is that a thing? Pretty please?

Either way, I still believe many of the things that are going on in the JavaScript world are totally bonkers, but I now understand that there are some nuggets of greatness to be found.

**I have mostly made my peace with Node.js** (I was particularly happy to learn that it's trivial to use CoffeeScript with it), and could very well imagine using it for future experiments (a new variation on [Flutterby](http://www.flutterby.run/), perhaps?)

While still not the biggest fan of UI libraries like React, **I understand why they exist and respect what they're trying to do**, and look forward to seeing how things will develop for them over the years.

And I _totally_ want to build something with Firebase. It's so good.

----

**Update:** there has been some good follow-up discussion [over at Reddit](https://www.reddit.com/r/javascript/comments/697m97/adventures_of_an_ancient_web_developer_in/). Thanks for the many insightful comments! Also, feel free to shout at me on Twitter, where I'm [@hmans](https://twitter.com/hmans).





[ancient]: https://trackchanges.postlight.com/modern-javascript-for-ancient-web-developers-58e7cae050f9
[nvite]: https://twitter.com/hmans/status/855326944375652352


[React]: https://facebook.github.io/react/
[React Fiber]: https://github.com/acdlite/react-fiber-architecture
[Redux]: http://redux.js.org/
[Vue]: https://vuejs.org/
[Inferno]: https://infernojs.org/
[CoffeeScript]: http://coffeescript.org/
[Firebase]: https://firebase.google.com/
[Elm]: http://www.elm-lang.org/
