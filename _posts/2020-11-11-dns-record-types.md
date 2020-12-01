---
layout: post
title: "DNS Record Types"
date: 2020-11-11 14:28:20 +0100
categories: DNS
---

In this blog post I will briefly explain some of the most common [DNS record types](https://en.wikipedia.org/wiki/List_of_DNS_record_types).

* **A** (address) record: always points to a static IP address.
* **AAAA** record: the same as the A type record, but for IPv6 IP addresses.
* **CNAME** (canonical name) record: alias to another name (=domain), which can be an A record or another CNAME record. The only exception is that you cannot create a CNAME record in the *zone apex* (the root of your domain). So if the name of your DNS zone is `example.org`, you cannot create a CNAME for `sub.example.org` but you can create one for `www.sub.example.org`.
* **ALIAS** record: this record type is specific to AWS Route53 only. It is used in much the same way as a CNAME record, with the addition that you can also create it in your zone apex or point it directly at an AWS resource (such as an ALB, an EC2 instance or an S3 bucket). If you point it directly at an AWS resource, then you will not have to worry about setting up a static IP address for your resource, as AWS will keep track of when the IP changes for you.
* **NS** (name servers) record: points out the hostnames of a set of [authoritative name servers](https://en.wikipedia.org/wiki/Name_server#Authoritative_name_server) for a (sub)domain.
* **SOA** (start of authority): contains required metadata about the DNS zone and its name servers.
* **MX** (mail exchange) record: canonical name record for a mail server.


---

Follow me with [RSS](https://sundin.github.io/feed.xml).

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
