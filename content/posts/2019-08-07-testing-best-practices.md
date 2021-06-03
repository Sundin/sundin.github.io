---
categories:
  - Testing
date: "2019-08-07T00:00:00Z"
title: "Testing: Best Practices"
slug: testing-best-practices
---

In this post I will describe a number of best practices I find useful to keep in mind when writing tests. It is intended to act as a complement to my previous post, [A successful testing strategy](../successful-testing-strategy).

## Code coverage

> "100% code coverage tells you nothing, but less than 100% code coverage tells you something." – Unknown

Aiming for covering 100% of your code with tests is probably not realistic and [perhaps not very useful neither](https://jeroenmols.com/blog/2017/11/28/coveragproblem/). I usually start by just writing one or two unit tests for each of my functions; one that tests some basic use case for the function and often another test that just calls the function with empty parameters. I tend to think that these two cases cover a large fraction of any potential bugs (by testing both the normal flow and an easy corner case) in the function with a minimal time investment in writing these tests. More advanced tests can be added over time as deemed necessary (see also the section on Recurring Bugs).

Without being overly concerned about your code coverage ratio, it is usually still a good idea to have some kind of code coverage check in the build pipeline. I usually find out what the current code coverage ratio is in the project, and then set that value as the minimum threshold in the pipeline. The idea here is mainly to make sure that new code that gets written is covered by unit tests, since the code coverage ratio would otherwise go below the minimum threshold. To keep the threshold check useful, you should strive at continuously increasing the threshold as your coverage ratio grows over time. Just be aware that deleting code (which always is a good thing!) might actually decrease your code coverage percentage, so be prepared to lower the threshold when that happens.

## Recurring Bugs

Bugs happen. Live with it. But a bug should, never ever return after having been fixed before. Therefore, if you find a bug in production, [write a test that captures it](http://www.extremeprogramming.org/rules/bugs.html). A bug found in production means that you have a bug not only in your codebase, but also in your test suite since it allowed the bug to slink through.

## QA Ownership

The team owning the functionality should also own the entire test stack testing that functionality. This also implies that there is no need for a separate QA (Quality Assurance)/testing team within the organization. Likewise, having a separate tester role within the team should also be considered an organizational anti-pattern. Building software is a team effort and it is crucial that automated tests is considered a first-class citizen of your development process, as opposed to something that is half-heartedly latched on retrospectively after the code has already been written.

## What to Test

All functionality owned by the team needs to be tested, but also interfaces that are consumed or exposed by services belonging to other teams.

## The Scope of a Single Test

Each test should only cover a minimal possible use case. Huge tests that tries to cover a large number of outcomes should be avoided. This approach might lead you to having to write a larger number of tests, but in return you will much easier be able to pinpoint the problem if a test fails.

## Data Ownership

Tests should not be dependent on the same data as another test. This is because if one of the tests manipulates the shared data in some way, it will probably screw up for everyone else using the same data. That would mean that the test suite could give different results depending on the order in which the individual tests were executed, which is [not a good thing](https://www.martinfowler.com/articles/nonDeterminism.html). Instead, each test preferably needs to be responsible for initializing its own set of data to use.

## Time

Always mock time (current date, timezone etc.) in order to be able to redproduce the same test results if running them again on a different date or from a different location.

## Non-verbosity

Tests should be non-verbose and only print to the log if something unexpected happened. This will both make things easier to debug and make anything that is out of the ordinary draw your attention.
