---
layout: post
title: "Code Review Reflections"
date_placeholder: 0
categories:
draft: true
---

The quality of the code reviews within your organization will over time have an huge impact on the overall success of your business. Missing or poor code reviews will lead to detoriating quality and much headache will follow, while good code reviews will ensure that your code base maintains a high and increasing quality. More importantly, code reviews also acts a way to share knowledge within the team. Thus code reviews that are properly carried out is one of the best, cheapest and fastest ways of aquiring skilled developers.

Here are some things that are good to keep in mind when setting up your code reviews.

## Setup

The purpose of a code review is mainly to get feedback on the overall design of a code change. Don't waste your time commenting on things like formatting or typos. Such things can easily be automated and built into the build pipeline, so that code that is not correctly formatted will be impossible to merge into the master branch.

### Use a linter

The best way to achieve this is to use a linter. It is very important that the linting step is run in the build pipeline, and not just locally. One thing to look out for when reviewing other people's code is for manual overriding of linting rules in certain files. Such horrors should never exist! Either fix the warning or agree on disabling the rule for the whole project in case it is not interesting to follow.

### Invest in testing

While you might not need to go all the way for 100% code coverage in your tests, some areas are more important to cover with automated tests than others. Pick the low-hanging fruit first and prioritize the parts of the code that will need to change. With this is mind, you should be suspicious of all pull requests where no unit tests have been either added or modified. What that means in reverse is that the code just written can be safely removed again without breaking any existing tests. That either means that the code is pointless or, more likely, that the author should have added some tests for it. Like the lint step, it is important to make sure that the unit tests are always run in the build pipeline. The reason is that this is the only way to make sure that your tests always stay green. See my blog post on [testing best practices](https://sundin.github.io/testing/2019/08/07/testing-best-practices.html) for more things to keep in mind when writing unit tests.

---

Follow me with [RSS](https://sundin.github.io/feed.xml).

_Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io)._
