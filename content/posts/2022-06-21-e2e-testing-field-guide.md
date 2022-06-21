---
categories:
  - Tutorial
  - Testing
tags:
  - Cypress
date: "2022-06-21T00:00:01Z"
title: End-to-end testing field guide
slug: "e2e-testing-field-guide"
draft: true
---

This is a beginner's guide to getting started with end-to-end (E2E) testing. 
It is intended to be read as a high level overview of best practices, as there are already plenty of great and detailed tutorials on various frameworks "out there" on the Internet.
This guide uses [Cypress](https://docs.cypress.io/guides) as the example testing framework (just because it's the one I use the most), but the same methodology as described here can be applied using any framework.

## Step 1. Basic setup
First make sure you can run the project you wanna test locally on your computer.

To get started with Cypress, just follow the [official guide](https://docs.cypress.io/guides/getting-started/installing-cypress).

Basically you just need to add Cypress as a devDependency in your `package.json`. There's also an alternative method that I often use, and that is to add a separate test project with it's own `package.json` file and everything. It makes for a quite clean separation between test dependencies and actual project dependencies, as these can sometimes clash if you are unlucky.

## Step 2. Writing and running your first test
Next write a simple end to end (E2E) test, the simpler the better. I would suggest to start with just loading the app's main page and check that some cool element of your choice is actually there. Such a simple test we often call a ["smoke test"](https://en.wikipedia.org/wiki/Smoke_testing_(software)). Even though it is simple to write and easy to maintain, it actually provide a lot of value as it will catch a large number of potentially catastrophic errors that would crash your whole site or render it totally useless in some other way. Again, the Cypress documentation provides [a great tutorial](https://docs.cypress.io/guides/end-to-end-testing/writing-your-first-end-to-end-test) for getting you started.

Apart from E2E tests, you can also use Cypress for [component testing](https://docs.cypress.io/guides/component-testing/writing-your-first-component-test). You can do so if you like but the E2E tests usually provide more value. [There are some benefits of component tests as well though](https://www.componentdriven.org/).

Once you have one or more tests written, you can fire up the whole application locally and then run your tests against it. If everything's green, your good to go. Oh, actually you should try to intentionally break the application and make sure that the test goes red. A test that always shows a green light is pretty pointless (just like a traffic light that always shows green).

## Step 3. Running in the pipeline (a.k.a. bang for the buck)
The next step is to run the tests in your CI pipeline. Otherwise we have to depend on our dear but forgetful fellow developers remembering to run the tests locally every time they make a change. It is possible to work like that, but sooner or later it's [bound to fail](https://youtu.be/NLRiBbRo6CI) in a spectacular manner. There are different approaches here. Ideally you want to run all your tests on every pull request to prevent broken code from entering the master branch. To do this properly you should have a way of launching an isolated copy of your whole application stack from scratch and execute your tests against this copy. Personally I like using Docker Compose for this purpose and run the whole thing inside the CI pipeline, as [I have previously described here](https://sundin.github.io/e2e-tests-with-docker-compose/).

Sometimes that approach is not feasible for one reason or the other. Maybe your application takes hours to spin up or is difficult to replicate in a straightforward manner. In those cases, you can run your test suite against an actual environment that is deployed live. This method can be a useful complement to running the tests in your fake environment in the pipeline too! The benefit is that you will get an indication of the appplication's health in your actual live environment(s). If you run this kind of tests continuously on some sort of timer you will even get real time updates in case the application should ever go down in the middle of the night. Just be careful with tests that will create and/or delete real data.
