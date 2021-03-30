---
layout: post
title: ""
date_placeholder: 0
categories: 
---

# Best Practices

* Rollbacks need to be possible
* Never crash on unknown values (maybe you add a new enum in the future) - rachelbythebay.com
* Don't generate UUIDs client-side
* If you have dependencies on other teams, prefer using one of their more stable environments.
* Always catch and handle potential errors.
* Don't obfuscate error messages.


## Java
* Use checked exceptions.
* Don't use Manager classes. Put logic inside the objects themselves.
* Create explicit 
* Use [pojo-tester](https://www.pojo.pl/)?

## Lambdas
* The downside of lambdas are their coldstart times. It's not a silver bullet for every use case.

## PostgreSQL
* Always explicitly specify the schema in your queries.
* Use a connection pool.
* Put database configuration as code in the repository (infrastructure-as-code).


## Ideas from Julio Biasion [Things I Learnt The Hard Way]
* Be ready to throw your code away.
* Don't try to solve future problems.
    * You will just end up having to maintain stuff you do not use.
    * "You can't connect the dots looking forward, only backwards." - Steve Jobs
* Don't use boolean parameters, create two separate functions instead.
* Either handle exceptions properly or crash the application. Don't hide exceptions.
* Robust code is better than short code.
* The best way to secure user data is not to capture it [See also Edward Snowden at Web:Summit 2019]


---

Follow me with [RSS](https://sundin.github.io/feed.xml).

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
