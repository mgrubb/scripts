#!/bin/ksh
### Author: Michael Grubb <devel@dailyvoid.com>
### File: bin/toggle-ssh-config.sh
### Created: 2013-05-28 09:01
### Copyright: © 2013, Michael Grubb.  All rights reserved.
### Description: toggles ssh client config between locations

SSHDIR="${HOME}/.ssh"
LOC="$1"

if [ -h "${SSHDIR}/config" ]
then
  rm "${SSHDIR}/config"
elif [ -f "${SSHDIR}/config" ]
then
  echo "${SSHDIR}/config is not a symoblic link" >> "${HOME}/env.out"
  exit 1
fi

if [ -e "${SSHDIR}/config-${LOC}" ]
then
  cd "${SSHDIR}"
  ln -s "config-${LOC}" config
fi

# vim:sw=2:ts=2:sts=2:et:ai:
