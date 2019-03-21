---
layout: post
title: ""
date_placeholder: 0
categories: 
---

UNIX TOOLS

# Commonly used Unix tools

## cat
    cat file1.txt

Outputs the contents of a given file.

## find
    find . -name README.md

    find . -name "*.txt"

Search through the given directory (and its subdirectories) for the given pattern (filename in the examples above).

## diff 
    diff file1 file2

This command compares the contents of two files and displays the differences. 

## wc
    wc file1 file2

Displays the number of lines, words and characters respectively in the given file(s).

## sed
The `sed` command can be used in many different and powerful ways. Two of the most common usages are described below.

### Replacing
To replace all occurences of "hello" with "goodbye":
    sed 's/hello/goodbye/' file1.txt > file2.txt

Note that you can use any regexp for the text you want to match.

### Filtering
The following command will display only lines containing "hello":
    sed -n '/hello/p' file1.txt


## grep
    grep pattern file1 file2 ....

The `grep` command is used for searching through one or more files for a certain string or regexp.

Useful flags:
* `-c` (or `--count`): Count and display the number of results.
* `-i` (or `--ignore-case`): Case-insensitive search.
* `-l`(or `--files-with-matches`): Only show filenames of results. This will make the search faster, as the command will only have to find the first match in each file. 
* `-n` (or `--line-number`): Show line numbers.
* `-r` (or `--recursive`): Make a recursive grep in any directories listed.
* `-v` (or `--invert-match`): Make an inverted search, i.e. show any lines not matching the given pattern.
* `-w` (or `--word-regexp`): Match only whole words.


# Putting it all together

pipe
>
status codes (0 = success)
man


## Count results
Combine find and wc:

    find . -name "*.txt" | wc -l

    arp -a | wc -l



---

*Did I make a mistake? Please feel free to correct me by [issuing a pull request to my Github repo](https://github.com/Sundin/sundin.github.io).*
