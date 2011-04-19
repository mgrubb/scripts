#!/bin/sh
###############################################################################
# Author: Michael Grubb - mgrubb
#
# Purpose: This script provides serves both a concrete and abstract
#	example of how to define a forced command wrapper for SSH-1 & SSH-2
#
# Details: This forced command wrapper will examine the basename of the
#	requested command, and compare it to a list of well-known shell names.
#	If the request is for a well-known shell then it will be denied.
###############################################################################

# SSH-1 and SSH-2 use different variables
# This normalizes the data into one variable.
SSH_COMMAND="${SSH2_ORIGINAL_COMMAND}"
if [ "${SSH_COMMAND}x" = "x" ] ; then
        SSH_COMMAND="${SSH_ORIGINAL_COMMAND}"
fi

BASE="`basename ${SSH_COMMAND}`"
case "${BASE}" in
        ksh|bash|csh|tcsh|jsh|pfcsh|zsh|sh|pfsh|pfksh|.)
                echo "Shells are not allowed!"
                exit
        ;;
        *)
				# Use exec here so that there's not a spare shell process
				# lingering around.
                exec ${SSH_COMMAND}
        ;;
esac

## vi:ts=4 sw=4
