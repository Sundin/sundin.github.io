---
title: "How to Build a Reverse Proxy"
description: ""
date: "2021-06-21T10:58:32+02:00"
thumbnail: ""
categories:
  - Tutorial
  - Implementation
tags:
  - Docker
  - AWS
slug: nginx-reverse-proxy
---

In this blog post I will describe how you can deploy services on the same server. The server will be fronted by an NGINX instance acting as a reverse proxy responsible for forwarding incoming traffic to the right service.

I will use an EC2 instance on AWS since it has a low monthly cost and I don't have to worry about hardware maintenance at all, but you can use the same approach for any kind of server. For real-life applications used in production it would probably be a really bad idea to deploy different services on the same EC2 instances, but for my own personal and hobby projects with very little traffic I'm more interested in keeping costs down than building for resilience. In this scenario it makes perfect sense to deploy several of my projects to the same EC2 instance (or physical server, perhaps a Raspberry Pi at home). But how to make sure incoming traffic is routed to proper service on the server? This is where the reverse proxy comes in.

## Preparations

First of all I launched an EC2 instance on my AWS account. I chose the Ubuntu 20.04 image, since it (as of writing this) able to use a newer version of Docker than the Amazon Linux AMI (Docker version 20.04 or newer is required for my approach to work).

You can also save yourself a bit of trouble by [allocating an elastic (=static) IP address](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#using-instance-addressing-eips-allocating) to your EC2 instance.

Now you can SSH to your EC2 instance and deploy all of your applications (I did it using separate Docker Compose stacks). You only need to make sure that each application/service runs on its own port.

## Reverse proxy

Now that we have our applications up and running, we need to expose them to the outside world. We will do this by deploying an NGINX instance on port 80 (we will switch to HTTPS on port 443 in another blog post) which will act as a reverse proxy, redirecting incoming traffic to the right service.

Before we do that, we will first obtain some user-friendly URLs though. I used [no-ip.com](no-ip.com) which is pretty nice. The free version is limited to 3 domain names which you have to renew every 30 days, but upgrading is pretty cheap at $25 per year. Create an account and create two different domains (`example1.zapto.org` and `example2.zapto.org` for the purposes of this tutorial) and route them to the elastic IP you assigned to your instance earlier.

Now we are ready to deploy our reverse proxy!

Create a file called `nginx.conf`. Remember to add your own domain names as `server_name` and also to replace the ports to the ones where your applications are actually running. You can also add additional `server` blocks if you have more than two applications up and running.

```nginx
events {
  worker_connections  1024;  # default is 1024, and this section is required
}

http {
  resolver 127.0.0.11 ipv6=off valid=30s; # This is Docker's static DNS IP

  server {
    server_name   example1.zapto.org;
    listen       80;
    location / {
      proxy_pass http://host.docker.internal:8665/;
      
      # Include this line so that your target service will see the original matching URL, not the proxied URL
      proxy_set_header Host $host;
    }
  }

  server {
    server_name   example2.zapto.org;
    listen       80;
    location / {
      proxy_pass http://host.docker.internal:8080/;
      proxy_set_header Host $host;
    }
  }
}
```

And the following Dockerfile:

```Docker
FROM nginx:1.21
COPY nginx.conf /etc/nginx/nginx.conf
```

Now build the reverse proxy with 

`docker build -t reverse-proxy .` 

and start it with 

`docker run -d -p 80:80 --add-host host.docker.internal:host-gateway --name reverse-proxy reverse-proxy`.

(The `--add-host host.docker.internal:host-gateway` part means that we can use `host.docker.internal` as host in order to redirect traffic to `localhost` on our EC2 instance. This flag requires Docker version 20.04 or newer.)

## Summary

By just exposing a simple reverse proxy we can accept all incoming traffic on the same port. The reverse proxy will route the traffic to the right place by looking at the URL of the incoming request. By choosing NGINX and Docker we can also feel confident that this will work without eating up a lot of precious computing power on our server as well.