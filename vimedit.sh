#!/bin/ksh
# Wrapper for MacVim on the command line, for use in the EDITOR variables
/usr/bin/gvim --nomru -f "$@"
/usr/local/bin/appswitch -f -a iTerm
