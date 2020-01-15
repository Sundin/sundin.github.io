---
layout: post
title: "Breaking Synchronous Dependencies"
date_placeholder: 0
categories: Architecture
---

A common challenge in software development is how to come up with non-functional requirements, such as the maximum response times of your API.

Two NFRs to consider is the average response time of a certain endpoint, as well as the percentage of outlier requests that will fall outside of the accepted time bounds. Such outliers will always be there, especially when designing a microservice architecture using lambdas with their dreaded cold starts which is common these days.

While endpoint performance can and should be continuously improved, it is often more useful to first take a step back and ask whether we can limit the consequences of a slow request in the first place. If we can somehow break the dependency that our consumers has on the performance of the API, then there is much less need for spending lots of efforts in shaving off milliseconds of our response times.


## Solution
There are in fact such ways! These methods are all applicable for both client-service as well as service-service communication.

### True asynchronousity
The most obvious and flexible, but also potentially complex, solution is to make the operation asynchronous rather than synchronous. This is usually achieved by the means of event notification, which is explained in all its different flavors in great detail by Martin Fowler. While this communication pattern is more common in communication between backend services, it can also be set up between client and server.

### Async-like behaviour

A middle way is to make the operation seem like an asynchronous one to the user. This is achieved by making sure that the initial request is answered as quickly as possible, with the response simply containing an operation ID of the actual operation to be carried out. This ID can be used by the client to check on the status of its request, which the services has put on a queue for processing. This pattern is useful for heavy operation that takes a long time to complete, or when the operation is dependent on upstream services with unpredictable availability.


### Optimistic rendering
Means can also be taken to hide actual response times from the end user. Instead of showing a loading spinner while a request is being sent and processed, we can simply assume that the request will succeed eventually and immediately update the UI accordingly. If the request should really turn out to fail later on, perhaps after several retries, then we can handle this as a special case and show a relevant error message to the user.

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
