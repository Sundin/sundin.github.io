---
layout: post
title: "Testing: Best Practices"
date_placeholder: 0
categories: Testing
---


In this post I will describe a number of best practices I find useful to keep in mind when writing tests. It is intended to act as a complement to my previous post, [A successful testing strategy]({{ site.baseurl }}{% post_url 2019-06-26-a-successful-testing-strategy %}).

## QA Ownership
The team owning the functionality should also own the entire test stack testing that functionality. That also means that there should be no separate QA/testing role within the organization. And it should absolutely not be a separate team wihtin the organization taking care of QA! Building software is a team effort and it is crucial that automated tests is considered a first-class citizen of your development process, as opposed to something that is half-heartedly latched on retrospectively after the code has already been written.

## What to Test
All functionality owned by the team needs to be tested, but also interfaces that are consumed or exposed by services belonging to other teams.

## The Scope of a Single Test
A test should cover a minimal possible use case only. Huge tests that tries to cover a large number of outcomes should be avoided. This approach might lead you to having to write a larger number of tests, but in return you will be able to pinpoint the problem if a test fails much easier.

## Data Ownership
Tests should not be dependent on the same data as another test. This is because if one of the tests manipulates the shared data in some way, it will probably screw up for the other tests using that data. That would mean that the test suite could give different results depending on the order in which the individual tests were executed. Instead, each test preferrably needs to be responsible for initializing its own set of data to use.

## Code coverage
> "100% code coverage tells you nothing, but less than 100% code coverage tells you something."  
    – Unknown

Aiming for covering 100% of your code with tests is probably not realistic and perhaps not very useful neither. I usually start by just writing one or two unit tests for each of my functions; one that tests some basic use case for the function and often another test that just calls the function with empty parameters. I tend to think that these two cases covers many of the potential bugs (by testing both the normal flow and an easy corner case) in the function with a minimal time investment in writing tests. More advanced tests can be added over time as deemed necessary (see the section on Recurring Bugs).

Without being too stricct about code coverage, it is usually still a good idea to have some kind of code coverage check in your build pipeline. I usually find out what the current code coverage ratio is in the project, and then set that value as the minimum threshold in the pipeline. The idea here is mainly to make sure that new code that gets written is covered by unit tests, since the code coverage ratio would otherwise go below the threshold. Therefore you should strive at continuously increasing this threshold as your coverage ratio grows over time. Just be aware that deleting code (which always is a good thing) might actually decrease your code coverage percentage, so be prepared to lower the threshold in those cases.

## Recurring Bugs
Bugs happen. Live with it. But a bug should, never ever appear again after being fixed in the past. Therefore, if you find a bug in production, write a test that captures it. A bug found in production means that you have a bug not only in your codebase, but also in your test suite since it allowed the bug to slink through.

## Time
Always mock time (current date, timezone etc.) in order to be able to redproduce the same test results if running them again on a different date or from a different location.

## Non-verbosity
Tests should be non-verbose and only print to the log if something unexpected happened.



---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
