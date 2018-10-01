---
layout: post
title: "Whole Value Pattern"
date_placeholder: 0
categories: Patterns
---

The [Whole Value Pattern](http://c2.com/ppr/checks.html) is a pattern first described by [Ward Cunningham](https://en.wikipedia.org/wiki/Ward_Cunningham) in 1994. It simply implies that a value should always be stored together with its corresponding unit, which together forms a "whole value". A lone numerical value is usually not meaningful on its own, without a corresponding unit, and is therefore a violation of this pattern.

The main benefit of following the Whole Value Pattern is that implicit developer knowledge can be made explicit in the codebase instead.

## Examples
### Money
Money should be expressed in terms of a value and a currency, for instance 5000 USD.

### Timestamps
A common format for expressing a certain date and time is the Unix timestamp, which is equal to the number of seconds elapsed since January 1st 1970. On its own, this is usually not enough as timestamps might sometimes also be expressed as milli- or even nanoseconds. Often the timestamp needs to include the timezone where it has been collected as well.

### Coordinates
Avoid the risk of mixing up the longitude and the latitude by storing coordinates in a data type using the Whole Value Pattern: 45N 122W.

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
