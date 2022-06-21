---
categories:
  - Testing
  - Tutorial
  - Architecture
  - Patterns
tags:
  - Docker
  - Cypress
date: "2022-02-04T00:00:00Z"
title: Robust end-to-end testing with Docker Compose
slug: "e2e-tests-with-docker-compose"
featured: true
---

End-to-end (E2E) testing is a powerful tool for automated quality assurance. Ideally you want to be able to catch potential errors and bugs already on the unit testing level, but doing so can sometimes be both time-consuming and difficult. Unit testing also relies heavily on mocking out dependencies by nature, so we cannot necessarily guarantee the same behaviour as in our live application. E2E tests are on the other hand often very straightforward to set up and write, and enables us to construct very realistic testing scenarios. Thus we can be very confident that the application being tested really works as expected as long as all the E2E tests pass, even if it can sometimes be a little tricky to pinpoint an error when there's a failure.

There are many ways of setting up a robust E2E test suite, but I would suggest using Docker Compose for launching an isolated instance of your whole application and Cypress for writing the actual tests. This assumes the various components in your system are possible to run as Docker containers (which is very good for portability purposes anyway). Here's a sample Docker Compose file for reference:

```yaml
version: "3.5"
services:
  database:
    image: postgres:9
    ports:
      - 5432:5432
    environment:
      POSTGRES_DB: db
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: password
    networks: skynet
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  backend:
    build:
      context: src
      dockerfile: backend/Dockerfile
    ports:
      - 5000:80
    networks: skynet
    volumes:
      - "./healthcheck.sh:/usr/local/bin/healthcheck.sh"
    healthcheck:
      test: ["CMD-SHELL", "/usr/local/bin/healthcheck.sh"]
      interval: 5s
      timeout: 5s
      retries: 15
      start_period: 40s
    depends_on:
      database:
        condition: service_healthy

  frontend:
    build:
      context: src
      dockerfile: frontend/Dockerfile
    ports:
      - 5000:80
    networks: skynet
    extra_hosts:
      - "host.docker.internal:host-gateway"
    depends_on:
      backend:
        condition: service_healthy

  cypress:
    image: cypress/included:9.4.1
    command: cypress run --record
    environment:
      CYPRESS_RECORD_KEY: ct56669f-1349-4b6a-a445-ct6hu66lu
    networks: skynet
    extra_hosts:
      - "host.docker.internal:host-gateway"
    volumes:
      - ./src/PlintDirect.Web/frontend-tests:/e2e
    working_dir: "/e2e"
    depends_on:
      backend:
        condition: service_healthy
      frontend:
        condition: service_started
networks:
  skynet:
    driver: bridge
    name: skynet
```

This Docker Compose file will launch 4 different containers: database, backend, frontend, and finally one container that executes the E2E tests using Cypress. Crucial for this setup to work is the `healtcheck` and `depends_on` commands. These will specify a strict order in which the different containers need to launch. Without this functionality, we will run the risk of the Cypress tests being fired off too early, before the backend is ready to accept requests for example. This will likely cause test failures, and even worse is that the tests will be unpredictable depending on the order in which the containers happen to start for a specific run.

In the `depends_on` section for a container, we can specify which other containers which need to start first. The two options are `service_started`, meaning that the container must have started, and `service_healthy`, meaning that the container must have started and also have passed its health check. We construct the actual health check for a container in the `healthcheck` section. Under the `database` container we use Postgres' built in health check functionality. On the `backend` container we have instead written a custom health check in a bash script file (example below).

There are also different parameters for the health check that you can play around with. These are:

- `interval`: How long to wait between each health check.
- `timeout`: How long to wait before timing out a health check and marking it as failed.
- `retries`: How many times to retry the health check before giving up and marking the container as unhealthy.
- `start_period`: A grace period during which failed health checks won't count towards the number of failed retries. A successful health check during this period will still mark the container as healthy though. Can be used for containers that are known to require a long startup time.

Here's an example of a custom health check script. You can perform any logic you want to, just remember to return an exit code of 0 to mark the health check as passed and any other number to mark it as failed. In this example we make a curl (make sure it is installed in the container) request towards a `/health` endpoint that can do anything from just returning 200 (indicating that the server has started) to more complicated status checks such as checking that the database connection is alive.

```sh
#!/bin/sh
set -ex

CONTAINER_URL=http://localhost:5000

echo "Performing health check towards $CONTAINER_URL"

STATUSCODE=$(curl --output /dev/stderr --write-out "%{http_code}" $CONTAINER_URL/health)

if test $STATUSCODE -eq 200; then
    echo "Service is ready!"
    exit 0
else
    echo "Status code was $STATUSCODE. Service not ready yet!"
    exit 1
fi
```

Finally we have a working E2E test setup. All that is left is to plug it in to our build pipeline so that it can be run on every pull request. This step is crucial since it is the only way of guaranteeing that no code that breaks any end user functionality ends up on the master branch. I prefer containing this step in its own script file that gets executed by the pipeline. The reason is to have everything contained as this step might grow more complex with time. But in its simplest form, this step consists only of running `docker-compose up` with two magic flags: `--abort-on-container-exit` and `--exit-code-from`. The former makes sure that we tear down the whole stack as soon as any of our containers exits (successfully or not). Without this flag, our pipeline would halt here forever which is not what we want. The `--exit-code-from` flag specifies that we want to use the exit code from a specific container as the exit code for the entire `docker-compose` command. It takes a single argument, the name of the container we are interested in. If all the Cypress tests passed, we will get an exit code of 0, and 1 otherwise. In case some other container exited (by crashing or failing all its retries on the health check) before the Cypress container had time to finish (or even start), we will also get a non-zero exit code here.

```sh
#!/bin/sh
set -ex

docker-compose \
    up \
    --abort-on-container-exit \
    --exit-code-from cypress
EXIT_CODE=$?

echo "Cypress test suite finished with exit code $EXIT_CODE"

exit $EXIT_CODE
```

That's it! The same approached described in this blog post can also successfully be applied for [realistic database tests](/dockerized-db-tests/) and other types of tests. Thanks for reading.
