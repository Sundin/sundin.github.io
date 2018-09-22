#!/bin/sh

if [ -z $1 ]; then
   echo "You must pass a filename as argument"
   exit -1
fi

mkdir -p _drafts

cat > _drafts/$1.md <<- "EOF"
---
layout: post
title: ""
date:   
categories: 
---



---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
EOF