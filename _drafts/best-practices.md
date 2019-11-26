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


## Lambdas
* The downside of lambdas are their coldstart times. It's not a silver bullet for every use case.

## PostgreSQL
* Always explicitly specify the schema in your queries.
* Use a connection pool.
* Put database configuration as code in the repository (infrastructure-as-code).


---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
