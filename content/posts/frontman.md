---
title: "Introducing Frontman"
description: ""
date: "2021-10-04T10:58:32+02:00"
thumbnail: ""
categories:
  - Implementation
  - Announcements
tags:
  - NGINX
  - Docker
---



[Frontman](https://github.com/Sundin/frontman) is a very light-weight NGINX reverse proxy that is deployed using Docker. Its purpose is to act as the entry point to your server. It will redirect incoming traffic to one out of many Docker-based applications running on the same server, based on the hostname in the incoming request. 

The rationale behind this is that it enables you to host as many services as you want on the same server, while still only keeping ports 80 and 443 open to the outside world.

Frontman is configured using a simple json file, meaning that you can reuse the same code on any number of servers, with just the redirection rules (configured in the json file) differing.

Feel free to check out the [source code](https://github.com/Sundin/frontman) on Github!
