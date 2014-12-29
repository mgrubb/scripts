#!/bin/ksh
### Author: Michael Grubb <michael@grubb.co>
### File: pwkeychain.sh
### Created: 2014-11-13 13:12
### Copyright: © 2014, Michael Grubb.  All rights reserved.
### Description: Change Keychain Passwords

stty -echo
echo -n "Current Password: "
read CPASS
echo

trap 'stty echo' EXIT

NPASS=""
NPASSC="1"

while [ "$NPASS" != "$NPASSC" ]
do
  echo -n "New Password: "
  read NPASS
  echo
  echo -n "Confirm Password: "
  read NPASSC
  echo

  if [ "$NPASS" != "$NPASSC" ]
  then
    echo "Passwords don't match"
  fi
done

for i in $HOME/Library/Keychains/*.keychain
do
  base=$(basename "$i")
  name=$(basename "$i" .keychain)

  if [ "$base" != "login.keychain" -a "$base" != "metadata.keychain" ]
  then
    echo "Changing Password for $name"
    security unlock-keychain -p "$CPASS" "$i" \
      && security set-keychain-password -o "$CPASS" -p "$NPASS" "$i" \
      && security lock-keychain "$i"
  fi
done
# vim:sw=2:ts=2:sts=2:et:ai:
