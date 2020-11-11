---
layout: post
title: ""
date_placeholder: 0
categories: 
---


Problem:
    Broken master beacuase issues are only discovered after merging PR.
    Real environment (test or even production) might go down.


Solution:
    Set up an isolated environment for every pull request


How:
    Trigger Github Action on pull request.
    Deploy a new stack with PR number as suffix.
    Keep common infrastructure that is used by all the independent deploys in a separate stack that is not duplicated for every deploy (typically resources that will rarely change).
        Downside: changes there will not be tested.
        But in order to be able to ..... we need some layer that exists outside of the boundaries of the isolated deployment-specific environments (see below).
    An URL is generated for each deploy. This will enable you try out your changes in isolation and without fear of affecting anyone else that is dependent on your service.
    (TODO) Run automated integration tests.
    (TODO) on merge:
        A) deploy "master" stack and delete the temporary stack.
        or
        B) shift traffic to the new stack and (TODO) then remove the previous production stack (maybe wait a week or two to remove old one in case of rollback needed -> scheduled github action).
            - faster deploys!
            - guaranteed same code as the one tested
            - always deploy new stacks instead of updating the old one, reduces risk of stack getting stuck in a bad state (for example when performing tricky refactorings of resources).
            (- tag previous production stack(s) to know which ones to remove)
                - production
                - timestamp
            - downside:
                - DNS TTL means that some clients might still get the old version for a while.
                -> use a load balancer instead
                -> HAProxy


TODO:
    shift traffic on merge
    how to handle rollbacks


Future improvements:
    Use the same approach to spin up new environments to use for canary deployments or A/B testing.








We started by creating a very simple Docker application.

We made it configurable using environment variables in order to be able to iterate faster.

First make sure we can build and deploy manually.
Then setup an initial pipeline using Github Actions.

    - Upload image to ECR
    - Deploy stack with CDK


Start preparing for blue/green deployment.
    - Define boundary.


Blue/green deployment:
    - Keep ECR, VPC and Cluster in a permanent stack.
        - Also insert new Route53 stuff here.
    - Always deploy Fargate Service to a NEW stack (with ALB). (keep old stack as well)
    - Use Route53 to direct traffic to the right stack. 
    - Redirect Route53 to new stack.
        - Future: use DNS weighted routing to get canary behaviour.
        - Future: add integration tests.
    - Somehow clean up old stack when not needed anymore.


Pull request isolated environment:
    - Set up new environment for each PR (use ALB URL instead of Route53 URL).
    - Somehow clean up old stack when not needed anymore.

    - Use branch name as suffix in stack name.
    - Output URL as comment on PR.
    - Remove temp stack on PR close.
    - Add branch protection, build must go green before merging

    - Future: run integration tests against the version deployed from branch.


Problems:

    - ECS default health check? Takes long time
        - MaximumPercent and MinimumHealthyPercent (AWS::ECS::Service DeploymentConfiguration) not used in Fargate launch type.
    - CDK does not support CodeDeploy blue/green deployments yet.
    - Export resources from one stack and import into another stack using CDK. SOLVED.

---

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*




Innovation days 
    - Same thing with the PR build
        - No control over pipeline, make local script instead?
        - Where to draw boundary? 
            - Only service? 
                - How to call service because its inside VPC? or is it? 
            - Or include nginx?


TODOS:
    - try without vpc
    - how to handle database?