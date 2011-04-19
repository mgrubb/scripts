#!/bin/ksh
# setup a new environment from scratch
# this is incomplete but is a start.
# TODO: install macports and common ports
# TODO: install TexLive
# TODO: Update with other needed software
# TODO: Download vim setup

CORE_SERVICES="/System/Library/Frameworks/CoreServices.framework"
CORE_SERVICES="$CORE_SERVICES/Versions/Current"
LAUNCH_SERVICES="$CORE_SERVICES/Frameworks/LaunchServices.framework"
LAUNCH_SERVICES="$LAUNCH_SERVICES/Versions/Current"

PATH="$PATH:/usr/local/bin:/usr/local/sbin"
export PATH

cd $HOME

## Pre-authorize with sudo for administrative tasks
sudo -l -p "Enter password for administrative tasks: " >/dev/null

## Setup /usr/local
sudo mkdir -p /usr/local/bin /usr/local/sbin /usr/local/share/man
cd /usr/local
sudo ln -s share/man man
cd $HOME

# Create links for certain utilities

if [ -f $LAUNCH_SERVICES/Support/lsregister ] ; then
	sudo ln -sf $LAUNCH_SERVICES/Support/lsregister /usr/bin/lsregister
else
	echo "Could not find lsregister... skipping"
fi

if [ -f $LAUNCH_SERVICES/Support/lssave ] ; then
	sudo ln -sf $LAUNCH_SERVICES/Support/lssave /usr/bin/lssave
else
	echo "Could not find lssave... skipping"
fi

## Setup home directory structure
for d in bin Library/Programs Downloads
do
	[ -d $HOME/$d/. ] || mkdir $HOME/$d
done

[ -d /usr/local/. ] || sudo mkdir /usr/local

## Setup /usr/local
for i in share share/man share/man/man1 bin sbin etc
do
	[ -d /usr/local/$i/. ] || sudo mkdir /usr/local/$i
done

## Download utilities
cd $HOME/Downloads

#->http://www.cs.indiana.edu/~kinzler/z/
curl -O http://www.cs.indiana.edu/~kinzler/z/z-2.6.1.tgz

#->http://www.cs.indiana.edu/~kinzler/align/
curl -O http://www.cs.indiana.edu/~kinzler/align/align-1.7.1.tgz

#->http://www.cs.indiana.edu/~kinzler/home/binp/vip
curl http://www.cs.indiana.edu/~kinzler/home/binp/vip > $HOME/bin/vip.tmp

#->http://web.sabi.net/nriley/software/appswitch-1.1.tar.gz
curl -O http://web.sabi.net/nriley/software/appswitch-1.1.tar.gz

# install z
tar xf z-2.6.1.tgz 

cd z-2.6.1
sudo make install
sudo make install.man
cd ..
rm -Rf z-2.6.1*

# install align
cd `z align-1.7.1.tgz`
sudo make install
cd ..
rm -Rf align-1.7.1*

# fix vip
cat $HOME/bin/vip.tmp | \
	sed -e 's,^\(: .*TMPDIR.*\)/usr/tmp,\1/tmp,g' > $HOME/bin/vip
rm $HOME/bin/vip.tmp
chmod +x $HOME/bin/vip

# install appswitch
cd `z appswitch-1.1.tar.gz`
sudo mv appswitch /usr/local/bin
sudo mv appswitch.1 /usr/local/share/man/man1
cd ..
rm -Rf appswitch-1.1*
