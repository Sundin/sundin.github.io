---
layout: post
title: "The Last Week Mindset"
dddd: a date will be inserted here by the ./publish-post.sh script
categories: 
---

Being a consultant, I'm quite used to switching projects and thus have had a bit of practice in handing off a project to other developers. This has led me to a range of conslusions that I think can benefit every serious software engineer, consultant or not. I would like to summarize these findings into the "last week mindset", or; if this was your last week on your current assignment, how would you spend that week?

Your answer to that question would probably include most of the following tasks:
* Transfer knowledge within the team.
* Document some architectural knowledge about the code you have been working on. 
* Update wikis and readmes to enable others to pick up from where you left.
* Finish any work in progress items you are currently working on.

Put like this, we clearly see that these are things we would find valuable in any situation, regardless of if you are leaving the project within the near future or not. In order to have a _long term mindset_ we should therefore embrace the _last week mindset_ already from the first day on a new assignment.

Here are some practical recommendations:

* [Automate early](http://www.developerdotstar.com/mag/articles/automate_software_process.html). Do people ask you to do something on a regular basis? Automate it or make a script they can run for themselves. This will also act as documentation for how certain tasks are to be carried out and therefore make sure that you are not the only one in your team that know how that certain task works.
* [Write documentation on a regular basis](https://www.writethedocs.org/guide/writing/beginners-guide-to-docs/). At a minimum it should cover high-level architectural decisions, including [the rationale behind those decisions](https://blog.doismellburning.co.uk/document-all-the-things/#How.to.create.good.documentation.).
* Don't like writing documentation? Then automatically generate it instead! Some tools that might come in handy are [Graphviz](https://graphviz.org/) and [Doxygen](https://www.stack.nl/~dimitri/doxygen/).
* Transfer knowledge within the team. [Write down questions you receive and compile them into a FAQ](https://blog.doismellburning.co.uk/questions-are-documentation-bugs/). In this way you have automated the process of having to answer the same questions over and over again.
* Write [clean code](https://www.martinfowler.com/tags/clean%20code.html), avoid ugly hacks and unnecessary workarounds. No one likes to be handed a messy ball of mud. This said, it is still of highest importantance to actually [make things work](https://tomharrisonjr.com/make-it-work-make-it-beautiful-make-it-fast-three-realities-df7255a8fa09).
* Combine the two points above (clean code + make stuff work): do not have a lot of work in progress. Work on one thing at a time. Finish what you are working on and tidy it up before moving on to the next thing. This will increase productivity both in the mid- and long term.

Some people might argue that that following the above advice will make them replace and therefore increasing the risk of them loosing their job. I would argue quite the opposite – doing the above will actually make you more valuable to your employers since you will in fact deliver more value than you would do otherwise. In that case, being "replace" should be something to strive for, nothing to be afraid of.

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
