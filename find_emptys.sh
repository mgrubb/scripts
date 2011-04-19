#!/bin/sh

### Author: Michael Grubb
### File:   /Users/mgrubb/bin/utils/find_emptys.sh
### Description: find_emptys.sh -- Determines if a directory is empty
### Copyright: (C) 2010, Michael Grubb
### Modeline: vim:tw=79:sw=4:ts=4:ai:
### Description: This is used with find -exec to search a directory tree
###		for empty directories and output the list.

dir=$1

count=`ls -1 $dir | wc -l | sed -e 's/[ 	]*//g'`

if [ "$count" = "0" ]
then
	echo "$dir"
fi

