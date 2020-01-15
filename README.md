# My Awesome Blog

This blog was created using [Jekyll](https://jekyllrb.com/) and can be read at [sundin.github.io](https://sundin.github.io/).

## Requirements

**Ruby 2.7.0** (using RVM is recommended).

Instructions for installing Ruby with RVM:

    \curl -sSL https://get.rvm.io | bash -s stable
    rvm install 2.7.0
    rvm alias create default 2.7.0

**Jekyll**:

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

## Categories
You can list multiple categories for a single post by simply separating them with a space.

## TODO

* Spell-checking.
