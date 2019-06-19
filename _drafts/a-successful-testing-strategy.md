---
layout: post
title: "A Successful Testing Strategy"
date_placeholder: 0
categories: 
---

Today we will a closer look at the testing pyramid and see how we can transform that into a concrete strategy for how to write your tests. While the terminology I use is not exactly the same as the one used by Mike Cohn in the original testing pyramid, the core concepts remain the same – a strong foundation of unit tests, complemented with a sufficient number of component tests and sprinkled with a few end-to-end tests as a last line of defense.


## Types of tests

Here is the terminology I prefer to use. The concepts can sometimes be overlapping and confusing, but the important thing to keep in mind is to get a rough feeling of how testing can be carried out on different abstraction levels. 

### Unit tests
Unit tests are the lowest level of testing. Her you should strive to catch as many problems as possible: logical bugs, malformed input, broken UI, etc. The reason is that unit tests are easy to write and fast to execute, meaning that you get near immmediate feedback as you develop. You should try to test as small parts of the code as possible with each unit test so that you easily can locate where the problem is in case a test fails. In order to achieve this, unit testing will have to rely heavily on techniques such as mocking and dependency injection.

Some examples of different kinds of unit tests:
  - Backend logic tests with mocked database.
  - Frontend logic tests, in particular business logic such as helpers, selectors and reducers.
  - Snapshot tests.

### Component tests
Component tests are tests that verify an entire component in isolation to other components. You have to decide for yourself what your definition of a component should be. In a microservice architecture each service should normally be considered as its own component though. Dependencies to other components should normally be mocked. The rationale for component tests is to verify that the component as a whole works as expected, without caring about its internal implementation details. Component tests should therefore have to change less frequently than the unit tests. Compared to end-to-end tests, contract tests will pinpoint errors at a more specific level and also usually be more reproducable as network flakiness will normally be mocked away.

Some examples of different kinds of component tests:
  - Backend tests for a microservice using a dummy Docker database.
  - Cypress tests with mocked backend calls.

### Contract tests
Contract tests are used to test the interfaces (such as APIs) between services in order to avoid regression. The reason is to prevent one service to suddenly change its interface in a way that breaks some other service that is dependent on the first. Contract tests are particularly useful for services that are consumed across team-boundaries. You can choose to view the contract tests as a subset of the component tests described above, but I prefer to make the contract tests a first-class citizen of our testing strategy in order to stress their importance.

Some examples of different kinds of contract tests:
  - Pacts between consumer and provider.

### End-to-end (E2E) tests
As a last resort, you might have to rely on end-to-end (E2E) tests, sometimes also called integration tests. These are tests that tests a real-life scenario, throughout the whole call stack, and without any mocks at all. While these can sometimes be valuable, you should always strive to catch as many problems as you can much earlier in the testing cycle. The reason is that it will be difficult to pinpoint the error if a tests fails, and also that any test that relies on actual network requests will often be severely lacking in the reproduceability aspect. So therefore you should have at most a handful of E2E tests, perhaps something like a simple sanity check just before deploying to production.

Some examples of different kinds of E2E tests:
  - Manual smoke tests.
  - Cypress tests with the real backend.

Further information about E2E tests can be found in the [Cypress documentation](https://docs.cypress.io/guides/guides/network-requests.html#Testing-Strategies):
 > *It is a good idea to have end-to-end tests around your application’s critical paths. These typically include user login, signup, or other critical  paths such as billing.*
 > *[...]*
 > * *Use [stubbing] for the vast majority of tests*
 > * *Mix and match, typically have one true end-to-end test, and then stub the rest*


## Guidelines

In this section I will describe a number of best practices I find useful to keep in mind when writing tests.
TODO: put in separate post?

### Ownership and Scope
The team owning the functionality should also own the entire test stack testing that functionality. That means no separate QA/testing role or team within the organization. Building software is a team effort and it is crucial that automated tests is considered a first-class citizen of your development process, as opposed to something that is half-heartedly latched on retrospectively after the code has already been written.

All functionality owned by the team needs to be tested, but also interfaces that are consumed or exposed by services belonging to other teams.

### Code coverage
> "100% code coverage tells you nothing, but less than 100% code coverage tells you something." – Unknown
Aiming for covering 100% of your code with tests is probably not realistic and perhaps not very useful neither. I usually start by just writing two unit tests for each of my functions; one that tests some basic use case for the function and another test that calls the function with empty parameters. I tend to think that these two cases covers most of the potential bugs in the function with a minimal time investment in writing tests.

However, it is usally a good idea to have some kind of code coverage check in your build pipeline. I usually find out what the current code coverage ratio is in the project, and then set that value as the minimum threshold in the pipeline. The idea here is mainly to make sure that new code that gets written is covered by unit tests, since the code coverage ratio would otherwise go below the threshold. Therefore you should strive at continuously increasing this threshold as your coverage ratio grows over time.

### Other guidelines

* If you find a bug, write a test that captures it.
* Always mock time (current date, etc.) to reduce flakiness.
* New features always covered with unit tests. Other tests if needed.
* All tests should test the minimal possible functionality.
  To be avoided: huge test that covers many outcomes.
* Each test should own its data. For example, insert/delete Docker database rows.
* Tests should be non-verbose and only print to the log if something unexpected happened.




---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
