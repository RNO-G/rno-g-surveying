#! /bin/sh

# this assumes we've set up raw messages already and such. If you haven't, then run ppk-base-station.sh once... 



#navigate to our directory if we're not there 
fullpath=$(readlink -f $0) 
dir=$(dirname $fullpath)
cd $dir 

# check to make sure we've compiled ntripserver
make -C ntripserver

# we need to grab the rtcm3 messages
gpsipe -R | str2str | ntripserver/ntripserver -M 3 -O 1





