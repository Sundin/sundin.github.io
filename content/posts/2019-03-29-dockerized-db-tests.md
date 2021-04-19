---
categories:
  - Testing
date: "2019-03-29T11:11:30Z"
title: Dockerized database testing
slug: dockerized-db-tests
---

In this post I am going to give you an overview of different approaches to use when unit testing your backend code and database calls.

## Background

In my current project, we have a backend written in [Go](https://golang.org/) and a [PostgreSQL](https://www.postgresql.org/) database. We have for a long time been writing unit tests for the backend to be able to guarantee that the code is working as intended. In order to not have to rely on a database connection and be dependent on the state of the data in that database, we chose to mock away all database calls using a tool called [go-sqlmock](https://github.com/DATA-DOG/go-sqlmock) in the unit tests.

The benefits of mocking away database calls are that the unit tests will be lightning fast to run and, more importantly, that we are guaranteed to get a reproducible environment on every test run. This approach that has helped us to catch a large number of bugs, so it was time really well invested.

However, mocking away the database means that there are some types of problems that we are unable to catch with the unit tests. These potential problems include:

- Faulty SQL syntax in queries.
- Queries returning wrong data.
- Database triggers not working as intended.
- Broken migrations (faulty syntax or not being possible to roll back).

In order to catch these kinds of problems we have to run some kind of tests against a real database. One of our early attempts included connecting to a "hands-off" database instance where no one had manual access. This worked fine as long as our tests were limited to just reading data from the database, but as soon as we had to start manipulating the data during our tests we started to run into problems. Since each test run would start from a different state than the previous run, we could no longer guarantee that each test run would give the same result. This is a huge problem, since the [tests need to be deterministic](https://www.martinfowler.com/articles/nonDeterminism.html) if we are to trust them and be able to integrate them into our automated delivery pipeline.

This severe drawback led us to where we are now: firing up a new database instance using [Docker](https://www.docker.com/) for each run of the test suite.

## Docker to the rescue

I have chosen not to include any source code in this blog post (that might be the topic for another post if you are interested), but the high-level flow of our database tests looks something like this:

1. Launch a [PostgreSQL Docker container](https://docs.docker.com/samples/library/postgres/).
2. Validate and run migration files. Here we have the chance to not only validate that the syntax in our migrations is correct, but also that the "up" and "down" parts of the migration actually mirror each other.
3. Populate database with a pre-defined set of data. Since we know what data we put into the database, we can also be sure of what data our queries should return.
4. Run database tests. These are really the same thing as normal unit tests, but here we use a real database connection instead of a mocked one.

## Conclusion

So does this approach replace the basic unit testing with mocked database calls? No! Both approaches are useful for different purposes. The idea is that we want to [test different parts of our application in isolation](http://wiki.c2.com/?UnitTestIsolation). The simple, mocked unit tests are useful for catching bugs in our Go code – if a unit test fails, we know that the problem is located somewhere in our backend code and not in the database. This type of tests are usually really fast to run as well, meaning that you can run them in between every code change. Correspondingly, the fully-fledged Docker tests are great to use for testing database logic in isolation and also for broader functional tests where we test the backend logic, the database logic, and the communication between the two.
