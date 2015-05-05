#!/bin/ksh
# Wrapper for MacVim on the command line, for use in the EDITOR variables
/usr/local/bin/mvim -c 'au VimLeave * call system("open -a iTerm")' -f "$@"
