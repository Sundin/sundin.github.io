---
categories:
  - Agile
date: "2019-01-25T11:10:38Z"
title: Agile Evolution
---

Everything in nature goes in circles. Days turn into night in a circadian rhythm. Seasons replace each other.

Even life itself is iterative.

In every generation, a small number of genes gets changed due to random mutations. I’m not a biologist, but through some quick googling I found out that the human genome changes with a mutation rate of about [10<sup>-8</sup> per generation](http://science.sciencemag.org/content/328/5978/636.abstract). This is obviously a number that natural selection has arrived at and found optimal. A lower rate would mean that _Homo sapiens_ would be unable to keep up with changing conditions in our environment, and a higher rate leads to a too high risk of fatal mutations or even what is called an [error catastrophe](https://jvi.asm.org/content/80/1/20.full) – when a whole species gets exterminated due to uncontrolled mutation.

Through natural selection, what works good is turned up a little bit over time. The same effect weeds out genetical experiments that didn’t turn out so good.

If we apply these insights to the domain of software engineering, we are able to draw a few conclusions. As a start, we can notice that if we would apply the same mutation rate as in the human genome to a software project of 10,000 lines of code, only 0.0001 lines should be changed for every release! Given that the average software project is much less complex than the human genome, and usually with much less at stakes as well, we can probably allow for a somewhat higher mutation rate than that though. Interestingly enough, the [Wikipedia article](https://en.wikipedia.org/wiki/Error_catastrophe) on the aforementioned concept of error catastrophe backs this assumption up by stating that the relatively simple genome of RNA viruses (around 10,000 base pairs, compared to the human DNA with 3.3 billion base pairs) can tolerate a much higher mutation rate than human DNA – as high as 10<sup>-3</sup> per generation in fact.

If we instead use the mutation rate of these RNA viruses, whose genetical complexity is in the same order of magnitude as a the code in a medium-sized software project, we arrive at a more realistic number of 10 lines of code changed for every release. This might still sound ridiculously low if you are used to mastodonic releases, perhaps on a monthly or even yearly basis. However, I would argue that – as in countless other cases as well – it is more beneficial to mimic nature and take only one small step at a time. We also have the benefit of being able of completing this full iteration cycle for our software products many times each day, meaning that we will progress steadily over time, just that it will happen in smaller increments.

The pattern I have just described is of course what we nowadays call [continuous delivery](https://en.wikipedia.org/wiki/Continuous_delivery), but the same principle has been well known to software researchers for [at least the past 50 years](http://homepages.cs.ncl.ac.uk/brian.randell/NATO/nato1968.PDF) (I highly recommend watching [Kevlin Henney's](https://about.me/kevlin) talk [Old is the New New](https://www.youtube.com/watch?v=AbgsfeGvg3E) for more on this topic). Still, I feel its core principles are way too often brushed aside in the industry, in particular within so-called "mature" or "traditional" companies, simply based upon misconceptions or various logical fallacies. Hopefully this will all change for the better sooner than later, and anyway it’s always fun and inspiring to draw parallels between the natural sciences and software engineering!

Thanks for reading – see you next time.
