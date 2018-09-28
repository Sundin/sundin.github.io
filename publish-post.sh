#!/bin/sh

if [ -z $1 ]; then
   echo "You must pass a filename as argument"
   exit -1
fi

DATE=`date +%Y-%m-%d`

FILENAME=$DATE-$1.md

mv _drafts/$1.md _posts/$FILENAME

cd _posts

STRINGTOREPLACE="dddd: a date will be inserted here by the ./publish-post.sh script"
EXACTDATE=`date '+%Y-%m-%d %H:%M:%S %z'`

sed -i '' "s/${STRINGTOREPLACE}/date: ${EXACTDATE}/g" ${FILENAME}
