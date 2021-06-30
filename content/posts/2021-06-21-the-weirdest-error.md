---
title: "The Weirdest Error"
description: ""
date: "2021-06-21T10:58:32+02:00"
thumbnail: ""
tags:
  - PHP
slug: the-weirdest-error
categories:
  - Other
---

A while ago, I stumbled across the weirdest error I have encountered so far during my software development career. It happened after a routine bump of the WordPress version running the WooCommerce web shop of [my record label](https://www.jawbreaker.se/). Everything seemed to be running fine, but then one customer reported that the checkout was broken (very bad for a web shop). I verified that I could reproduce the error on my own and started troubleshooting. I figured that the error was unlikely to be directly caused by the new WordPress version itself, and I therefore quickly narrowed down on the possibility that one of my plugins had incompatible code with the new version. After disabling and enabling different stuff for a while (made more difficult to debug due to browser caching) I figured out that the problem was somewhere in the code I had written for my custom child theme. After further troubleshooting I was also able to localize which was the faulty file – nothing strange so far. 

Then the weirdness began. I tried commenting out one line at a time in order to pinpoint the faulty code, but the problem persisted. Thinking that the problem must then be caused by some combination of code, I deleted the whole file. And yes, that made the error go away. After further trial-and-error and much head-scratching I at last concluded that an empty file was fine, but a simple set of `<?php ?>` tags with nothing in between them made the error come back. I don't really have an explanation for this behaviour, but [this obscure Stack Overflow answer](https://stackoverflow.com/a/27108359/948942) presented a solution: remove the ending `?>` tag! I'm used to always [closing what I open](https://www.informit.com/articles/article.aspx?p=2982114&seqNum=4), so this pattern feels strange to me – but that just seems to be the rules of the PHP game. Some very weird behaviour discovered, and even weirder that it have always worked with older WordPress versions, but at least the mystery was solved after "only" one hour of debugging.
