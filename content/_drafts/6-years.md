---
categories:
  - Tutorial
  - Implementation
  - "Sound Realms: Mace & Magic"
tags:
  - Flutter
date: "2022-04-11T00:00:00Z"
title: Building a Custom Dialog in Flutter
slug: "flutter-custom-dialog"
draft: true
---

Beware paths which narrow future possibilities
Children of Dune

There are no silver bullets.
Pragmattic programmer


Control your territory
Shine light upon dark places
Refactor often and early
Zero bug policy
Don't work with clients that "can't afford" quality. They can hire a programmer for that!


Take ownership

Expectation management 

Prognosis vs estimates vs prioritization 


Work together with others. Divide & conquer is the most basic method of cooperative, there are other methods that are significantly more effective.


Be proactive. Practice disaster scenarios. Be nice to your future self. 
Have a good readme file. Getting started + high level architecture + references for future reading.
Write proper commit messages (specifying why, not how).

Make sure you have proper access, but no more. Have the same access level in staging and prod.

Rely heavily on automation. 
TEsts, alarms, IaC, CI/CD pipelines.

Project vs product mindset


Architecture matters.
Good architecture enables you to increase velocity by adding more manpower. 
Good architecture can only be attainted by making sure any given change can be kept to one isolated corner of the codebase. A word of caution to avoid misunderstandings here. While MVC is an example of a sound architectural pattern, structuring your code into M,V and C folders is not! Any given change would require you to make changes to all 3 folders, thus violating the principle of isolated changes. Rather you should structure your code according t ofunctionality (so that the checkout feature getting its own folder containing all its M V C files).
This prevents bloating any part of the code with completely unrelated rubbish. Such a structure will also incentivice the natural emergence of a micro service architecture.

"The higher a mind's development, the more it discovers in the universe to occupy it." - Last and first men, Olaf Stapledon
