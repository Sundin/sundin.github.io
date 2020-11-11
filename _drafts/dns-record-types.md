---
layout: post
title: "DNS Record Types"
date_placeholder: 0
categories: 
---

In this blog post I will briefly explain some of the most common [DNS record types](https://en.wikipedia.org/wiki/List_of_DNS_record_types).

* **A** (address) record: always points to a static IP address.
* **AAAA** record: the same as the A type record, but for IPv6 IP addresses.
* **CNAME** (canonical name) record: alias to another name (=domain), which can be an A record or another CNAME record.
* **ALIAS** record: this record type is specific to AWS Route53 only. It is used in much the same way as a CNAME record, with the exception that it can point to a root domain. AWS will transform this record into an A or AAAA type record under the hood for you.
* **NS** (name servers) record: created in the superdomain (`example.org`) to point out the name servers of the subdomain (`sub.example.org`).
* **SOA** (start of authority): contains required metadata about the DNS zone and its name servers.
* **MX** (mail exchange) record: used to set up a mail server.


---

*Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
