---
layout: post
title: "Writing a good README file"
date: "2024-02-25T08:31:41Z"
categories: 
    - Documentation
slug: writing-a-good-readme
---

Every repository should have a Readme file containing some basic information. It's the starting point for anyone new to the project to get an overview of what the repository contains and what to do with it. Writing a good enough Readme takes only a few minutes if you are already familiar with the contents of the repository. If it takes any longer than that, the time investment will be even more worth it as it means that you have to figure out some basic and important facts about your system!

The following sections are what I'm personally most interested in learning about when checking out an unfamiliar repository, and can be used as a template when creating your Readme.

- **Purpose**: What is the reason of having this repository? What does the code do? What purpose does it serve? Just 1-3 sentences will be enough to give a quick introduction.
- **Getting started**: Short but comprehensive instructions for how to get the project up and running on your own computer. This includes installing any prerequisites etc.
- **Tests**: Are there any tests included in the project? How do I run them?

By having the above sections covered, the Readme contains the most important information that any new team member joining in needs to know. Unfortunately I have seen many projects that doesn't even have such basic information, but it really should not take that long to write down so just do it! If you have another couple of minutes to spend, the Readme can then be further improved with the following sections:

- **Architectural overview**: Just a simple diagram or a textual description from a bird's eye perspective of the different components contained in or related to this service. For example, do we have any external dependencies? This is very useful for getting a shared mental picture of the system we are building.
- **Deployment**: How does the process look for getting a change all the way into production? Are there any manual steps involved?
- **Further reading**: If there is more documentation available elsewhere, a link or reference would be good so that we can find it.

Don't forget that the Readme is intended to be a living document, so never be afraid to add or change stuff in it. Getting started instructions missing for your OS? Write it down once you have figured the steps out! Figured out a workaround for a known problem? Add it to the Readme! In general, if you have any question at all related to the repository, that means that there is a bug in the documentation. So once you have figured the answer out, what better place to write it down than in the Readme?
