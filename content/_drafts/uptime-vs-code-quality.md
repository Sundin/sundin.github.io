---
layout: post
title: "Uptime vs Code Quality"
date_placeholder: 0
categories:
draft: true
---

## Problem Description

The currently accepted workflow with a release happening at most every 6th week forces us to make a tradeoff between uptime (during deployment) and code quality. This document proposes that we accept the risk of some downtime during deployment in favor of ensuring a high code quality. The issue is best explained using a simple example.
### Ideal Workflow
Imagine a super simple scenario where a change needs to be made which affects both frontend and backend code. In the ideal case, this change would be tackled in the following way in order to ensure 100% uptime as well as a high code quality:

Step 1: Upgrade backend code with the new functionality, while still keeping support for the old functionality in order not to break the frontend client.
Step 2: Upgrade frontend client to use the new backend functionality.
Step 3: Clean up the technical debt we have introduced by removing the now superfluous old functionality from the backend – i.e., raising the quality of our code.

Note that we cannot safely proceed to the next step in the flow described above until the change from the previous step has been propagated throughout all of deployment environments. In other words, step 1 needs to be deployed into production before we can start with step 2. In a continuous deployment environment, such a simple scenario as the one described above could quite possibly be completed within a single day. Even if we imagine more complex situations which involve interdependent systems developed by multiple teams, any change can be deployed into production within at least a few days – while still maintaining 100% uptime and ensuring high code quality. 

### Our Situation
With our process the simple scenario with three steps described above would take 3 x 6 = 18 weeks to get into production! Needless to say, within such a time frame the last step would inevitably be forgotten and/or ignored, leading to an increased technical debt which would accumulate more and more over time. 

The alternative is to throw all caution overboard and go ahead and perform all three of the steps described above simultaneously in order to fit them into a single release window. This a somewhat risky move that could potentially lead to downtime and other issues during deployment.

In other words, we have to choose between uptime and code quality.
## Recommendation
The best way forward would naturally be to ditch the 6 week increments and aim for at least one deployment per sprint, which has (as we all know) been a well-known best practice within the field since at least 1968. [1]

Given that this seems an unpopular opinion, the next best thing would be to choose code quality over uptime. In other words, we prioritize getting the code in best possible shape at the cost of potentially having some systems to break during the actual deployment process.
## Impact
Users of the system might experience some downtime (in case nothing goes wrong this will be the time between the first and the last subsystem are deployed). As we hardly have any users anyway this downtime would hardly be noticable (although there are other things that can go wrong with such large releases).
## Work Effort
Using an agile process within more frequent deployments would reduce workload greatly both directly by letting us focus on delivering value as well as indirectly since we will have fewer and less severe problems caused by bad releases to solve.

Choosing code quality over uptime would also reduce workload both directly and indirectly, as it means that the quality of our code will hopefully not deteriorate over time.
#


1  http://homepages.cs.ncl.ac.uk/brian.randell/NATO/nato1968.PDF page 21. Yes, that is 50 years ago.
