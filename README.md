# Master of Software Engineering

This is my blog.

## Running locally

    hugo server

The site is now running at `http://localhost:1313`.

## Installation

Install hugo using homebrew:

    brew install hugo

Get submodules:

    git submodule init
    git submodule update

## Usage

Create a new blog post draft:

    hugo new content/_drafts_/my-first-post.md

Start server with drafts enabled:

    hugo server -D

## Spell check

    npm install -g yaspeller

    yaspeller .

Configure in `.yaspellerrc`.

## Internal Links

To link to another post on the blog:

    [some link text]({{< relref "some-post.md" >}})

Or (assuming the posts are in the same folder):

    [some link text](../slug-to-some-post)

## Images

This links to an image in the `/static` folder.

    ![Image caption](/image.png)

## Add theme or other module

    cd themes

    git submodule add https://github.com/vimux/mainroad
