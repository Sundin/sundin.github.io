---
layout: post
title:  "Refactor responsibly"
date:   2018-09-22 17:27:45 +0200
categories: refactoring
---
Rewriting a large piece of software from scratch is [usually not a good idea](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/
), regardless of how messy or problematic the original/legacy code is. The reason is that you never know how long the rewrite is gonna take, what unexpected problems you might run into or even if your new solution is gonna be any better than the old. You might end up spending several months on refactoring without any possibility of releasing anything into production until the rewrite is complete. Remember that all code that's written but not released is a huge cause for concern as its thee perfect breeding ground for hidden bugs!

If you are not convinced, here are some other reasons why you should be careful with throwing away legacy code mindlessly:


* By rewriting you lose [accumulated knowledge in form of bug fixes that catches corner cases](http://cdn.pols.co.uk/papers/agile-approach-to-legacy-systems.pdf)
* Chesterton's fence: code is not written without a reason. Therefore, don't delete seemingly unnecessary code until you understand why it was put there in the first place.
* The code you write today will be the legacy code of tomorrow.

## Patterns of responsible refactoring

One useful strategy for mitigating the inherent risk of refactoring is to isolate the functionality you want to rewrite into smaller chunks. This will enable you to release small pieces code into production continously, meaning that you can verify that what you are building is actually working and giving you the possibility of backtracking or changing course at any point in a very agile way. In case you hit a dead end, you can always fall back to your latest working version without having to discard weeks or months worth of work.
More often than not, it will also force you to come up with a more robust software architecture as well!

Some architectural patterns can be used in order to execute this theory into practice. They are all very similiar and/or overlapping, with the main idea being to be able to shorten the release cycle in order to get quicker feedback and reduce overall risk. 

### Proxy pattern
Hide your legacy solution behind a proxy component. Useful while migrating backend code. In the first iteration, the proxy will simply forward all calls to the old system. Later on the proxy will take on more and more responsibility,one step at a time, until the old system at some point becomes completely superfluous.

### Exoskeleton pattern
Put your old code inside a shell that's running the new framework you have chosen to use. Rewrite the old code one small piece at a time and move it out into the outer layer. When all code has been migrated, the inner layer can be deleted. The Exoskeleton pattern, which Martin Fowler calls the [Strangler pattern](https://www.martinfowler.com/bliki/StranglerApplication.html)], could be a useful strategy if for example porting an existing app to another framework. 

Some things to keep in mind while using the Exoskeleton pattern:

* Cover your legacy code with tests, then replace code piece by piece, and all the while keeping the tests green. 
* [Event Intercepton](https://www.martinfowler.com/bliki/EventInterception.html) 
* [Asset capture](https://www.martinfowler.com/bliki/AssetCapture.html)

## Final words
I hope you will think twice before you utter the dreaded words "let's rebuild it from scratch" next time. It is extremely important to tackle technical debt at a continuous basis, but problematic legacy code needs to be refactored responsibly, one piece at a time, rather than blindly. Please don't risk taking on more than you can chew.

This being said, you should never be afraid of deleting code that is not being used (for instance commented-out or "dead" code that cannot be reached at runtime). Hopefully you are using a version control system like Git, meaning you can always retrieve the deleted code again if you (against all odds) might need it back.
