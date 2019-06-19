---
layout: post
title: "Testing: Best Practices"
date_placeholder: 0
categories: 
---


In this post I will describe a number of best practices I find useful to keep in mind when writing tests.

## Ownership and Scope
The team owning the functionality should also own the entire test stack testing that functionality. That means no separate QA/testing role or team within the organization. Building software is a team effort and it is crucial that automated tests is considered a first-class citizen of your development process, as opposed to something that is half-heartedly latched on retrospectively after the code has already been written.

All functionality owned by the team needs to be tested, but also interfaces that are consumed or exposed by services belonging to other teams.

## Code coverage
> "100% code coverage tells you nothing, but less than 100% code coverage tells you something." – Unknown
Aiming for covering 100% of your code with tests is probably not realistic and perhaps not very useful neither. I usually start by just writing two unit tests for each of my functions; one that tests some basic use case for the function and another test that calls the function with empty parameters. I tend to think that these two cases covers most of the potential bugs in the function with a minimal time investment in writing tests.

However, it is usally a good idea to have some kind of code coverage check in your build pipeline. I usually find out what the current code coverage ratio is in the project, and then set that value as the minimum threshold in the pipeline. The idea here is mainly to make sure that new code that gets written is covered by unit tests, since the code coverage ratio would otherwise go below the threshold. Therefore you should strive at continuously increasing this threshold as your coverage ratio grows over time.

## Other guidelines

* If you find a bug, write a test that captures it.
* Always mock time (current date, etc.) to reduce flakiness.
* New features always covered with unit tests. Other tests if needed.
* All tests should test the minimal possible functionality.
  To be avoided: huge test that covers many outcomes.
* Each test should own its data. For example, insert/delete Docker database rows.
* Tests should be non-verbose and only print to the log if something unexpected happened.

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
