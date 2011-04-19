#!/bin/sh
# use quicklook from the command line
exec /usr/bin/qlmanage -p $@ >&/dev/null
