---
categories:
  - Agility
  - Mindset
date: "2018-10-31T13:05:15Z"
title: Efficiency vs Effectiveness
---

In Swedish, "efficiency" and "effectiveness" are both translated into the same word. With Swedish being my mother tongue, this leads me to sometimes mixing these terms up. This article describes the difference between the two concepts, and why both are important to understand.

The influential author [Peter Drucker](https://en.wikipedia.org/wiki/Peter_Drucker) defined the difference between being efficient and being effective in the following way in his management book _[The Effective Executive: The Definitive Guide to Getting the Right Things Done](https://www.goodreads.com/book/show/48019.The_Effective_Executive)_:

- Efficiency is to do things right.
- Effectiveness is to do the right thing.

Both aspects are important to be successful within the field of software engineering. Of course efficiency is important, for example by writing clean and maintainable code, by following coding guidelines and best practices, having a well-documented and scalable architecture et cetera. But equally important to keep in mind (and perhaps less obvious) is the concept of effectiveness. Again quoting Peter Drucker; "There is nothing so useless as doing efficiently that which should not be done at all."

I believe it is frighteningly common in software projects to focus on efficiency and all but forgetting to be effective as well. Months or even years might be spent on perfecting some feature that the users never even asked for. So rather than always striving just to deliver perfect code, also remember to take a step back and make sure your team is really heading in the right direction.

The agile toolkit contains a multitude of efficient tools for increasing effectiveness. Some examples include [rapid prototyping](https://www.developer.com/design/the-need-for-rapid-prototyping-in-an-agile-age.html), gathering user feedback early and continuously, and the principles of the original [Agile Manifesto](http://agilemanifesto.org/principles.html).

You should also make sure to focus your efforts on building what you need right now instead of future-proofing your code in every imaginable way (the [YAGNI principle](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it)) as well as never being afraid of throwing away code you don’t really need.

## Think outside the box

Some problems can even be solved without writing a single line of code! Imagine that you are building a system that needs to store sensitive user data. In order to comply with [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation), you need to be prepared to remove all data about a user in case that person demands it. You might be tempted to build a database cleaning tool and perhaps even an admin interface to go with it in order to be prepared for any such user requests. But maybe (and hopefully) you won’t get too many requests from unhappy users to delete all their data – in fact, you might not get any at all. In that case, it would be totally overkill to have a powerful admin tool for it. You will probably manage to take care of any such requests manually, at least initially. Only if and when that day arrives when you find that such user requests are recurring frequently enough for it to be a burden to handle them manually you should take action in order to automate the process.

Don't fall into the trap of optimizing your current solution when you could reap a reward that is several orders of magnitude larger by simply thinking outside the box.

So, paraphrasing Peter Drucker, do the right things right – and don’t do anything else.
