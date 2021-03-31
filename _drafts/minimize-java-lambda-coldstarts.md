---
layout: post
title: "Minimize Java Lambda Coldstart Times"
date_placeholder: 0
categories: Implementation
---



Here is a list of things to do to minimize the coldstarts for your serverless application.

The three biggest contributors to cold starts.

    Size of deployment package. Regardless of language the deployment package needs to be downloaded and extracted. In case of Java it also needs to be class loaded.
    Memory size of your runtime. The runtime is not only memory size but also how much minimum dedicated CPU you get for your function. Class loading is all about CPU.
    VPC Deployment. Creating Elastic Network Interfaces for your lambda takes time

Here is an action list specific to Java.

    Reduce number of dependencies. 
        Always just depend on the exact part of the AWS SDK that you actually need.
        Never ever use Spring or any part of Spring in your lambda. It's too big and you don't need it.
        Lean towards using Java native functions instead of bringing in Apache commons (for example, use the native Java 11 HTTP client instead of Apache).
        Don't build or use cusom libs full of "good to have things". IF you share something as a lib always make sure that all if it is used if anything is used.
        When building a lambda function always think "what else can I remove". Never think "I like this framework". Less is more! 
        Try to replace AWS v1 clients with their v2 counterparts.
    Reduce bundle size
        Get rid of unused dependencies (see above).
        Get rid of unreferenced classed using Proguard.
    Statics and member
        Instantiating clients etc is faster during setup (static member or in constructor).
        BUT! if you have a if clause that sends an SNS only conditionally when something happens, it might be a better solution to wait with creating that SNS client until we know that it is really needed.
    Loading remote resources.
        Minimize loading of remote resources and only do it when needed.
        Config should be defined close to the function. 
            Use environment variables or Parameter Store and read only once during lifetime of function.
            Minimize or remove usage of Remote frequently loaded config. There might be use cases for it then you should consider get when needed and only exactly needed config.
    AWS runtime memory size.
        The more memory you assign to your lambda function, the faster it will spin up because it also gets access to more CPU power.
        Note that increasing the memory size will often result in a lower runtime cost (since it is calculated as function execution time times available memory). There's a sweet spot at 1,5GB according to this article from 2020.







Some comments regarding Java lambdas. First of all check  https://youtu.be/ddg1u5HLwg8  for a lot of detailed information on how to reduce coldstart times.

Regarding 2. doing initialization when something actually is needed i.e. from your handler method actually one important drawback. Lambdas run a capped vCPU where the speed depends on your memory setting. the higher the memory you set the faster vCPU you also get. This is true for the execution of the handler method but during initializing of your lambda class (constructor and static initialization) the lambda runtime will give you a none capped vCPU. So doing initialization in the constructor that initialization will actually be faster. The point of only initializating what is needed is somewhat valid but your lambda will probably run for at least a couple of hours and if everything that needs initialization is most likely used during those hours it makes sense to do all of the initialization during startup.

Regarding 4. I think you need to measure it's impossible to set a fixed number like that since it depends on your code, requirements ond so on. If it doesn't matter if the average execution times goes up from 30 to 80 ms as an example you might save a lot of lambda execution cost by lowering your memory allocation. There is actually a tool that can help you decide on the optimal memory configuration: https://github.com/alexcasalboni/aws-lambda-power-tuning I have not had time to try it out yet.



---

Follow me with [RSS](https://sundin.github.io/feed.xml).

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
