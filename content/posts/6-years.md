---
categories:
  - Mindset
date: "2022-06-22T00:00:01Z"
title: Learnings from working 6 years as a Software Engineer
slug: "sofware-engineer"
featured: true
---

By now I have studied software engineering at university for 6 years and then worked professionally within the field for another 6 years. During this time I have picked up a few patterns, methodologies and assorted tips & tricks that I would like to share with everyone. Hopefully you'll learn something, and please let me know if you disagree with anything. There are always different aspects of every topics and I would love to hear your thoughts about it!

## Programming vs Software Engineering

Before we begin, we need to get one thing straight. You might imagine that a programmer and a software engineer is two different words describing the same role. While the two might ostensibly work on the same things &mdash; writing software &mdash; the methodology they follow while doing so are actually drastically different. A programmer can be anybody writing software. They can be self-learned or educated, but their methodology is usually ad-hoc at best and non-existent at worst. A software engineer, on the other hand, follows a strict and systematic approach to her work. An engineer needs to be disciplined, adaptable, and a master at problem solving. Therefore the engineer usually have a formal education where they learned how to write, read, and learn professionally, and then they have put that knowledge into use at work in order to learn even more. 

## Big list of learnings

- **There are no silver bullets.** The first thing you need to know is that there will never exist any solution that can be applied with equal success to all problems. Yes, that includes everything on this list as well. Take every new and shiny thing you hear about with a grain of salt. Always consider the downsides as well as the upsides. Every decision is a tradeoff, and the tradeoff that is right for you might be wrong for someone else. Fred Brooks has written a famous paper on this topic, that is also included in many editions of his book The book *The Pragmatic Programmer*.

- **"Beware paths which narrow future possibilities"** [quote taken from *Children of Dune* by Frank Herbert]. Not sure what is the right tradeoff in your case? Choose the path which keeps the most doors open. Always postpone architectural decisions until the last possible moment (but no further).

- **Be proactive.** [Practice disaster scenarios](../practice-disaster-scenarios). Write useful documentation and README files. Write proper commit messages (specifying why you did the change, not what or how). [Refactor often and early](../Refactor-Responsibly). Stick to the [last week mindset](../last-week-mindset). In short, try to be nice to your future self (or the person taking over after you). 

- **Work together with others.** [Efficient and effective](../efficiency-vs-effectiveness) software engineering is a team effort. Divide & conquer is the most basic method of cooperation, there are other methods that are significantly more effective. Personally I am big fan of pair programming and mob programming.

- **Always keep on learning.** "The higher a mind's development, the more it discovers in the universe to occupy it." [quote taken from *Last and First Men* by Olaf Stapledon]

- **Rely heavily on automation.** Computers are reliable and very good at repeating the same task over and over again without deviations. Computers don't forget and they don't make stupid mistakes. Leverage this and automate as many tasks as possible. Manual steps are hard to repeat in the exact same manner every time, and also requires specific knowledge that might be forgotten or lost when a team member leaves.

- **Architecture matters.** Good architecture enables you to increase velocity by adding more manpower. Bad architecture will slow you down when your team grows. Good architecture can only be attainted by making sure any given change can be kept to one isolated corner of the codebase.

- **Leave nothing to chance**. Make sure to "control your territory". By that I mean that you should have full knowledge about the inner workings of all components that you are responsible for. You should also learn as much as you can about the environment or ecosystem in which your component(s) have to exist. Don't simply accept the fact that something is working, you have to understand how and why it is working, so that you can fix it *when* it breaks down. If your knowledge map has a blind spot, you have to shine a light upon that dark place.

*And finally...*

- **Be proud of your work**. Think of yourself as a craftsman, not a line worker. Have a [strong sense of integrity](../The-Ethics-of-Software-Engineering). Take ownership. Accept responsibility when something breaks down and be proud when it's working. Don't work with clients that "can't afford" quality. They can hire a programmer for that!
