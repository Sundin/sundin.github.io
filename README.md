# My Awesome Blog

This blog was created using [Jekyll](https://jekyllrb.com/).

## Requirements

Ruby (using RVM is recommended)

Jekyll:

    gem install bundler jekyll

## Setup
Install gems with:
    bundle install

## Running locally 
    bundle exec jekyll serve

The site is now running at `http://localhost:4000`. Refresh the page in your browser to see changes.

## Drafts
Drafts are posts without a date in the filename. They’re posts you’re still working on and don’t want to publish yet.

Create a new draft with the following command:

    ./new-draft.sh <post-title>

When you are happy with your post, move it to the `_posts` folder with the following command:

    ./publish-post.sh <post-title>

To preview your site with drafts, simply run: 

    bundle exec jekyll serve --drafts

Each will be assigned the value modification time of the draft file for its date, and thus you will see currently edited drafts as the latest posts.

## TODO

* Spell-checking.
