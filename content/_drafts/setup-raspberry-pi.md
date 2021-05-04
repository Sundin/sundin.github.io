---
title: "Setup Raspberry Pi to act as your own web server"
description: ""
date: "2021-05-04T10:58:32+02:00"
thumbnail: ""
categories:
  - ""
tags:
  - ""
draft: true
---

In this blog post I will describe how I set up my own web server using just a single Raspberry Pi at home. This is a cheap and fun solution to hosting your own applications, in my case using Docker.

## Setting up the Raspberry Pi

Install the [Raspbian OS](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) on your Raspberry Pi's SD card.

In order to connect wirelessly to the Raspberry without having it connect to a monitor, you need to set up [headless SSH](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md).

Connect with Ethernet cable to Router (first time only).

Find the IP of your Raspberry:

    ping raspberrypi.local

SSH into it:

    ssh pi@<ip>

The default password is `raspberry`. It might be a good idea to change it now!


### Installing Docker
If you want to run your application code inside a Docker container, this is how you do it:

Install Docker:

    curl -sSL https://get.docker.com | sh

Install Docker Compose:

    sudo pip3 install docker-compose

Run Docker as sudo:

    sudo groupadd docker
    d \$USER docker
    newgrp docker

Set up [ssh keys](https://www.raspberrypi-spy.co.uk/2019/02/setting-up-ssh-keys-on-the-raspberry-pi/):

    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

You are now ready to launch an application of your own! I did it by simply pulling a git repo and following the instructions in the repo's README file.

## Connect from the outside world

Make sure you have a public IP. I requested a static public IP address from my ISP, but this is optional.

Give your Raspberry Pi a static IP on your local network. [This](https://kb.netgear.com/25722/How-do-I-reserve-an-IP-address-on-my-NETGEAR-router) is how I did it for my Netgear router.

Forward port 8080 from your router to the Raspberry. Again, [this](https://kb.netgear.com/24290/How-do-I-add-a-custom-port-forwarding-service-on-my-Nighthawk-router) is how I did it on my Netgear router.

In order to get a nice, user-friendly web domain instead of having to remember your public IP, there's a nice service called [DuckDNS](https://www.duckdns.org/). Just create a free account and then follow the [instructions](https://www.duckdns.org/install.jsp).

## HTTPS communication
Of course you need to encrypt traffic on your web site. For this, we use the free service Let's Encrypt.

Run the following commands on your Raspberry Pi:

    sudo apt-get update
    sudo apt-get install certbot

Make sure port 80 is open.

Temporarily shut down the server, then run:

    sudo certbot certonly --standalone

The certificates and key chain are now saved under `/etc/letsencrypt`, so copy them to your application folder or change the certificate path in your application code to point there.

### Automatic renewal

Renew certs automatically: https://certbot.eff.org/lets-encrypt/ubuntubionic-other


0 _/12 _ \* \* root sudo certbot renew --pre-hook "docker-compose stop" --post-hook "sudo docker-compose start"

sudo touch /var/log/certbot-renew.log

sudo chmod 666 /var/log/certbot-renew.log

sudo certbot renew --pre-hook "docker-compose stop" --post-hook "sudo docker-compose start" --dry-run >> /var/log/certbot-renew.log


### Renew manually

    sudo certbot renew --pre-hook "docker-compose stop" --post-hook "sudo docker-compose start"

    sudo cp /etc/letsencrypt/live/bissenisse.duckdns.org/fullchain.pem ~/bissenisse-backend/sslcert/fullchain.pem

    sudo cp /etc/letsencrypt/live/bissenisse.duckdns.org/privkey.pem ~/bissenisse-backend/sslcert/privkey.pem

    sudo docker-compose restart

Note: it is very important to run docker-compose with sudo, otherwise the container will have insufficient permissions to read the certificate files.
