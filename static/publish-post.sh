#!/bin/sh

if [ -z $1 ]; then
   echo "You must pass a filename as argument"
   exit -1
fi

DATE=`date +%Y-%m-%d`

FILENAME=$DATE-$1.md

mv _drafts/$1.md _posts/$FILENAME

cd _posts

STRINGTOREPLACE="date_placeholder: 0"
EXACTDATE=`date '+%Y-%m-%d %H:%M:%S %z'`

sed -i '' "s/${STRINGTOREPLACE}/date: ${EXACTDATE}/g" ${FILENAME}
