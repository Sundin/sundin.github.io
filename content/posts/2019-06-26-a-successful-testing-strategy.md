---
categories:
  - Testing
date: "2019-06-26T13:00:07Z"
title: A Successful Testing Strategy
---

Today we will a closer look at the classic [testing pyramid](https://www.mountaingoatsoftware.com/blog/the-forgotten-layer-of-the-test-automation-pyramid) and see how we can transform that into a concrete strategy for how to write your tests. While the terminology I use is not exactly the same as the one used by [Mike Cohn](https://en.wikipedia.org/wiki/Mike_Cohn) when he first described the testing pyramid in his book [Succeeding with Agile](https://www.mountaingoatsoftware.com/books/succeeding-with-agile-software-development-using-scrum), the core concepts remain the same – a strong foundation of unit tests, complemented with a sufficient number of component tests (which are similar to Cohn's service tests) and sprinkled with a few end-to-end tests (which are called UI tests by Cohn) as a last line of defense.

## Different types of tests

The concepts thrown around when talking about abouted testing can sometimes be overlapping and confusing, so it can be useful to come up with a shared definition to use within your team. Below I will share the terminology that I prefer to use, but feel free to disagree as there is no real consensus within the industry around this concepts.

### Unit tests

Unit tests are the lowest level of testing. Here you should strive to do the heavy working and catch as many problems as possible: syntax errors, logical bugs, corner cases, malformed input, broken UI etc. The reason why you should spend so much focus on writing unit tests is that unit tests are easy to write and fast to execute, meaning that you get near immmediate feedback as you develop the application. Ideally, your unit test suite should run on every code change and therefore it has to be really fast. You should aim at testing as small parts of the code as possible with each unit test so that you easily can locate where the problem is in case a test fails. In order to achieve this, unit testing will have to rely heavily on techniques such as [mocking](http://wiki.c2.com/?MockObject) and [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection).

Some examples of different kinds of unit tests:

- Backend logic tests with a mocked database.
- Frontend logic tests, in particular business logic and commonly used helper/utility functions.
- [Snapshot tests](https://jestjs.io/docs/en/snapshot-testing) in order to catch UI regressions.

### Component tests

In order to test an entire component in isolation to all other components, we use something called component tests. You have to decide for yourself what your definition of a component should be, but in a microservice architecture each individual service will typically be considered its own component. Dependencies to other components should normally be mocked. The rationale for component tests is to verify that the component as a whole works as expected, without caring about its internal implementation details (as opposed to the unit tests, which according to my experience are usually more closely coupled with implemention details). Component tests should therefore have to change less frequently than the unit tests. Compared to end-to-end tests, contract tests will pinpoint errors at a more specific level and also usually be more reproducable as network flakiness will normally be mocked away.

Some examples of different kinds of component tests:

- Backend tests for a microservice using an actual database (preferrably a [Dockerized dummy database]({{ site.baseurl }}{% post_url 2019-03-29-dockerized-db-tests %})).
- [Cypress](https://www.cypress.io/) tests with mocked backend calls.

### Contract tests

Contract tests are used to test the interfaces (such as APIs) between services in order to avoid regression. The reason is to prevent one service to suddenly change its interface in a way that breaks some other service that is dependent on it. Contract tests are particularly useful for services that are consumed across team-boundaries. You can choose to view the contract tests as a subset of the component tests described above, but I prefer to make the contract tests a first-class citizen of the testing strategy in order to stress their importance.

Some examples of frameworks for [consumer-driven contract tests](https://reflectoring.io/7-reasons-for-consumer-driven-contracts/):

- [Pact](https://docs.pact.io/)
- [Spring Cloud Contract](https://spring.io/projects/spring-cloud-contract)

### End-to-end (E2E) tests

As a last resort, you might have to rely on end-to-end (E2E) tests. These are tests that perform a real-life scenario or use case, throughout the whole call stack, and without any mocks at all. While these can sometimes be valuable, you should always strive to catch as many problems as you can much earlier in the testing cycle. The reason is that it will be difficult to pinpoint the error if a tests fails, and also that this type of tests will often be hard to reproduce due to network latency and data inconsistency. So therefore you should have at most a handful of E2E tests, perhaps something like a simple [sanity check](https://en.wikipedia.org/wiki/Sanity_check#Software_development) just before deploying to production.

Some examples of different kinds of E2E tests:

- Manual [smoke tests](<https://en.wikipedia.org/wiki/Smoke_testing_(software)>).
- Cypress tests with the real backend.

The official [Cypress documentation](https://docs.cypress.io/guides/guides/network-requests.html#Testing-Strategies) agrees with my view that the number of E2E tests should be kept at a minimum:

> _It is a good idea to have end-to-end tests around your application’s critical paths. These typically include user login, signup, or other critical paths such as billing._ > _[...]_
>
> - _Use [stubbing] for the vast majority of tests_
> - _Mix and match, typically have one true end-to-end test, and then stub the rest_

## Summary

Whether you agree with my opinion on different types of tests or not, I always think it is a good idea to discuss such matters with your fellow team members and agree upon a written-down testing strategy to follow. This will both make it easier for you as a team to prioritize automated testing and make onboarding of new team members easier. Feel free to use the above as a starting point or come up with your own testing strategy!

Once you have the core definitions in place, you can continue to enhance your team's testing strategy by summarizing important general guidelines and useful best practices. I will write more on this topic in my next post so stay tuned!
