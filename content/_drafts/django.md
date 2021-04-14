---
layout: post
title: ""
date_placeholder: 0
categories:
draft: true
---

Install python 3
Install pip

Create virtual python environment:

    python3 -m venv tutorial-env
    cd tutorial-env
    source bin/activate

Install Django:

    python -m pip install Django

Validate installation:

    python
    >>> import django
    >>> print(django.get_version())

django-admin startproject todo_api

python manage.py startapp todos
python manage.py migrate

---

Follow me with [RSS](https://sundin.github.io/feed.xml).

_Did I make a mistake? Please feel free to [issue a pull request to my Github repo](https://github.com/Sundin/sundin.github.io)._
