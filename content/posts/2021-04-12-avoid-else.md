---
categories:
  - Patterns
  - Refactoring
date: "2021-04-12T00:00:00Z"
title: Avoid using else statements
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

However, the above implementation contains two distinct paths that both need to be tested separately.

We can simplify the function in order to get rid of the else clause:

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

Or better still, get rid of all conditional statements altogether. With the implementation below, the function will always follow the same code path, regardless if we pass it a string or an array to begin with.

```javascript
function myFunction(myVar) {
  myVar = [].push(myVar);

  myVar.forEach((element) => {
    doSomething(element);
  });
}
```
