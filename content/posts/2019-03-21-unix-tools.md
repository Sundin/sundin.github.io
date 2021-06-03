---
categories:
  - Workflow
date: "2019-03-21T13:33:20Z"
title: Unix Tools
---

What is commonly referred to as the **Unix tools** are a set of commands that are available on all Unix systems. Together, these form part of the basic toolkit for any serious software engineer. You should learn how to use these tools properly, as they can grant you an enormous boost in your daily workflow, and not the least when it comes to automating task and routines, such as in your team's automated CI pipeline.

# Commonly used Unix tools

Here you will find a subset of some of the most useful Unix commands.

## cat

    cat file1.txt

Outputs the contents of a given file.

## find

    find . -name README.md
    find . -name "*.txt"

Search through the given directory (and its subdirectories) for the given pattern (based on filename in the examples above).

## diff

    diff file1 file2

This command compares the contents of two files and displays the differences. You can also use `sdiff` to watch the difference side by side instead:

    sdiff file1 file2

## wc

    wc file1 file2

Displays the number of lines, words and characters respectively in the given file(s).

## sed

The `sed` command can be used in many different and powerful ways. Two of the most common usages are described below.

### Replacing

To replace all occurrences of "hello" with "goodbye":

    sed 's/hello/goodbye/' file1.txt > file2.txt

Note that you can use any regexp for the text you want to match.

### Filtering

The following command will display all lines containing "hello" from the file file1.txt:

    sed -n '/hello/p' file1.txt

## grep

    grep pattern file1 file2 ....

The `grep` command is used for searching through one or more files for a certain string or regexp.

Useful flags:

- `-c` (or `--count`): Count and display the number of results.
- `-i` (or `--ignore-case`): Case-insensitive search.
- `-l`(or `--files-with-matches`): Only show filenames of results. This will make the search faster, as the command will only have to find the first match in each file.
- `-n` (or `--line-number`): Show line numbers.
- `-r` (or `--recursive`): Make a recursive grep in any directories listed.
- `-v` (or `--invert-match`): Make an inverted search, i.e. show any lines not matching the given pattern.
- `-w` (or `--word-regexp`): Match only whole words.

# Putting it all together

One of the most powerful features of the Unix toolkit, indeed one of the very cornerstones of the entire [Unix philosophy](https://arp242.net/the-art-of-unix-programming), is that the output of one command can always act as the input of another. This enables you to chain multiple commands in order to produce the desired outcome.

The most commonly used operators are:

- **Piping**, also known as **filtering**: Simply put a `|` character between two commands in order to "pipe" the output of the first command into the next one.
- **Redirection**: Use the `>` character in order to redirect the output of the command on the left hand side into the file specified on the right hand side.
- **Sequential commands**: In order to run a series of commands independently but in sequence, use either the AND (`&&`) or the OR (`||`) operator. `&&` will run the second command only if the first command succeeded (i.e., returned 0 as its status code) and `||` will run the second command only if the first one failed.

Some examples are given below.

## Count results

Combine `find` and `wc` in order to count the number of `.txt` files in the current directory:

    find . -name "*.txt" | wc -l

Count the number of entries in your computer's ARP table:

    arp -a | wc -l

## Write output to file

Grab all lines containing "user" in file1.txt and write them to a new file:

    grep user file1.txt > newfile.txt

## Handle status codes

All Unix commands will normally return a status code of 0 as long the command terminated successfully. Make sure to follow this practice when you are writing your own scripts! Doing so will enable you to use the `&&` and `||` operators like this for instance:

    ./my_script.sh && echo "Success!"
    ./my_script.sh || echo "Fail"

# Further reading

Remember that you can always read the manual for any Unix command by typing `man <command>` into your terminal.
