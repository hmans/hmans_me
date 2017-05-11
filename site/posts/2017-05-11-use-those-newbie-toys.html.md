---
title: Find Those Newbie Toys and Use Them
blurb: in which I advise against exclusively following popular consensus within programming communities and once again embarrass myself by publicly admitting my affection for CoffeeScript.
---

**Find out which tools are generally decried by a community as "toys for newbies", or otherwise obsolete, and use those, because they will often make you faster.** Some examples:

**Ruby on Rails**: oh boy, the Rails hate is strong these days, and while pretty much the entirety of the supposedly "modern" web development community agrees that the reign of Rails (or Ruby) is long over, many, many people all over the planet are happily whipping up one Rails app after another. It's not as hip as your latest Webpack-powered, isomorphic React monstrosity with Redux and PostCSS written in ES2017 (did I miss anything?), it's not as awe-inspiring as Elixir/Phoenix if extreme concurrency is what you need, and it's certainly not winning any performance benchmarks overall, but in the time you're done reading the latest Medium post on what technology you should be using to be considered a "modern" web application developer, you will have built a complete app with Rails, and it will be a perfectly fine one, too.

**PHP**: yup, good old PHP. Ha, didn't expect that, did you! Am I PHP's greatest fan? Not by any measure, but I _am_ perfectly aware that it quickly gets many people where they need to be, probably more than ever before. You don't have to be a fan of the language to understand that PHP still has unparalleled ease of deployment and an extremely low barrier of entry, so yeah, it's still a solid choice for building stuff on the web.

**CoffeeScript**: [CoffeeScript] makes JavaScript shorter and easier to work with, so naturally, JavaScript programmers everywhere _loathe_ it. It reduces the language to a very concise syntax that would be very hard to shorten further without entering glyph hell (and if that is what you want, maybe give [LiveScript] a try.) "Serious" JavaScript programmers will tell you to just use ES2015+ "because it's the future", but at the same time will happily shorten HTML with Jade/Pug, CSS with [SugarSS](https://github.com/postcss/sugarss), and more. (Incidentally, nobody seems to take any issue with people using [TypeScript], a language that is much farther removed from JavaScript in terms of features added than CoffeeScript. Whodathunk.)

There are probably more examples out there.

**The mind of a programmer thrives on solving problems**, so the natural enemy of the same mind is _problems that have been solved_, because solved problems are _boring_. All of the tools mentioned above have successfully solved a specific problem. None of them solve _all_ problems, yet people publicly decrying them very often do so because they didn't solve the problem _they_ were having at the time, very often something that these tools were not intended to solve.

"Rails sucks!" because it's hard to build highly concurrent real-time applications that scale with it. Well, you know, Rails was made in an effort to bring back sanity to the world of building request-response based CRUD apps, and it did so with thundering success. Highly concurrent real-time apps are a relatively young problem that Rails certainly is not the solution for, but that doesn't devalue all the other great things it does.

"PHP sucks!" because the language has historically evolved from one strange mess into another. But it was never intended to be a full programming language, and it's a tremendously respectable feat that it eventually turned into one, even if you're not a fan.

"CoffeeScript sucks!" because it adds its own little syntactic bells and whistles that apparently no true JavaScript developer wants to learn because they can already write perfectly good ES2015+, thank you very much; a truly mind-boggling sentiment coming from a community that has embraced transpiling different syntaxes into the very core of everything they do.

As a developer, at some point you will need to drop your addiction to new and shiny, and just use mature tools that work, even if they bore you. Maybe you can find some excitement in simply being done faster than everybody else.

[Downvote me on Twitter](https://twitter.com/hmans/status/862674285441286144).


[TypeScript]: https://www.typescriptlang.org/
[LiveScript]:  http://livescript.net/
[CoffeeScript]: http://coffeescript.org/
