---
layout: post
title: "Efficiency vs Effectiveness"
date_placeholder: 0
categories: Agility
---

In Swedish, “efficiency” and “effectiveness” are both translated into the same word. With Swedish being my mother tongue, this leads me to sometimes mixing these terms up. This article describes the difference between the two concepts, and why both are important to understand.
The influential author Peter Drucker defined the difference between being efficient and being effective in the following way in his management book The Effective Executive: The Definitive Guide to Getting the Right Things Done:

* Efficiency is to do things right.
* Effectiveness is to do the right thing.

Both aspects are important to be successful within the field of software engineering. Of course efficiency is important, for example by writing clean and maintainable code, by following coding guidelines and best practices, having a well-documented and scalable architecture et cetera. But equally important to keep in mind (and perhaps less obvious) is the concept of effectiveness. Again quoting Peter Drucker; “There is nothing so useless as doing efficiently that which should not be done at all.”

I believe it is frighteningly common in software projects to focus on efficiency and all but forgetting to be effective as well. Months or even years might be spent on perfecting some feature that the users never even asked for. So rather than always strive blindly to deliver perfect code, also remember to take a step back and make sure your team really are heading in the right direction. The agile toolkit contains a multitude of efficient tools fro increasing effectiveness. Some examples include rapid prototyping, gathering user feedback early and continuously, and 
You should also make sure to focus your efforts on building what you need right now instead of future-proofing your code in every imaginable way (the YAGNI principle) as well as never being afraid of throwing away code you don’t really need.

## Think outside the box
Some problems can even be solved without writing a single line of code! Imagine that you are building a system that needs to store sensitive user data. In order to comply with GDPR, you need to be prepared to remove all data about a user in case that person asks for it. You might be tempted to build a database cleaning tool and perhaps even an admin interface to go with it in order to be prepared for any such user requests. But maybe (and hopefully) you won’t get too many requests from unhappy users to delete all their data – in fact, you might not get any at all. In that case, it would be totally overkill to have a powerful admin tool for it. You will probably manage to take care of any such requests manually, at least initially. Only when and if that day arrives when you find that such user requests are recurring frequently enough for it to be a burden to handle them manually you should take action in order to automate that task.
So, paraphrasing Peter Drucker, do the right things right – and don’t do anything else.

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
