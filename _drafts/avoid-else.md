---
layout: post
title: "Avoid using else statements"
date_placeholder: 2020-08-17 09:34:11 +0200
categories:
---

Let's take a simple example from the world of JavaScript, where we can't be certain of the type of a variable up front. Let's say we have a function (`myFunction`) which we can either pass a string or an array of strings. If we pass it a string, we want to do something with that string. If we pass it an array, we want to do the same thing for each element in the array.

```javascript
function myFunction(myVar) {
  if (typeof myVar === "string") {
    doSomething(myVar);
  } else {
    myVar.forEach((element) => {
      doSomething(element);
    });
  }
}
```

We can simplify it in order to get rid of the else clause:

```javascript
function myFunction(myVar) {
  if (typeof myVar === "string") {
    // Convert myVar into an array with one element
    myVar = [myVar];
  }

  myVar.forEach((element) => {
    doSomething(element);
  });
}
```

```javascript
function myFunction(myVar) {
  myVar = [].push(myVar);

  myVar.forEach((element) => {
    doSomething(element);
  });
}
```

---

_Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io)._