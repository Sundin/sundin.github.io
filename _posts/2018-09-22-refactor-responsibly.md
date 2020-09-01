---
layout: post
title: "Refactor Responsibly"
date: 2018-09-22 20:34:11 +0200
categories: Refactoring
---
Rewriting a large piece of software from scratch is [usually not a good idea](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/), regardless of how messy or problematic the original/legacy code is. The reason is that you never know how long the rewrite is gonna take, what unexpected problems you might run into or even if your new solution is gonna be any better than the old. You might end up spending several months on refactoring without any possibility of releasing anything into production until the rewrite is complete. Remember that all code that's written but not released is a huge cause for concern as its the perfect breeding ground for hidden bugs.

If you are not convinced, here are some other reasons why you should be careful with mindlessly throwing away legacy code:

* By rewriting you lose [accumulated knowledge in form of bug fixes that catches corner cases](http://cdn.pols.co.uk/papers/agile-approach-to-legacy-systems.pdf).
* Remember [Chesterton's fence](https://abovethelaw.com/2014/01/the-fallacy-of-chestertons-fence/): code is not written without a reason. Therefore, don't delete seemingly unnecessary code until you understand why it was put there in the first place.
* The code you write today will be the legacy code of tomorrow.
* Make sure you are able to [finish what you start]({{ site.baseurl }}{% post_url 2018-09-28-last-week-mindset %}).

## Patterns of responsible refactoring

One useful strategy for mitigating the inherent risk of refactoring is to isolate the functionality you want to rewrite into smaller chunks. This will enable you to release small pieces code into production continously, meaning that you can verify that what you are building is actually working and giving you the possibility of backtracking or changing course at any point in a very agile way. In case you hit a dead end, you can always fall back to your latest working version without having to discard weeks or months worth of work.
More often than not, it will also force you to come up with a more robust software architecture as well!

Some architectural patterns can be used in order to execute this theory into practice. They are all very similiar and/or overlapping, with the main idea being to be able to shorten the release cycle in order to get quicker feedback and reduce overall risk. 

### Proxy pattern
Hide your legacy solution behind a proxy component. Useful while migrating backend code. In the first iteration, the proxy will simply forward all calls to the old system. Later on the proxy will take on more and more responsibility, one step at a time, until the old system at some point becomes completely superfluous.

### Exoskeleton pattern
Put your old code inside a shell that's running the new framework you have chosen to use. Rewrite the old code one small piece at a time and move it out into the outer layer. When all code has been migrated, the inner layer can be deleted. The Exoskeleton pattern, which Martin Fowler calls the [Strangler pattern](https://www.martinfowler.com/bliki/StranglerApplication.html)], could be a useful strategy if for example porting an existing app to another framework. 

Some things to keep in mind while using the Exoskeleton pattern:

* Cover your legacy code with tests, then replace code piece by piece, and all the while [keeping the tests green](https://www.youtube.com/watch?v=aWiwDdx_rdo). This is probably the number one, most valuable lesson to learn in order to succeed with any form of refactoring.
* [Event Intercepton](https://www.martinfowler.com/bliki/EventInterception.html): This is a technique recommended by Martin Fowler himself when doing this type of refactoring. Tap into the stream of events flowing into your legacy system from the outside world. Make sure these events also arrive into your shiny new exoskeleton. Once you have that foundation in place, you can start moving actual functionality out into the exoskeleton.
* [Asset capture](https://www.martinfowler.com/bliki/AssetCapture.html): Once you have your Event Interception into place, Martin Fowler suggest you continue by moving one type of data entity (i.e., one type of asset) at a time into your new system. The more finegrained entity/asset type you are able to identify, the better (again, it's better to start small and build from there). In order to get this to work, you will need to be able to synchronize all entries of that certain type into the new system, and ideally also be able to synchronize them back again. This approach will make sure you have your back covered until your new system is able to handle all the various use cases concering that asset/entity type.

## Final words
I hope you will think twice before you utter the dreaded words "let's rebuild it from scratch" next time. It is extremely important to tackle technical debt at a continuous basis, but problematic legacy code needs to be refactored responsibly, one piece at a time, rather than blindly. Please don't risk taking on more than you can chew.

This being said, you should never be afraid of deleting code that is not being used (for instance commented-out or "dead" code that cannot be reached at runtime). Hopefully you are using a version control system like Git, meaning you can always retrieve the deleted code again if you (against all odds) might need it back.

---

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
