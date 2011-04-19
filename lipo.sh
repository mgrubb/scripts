#!/bin/sh
# snippet to strip an architecture from a file

IFS="
"
for i in `find . -type f`
do
	FOUND=`lipo -info "$i" 2>&1 | egrep '^Architectures in the fat file:'`
	if [ "x$FOUND" != "x" ] ; then
		echo $i
		lipo -o "${i}.noi386" -remove i386 "$i"
#		mv "${i}.noi386" "$i"
	fi
done
