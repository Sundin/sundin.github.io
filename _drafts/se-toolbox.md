---
layout: post
title: "My Software Engineering Toolbox"
date_placeholder: 0
categories: Tools
---

In this blog post I will try to summarize some of my favourite tools that I use when developing software.
Given the transient nature of all modern tech, I intend to continuously update this post over time as I discover new tools or stop using old ones.


## Frameworks and Languages

### Smartphone Applications
For a project with a very large budget, you probably can't beat going native (of course writing in Swift for iOS and Kotlin for Android). For everything smaller than that, I would place my bets on Flutter.

In contrast to all other cross-platform frameworks I have worked with (React Native, Cordova, PhoneGap, Ionic), Flutter actually delivers on the promise to speed up development by only having to write the code once. So far, I can't really say that I have found any real downsides with Flutter.  

### Backend/API
Of the different backend frameworks I have tried out, the one that was fastest to get up and running with have been Django. I'm frankly quite impressed by it, and I really like that it already has all the features you normally need already included. One newer alternative is FastAPI, but I haven't had the oppurtunity to try that out yet.

Node.js with Express is also quite fast to get up and running, but not as fast as Django. I also always feel like code written in Node.js gets out of hand after a while when building production-scale APIs. That might likely be the case for the Python-based Django as well - for large scale applications I prefer to work with a strictly typed programming languages.

### Web
Static websites work great for blogs and lightweight wikis. This blog is built using Jekyll, but I think I like Hugo even better. The two are very similar, but I believe Hugo compiles even faster than Jekyll. There are many hosting alternatives for static websites, I personally use GitHub pages a lot.

For client-rendered web applications, the framework I'm most comfortable in is React. I would like to expand my toolbox here though, and get more experienced in for example Vue and Angular before I declare a winner. My favourite hosting provider for client-rendered web apps is Netlify.

Also keep in mind that for many use cases, simple HTML, CSS and JavaScript are often enough!

## IDE
For all programming in Java (and Flutter), I use the free community edition of [IntelliJ IDEA](https://www.jetbrains.com/idea/). For everything else, I use [Visual Studio Code](https://code.visualstudio.com/) (VSCode). The reason I love VSCode is that it is fast to open even the largest projects and that it has a massive ecosystem of great plugins.

In addition to language-specific syntax plugins, some of my favourite VSCode plugins are:
* [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens): I use it to view git blame details directly in the IDE.
* [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow): Lessens the burden of cognitive load when working with YAML and other heavily indented files.
* [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight) (or similar): Makes any "TODO" comments in the code clearly visible.

## Docker
Heroku has a really nice hosting solution for Dockerized apps, with a free tier available as well.

---

Follow me with [RSS](https://sundin.github.io/feed.xml).

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
