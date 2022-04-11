---
categories:
  - Mindset
  - Workflow
date: "2022-03-22T00:00:00Z"
title: Practice Disaster Scenarios
slug: "practice-disaster-scenarios"
---


Practice disaster scenarios, at the very least as thought experiments.

Some ideas to get you started: What happens if your Kubernetes cluster gets funked up? What do we do? Create a new one from scratch? Do we know how to do that?
What happens if our production database gets corrupted? Do we have backups? And do we know how to restore one? 
Make sure to write down clear instructions beforehand so that some sleep-deprived on-call developers don't cause even more harm by panicking when we have a real incident.

By imagining what can go wrong can also act as a preventive action. In the words of famous science fiction author Ray Bradbury: sci-fi is not about predicting the future, it's about preventing it. The same goes for our risk analysis (although on a more down-to-Earth level).
What do we do if our TLS certificates expire? Maybe we should monitor that so we get a clear heads-up that the renewal process is not working weeks or months in advance, meaning that effectively prevented the problem from actually impacting service uptime. 

Make sure know-how is not locked inside the brain of anyone. You can be pretty sure that the day when you have a serious production incident is also the day that you tech lead get plucked up for dissection by sinister aliens. Best case, use Infrastructure-as-Code for everything important and shun manual steps like the plague. If that's not possible or feasible everywhere, make sure that any manual steps are clearly documented and easy to find. Also regurarly ensure that the documentation is up to date by actually practice to follow it.

If all your efforts fail and the production environment is on fire, don't be afraid to ask for help. But if your calling in an external expert you don't want them to waste hours on just figuring out how your system is intended to work. That should be documented as well, at least a helicopter perspective of how everything fits together. Make sure this documentation is also easy to find, prefarrably linked from or in the README file itself.

The key to success is proactivity.