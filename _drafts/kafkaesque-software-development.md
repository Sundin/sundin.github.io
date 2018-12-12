---
layout: post
title: "Kafkaesque Software Development"
date_placeholder: 0
categories: Agility
---

Will a new feature add value or decrease it?

A common danger to many software engineering efforts is feature creep. This is when we keep adding new and shiny features to our product, potentially rendering it less and less useful as we clutter the interface and makes  harder and harder to find the few features that actually made our product valuable. A related problem is scope creep. This is when the stakeholders keep coming up with new requirements, delaying the project's launch date more and more. Such stakeholder requests usually takes the form of "what if...?", like "what if the user would like to be able to change the color theme of the UI?" or "what if the user needs to sort the list in ascending order instead of descending?". While these might be valid use cases, experience tells us that implementing them might actually lead to a worse user experience than we had before. Endless debating and perpeptually changing requirements might also cripple the development process severely, in worst case effectively eliminating any chance of actually releasing the product.

So will a new feature add value or decrease it? The (post-mortemly) famous writer Franz Kafka asked this question in his story *The Burrow* already in the early 1920s, pre-dating the birth of software development by almost 50 years.

The story is about an unidentified animal building a burrow for protection. However, the animal keeps wondering if it should have designed its burrow differently. Maybe the door shuld have been sturdier to keep out attackers, but that would of course also make it harder for the little animal to escape in an emergency situation. Or maybe it should have added a back door as an alternative escape route, but on the other hand that would also be an entry point for a hungry predator. And so on, and so on...

Just like the animal in the story, we will never be able to simply reason the answer to such questions out. But unlike the animal, we are able to experiment cheaply and without risk of getting killed. In nature, experiments are also carried out by real animals all the time due to random mutations which change their behaviour (perhaps by constructiong their burrow in a slightly different way) in subtle ways. The only way for the animal to get feedback from the experiment though is to wait for the process of natural selection to either kill off the animal or enable it to successfully pass on its genes to its offspring. In nature, this process has been repeated over and over again across countless millenia. The result is that individuals that built their burrows with feature A died out while those that built feature B prospered and multiplied. 

When it comes to software, people usually don’t have to die or get hurt in order for us to learn from our mistakes. And we can accelerate the process of learning by running controlled experiments with short feedback loops. Here are some well-proven techniques for running controlled experiments to get you started (also, beware of overfitting to early adapters - you need to run your experiments continuously).    
- A/B testing
- Rapid/paper prototyping
- User analytics
- Capturing user feedback


## Acknowledgements

https://www.newcriterion.com/issues/2018/10/how-to-read-kafka-part-i

---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
