---
layout: post
title: "A Successful Testing Strategy"
date_placeholder: 0
categories: 
---

Today we will a closer look at the testing pyramid and see how we can transform that into a concrete strategy for how to write your tests.


## Types of tests

Ordered by priority and amount:
* **Unit tests**
  Catch as much as possible: logical bugs, malformed input, broken UI, etc.
  Cheap to write, immmediate feedback and fast to execute.
  - Backend logic tests with mocked database
  - Frontend logic tests, in particular business logic such as helpers, selectors and reducers.
  - Snapshot tests
* **Component tests**
  Test an entire component/service in isolation. Pinpoint errors at a lower level than integration. Reduce flakiness.
  - Backend tests with Docker database
  - Cypress tests with mocked backend calls
* **Contract tests**
  Test interfaces between services to avoid regression.
  - Pacts between consumer and provider, in particular across teams
* **E2E tests**
  Should be very few - e.g. one for Insights and one for Reports.
  - Manual smoke test
  - Cypress with real backend

Further information about E2E tests can be found in the [Cypress documentation](https://docs.cypress.io/guides/guides/network-requests.html#Testing-Strategies):
 > *It is a good idea to have end-to-end tests around your application’s critical paths. These typically include user login, signup, or other critical  paths such as billing.*
 > *[...]*
 > * *Use [stubbing] for the vast majority of tests*
 > * *Mix and match, typically have one true end-to-end test, and then stub the rest*


## Guidelines

### Ownership and Scope
The team owning the functionality should also own the entire test stack testing that functionality. That means no separate QA/testing role or team within the organization. Building software is a team effort and it is crucial that automated tests is considered a first-class citizen of your development process, as opposed to something that is half-heartedly latched on retrospectively after the code has already been written.

All functionality owned by the team needs to be tested, but also interfaces that are consumed or exposed by services belonging to other teams.


* If you find a bug, write a test that captures it.
* Always mock time (current date, etc.) to reduce flakiness.
* New features always covered with unit tests. Other tests if needed.
* All tests should test the minimal possible functionality.
  To be avoided: huge test that covers many outcomes.
* Each test should own its data. For example, insert/delete Docker database rows.
* Tests should be non-verbose and only print to the log if something unexpected happened.

### Code coverage
> "100% code coverage tells you nothing, but less than 100% code coverage tells you something." – Unknown
* In the frontend build pipeline there is a minimum threshold that should be nondecreasing for the ratio of
  1. components covered by snapshot tests.
  2. statements/functions/branches covered by unit tests (specified in package.json).

## Ideas
* Pact that generates cypress stubs (or the other way around) to prevent out-of-sync mock data.
  Would further reduce the need of E2E tests.




---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
