---
title: "What are some use cases where Elixir/Phoenix is more advantageous than Ruby/Rails?"
blurb: in which I answer a question on Quora about Elixir and Phoenix, with a bit of a Rails-related rant to spice things up a notch.
---

Original [question from Quora](https://www.quora.com/What-are-some-use-cases-where-Elixir-Phoenix-is-more-advantageous-than-Ruby-Rails/answer/Hendrik-Mans):

> What are some use cases where Elixir/Phoenix is more advantageous than Ruby/Rails?

Hi! I've been working with Ruby and Ruby on Rails for 12 years, and with Elixir and Phoenix for around 2 years, and I am here to answer your question to the best of my ability.

First of all, I need to address that [answer](https://www.quora.com/What-are-some-use-cases-where-Elixir-Phoenix-is-more-advantageous-than-Ruby-Rails/answer/Tim-Mensch) previously posted by someone else that claims Ruby on Rails can't scale, and you should be using Elixir "if your app needs to scale".

That is simply very, very shortsighted advice, and it makes its author look like he does not really understand the concept of scaling. Even though Ruby is not the fastest language around, it's actually *trivial* to scale a typical Rails application. Rails applications typically have a "share nothing" architecture that, most of the time, allows you to simply add more servers to increase the overall number of requests that your app can process per second.

It's probably not the *cheaper* platform to scale (in terms of hardware required), but scale it will!

Now, back to your question.

You asked about use cases, and it's a great question, because there definitely *is* stuff that is easier to model (and, yes, scale) with Elixir and Phoenix than it is with Ruby on Rails. Here's some stuff I could think of off the top of my head:

**Applications with a real-time channel** (eg. Websockets; for example, chat apps) are a great fit, because Phoenix makes them almost trivial to build. It's possible to build these with Rails, too, but ActionCable --- the Rails component that serves Websocket connections --- will have a harder time taking this beyond the first thousand or so simultaneous connections. To give you an idea of how much better a fit Elixir and Phoenix are for this stuff: an app built with them will happily serve the first couple of hundred thousand (!) simultaneous connections *from a single server*. (Note, though, that you typically won't be getting this many simultaneous connections unless you're Slack or WhatsApp.)

**Applications that do large amounts of background processing** are a great fit, because Elixir just lets you spawn a new process (which, in the wonderful world of Erlang, behaves more like a *thread*, while it's really neither) to perform a task, while in Ruby you will, in most cases, want to move your background jobs to a separate processing stack (eg. Sidekiq) that you scale independently from your web application.

**Applications that perform real-time state updates** (eg. multiplayer game servers that apply constant updates to the game world) are a great fit, because this stuff is almost comically easy to build and scale across multiple machines in Elixir, while it's nigh impossible to do so in Ruby.

There are probably more.

On the topic of Elixir vs. Rails, you need to take note that all of these are very far removed from the original use case that Rails was designed for, and certainly don't invalidate it in any fashion.

Elixir and Phoenix will, of course, also let you build normal, "boring" CRUD apps, and if your organization *wants* to do Elixir for whatever reason (functional programming, the new car smell, you can only afford a single server, ...), do go ahead and use it for that stuff, too. It's great!

But please don't believe the FUD around Rails "not scaling", and especially do not force your organization's Rails engineers to learn Elixir (which has a pretty steep learning curve) just because someone on the Internet told you it's the only way your app will scale.
