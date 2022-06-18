#! /bin/sh

# this assumes we've set up raw messages already and such. If you haven't, then run ppk-base-station.sh once... 



#navigate to our directory if we're not there 
fullpath=$(readlink -f $0) 
dir=$(dirname $fullpath)
cd $dir 


# check to make sure we've compiled ntripserver
if [ ! -f ntripserver/ntripserver ] 
then 
make -C ntripserver
fi

# check to make sure we have the ntrip caster
if [ ! -f ntripcaster/src/ntripcaster ] 
then 
  git submodule init
  git submodule update 
  cd ntripcaster
  ./configure
  make
  cd ..
fi 

echo "Starting caster" 
# start the caster 
cd ntripcaster/src
./ntripcaster &> caster.log & 
cd ../.. 

# we need to grab the rtcm3 messages
gpspipe -R | str2str | ntripserver/ntripserver -M 3 -O 3 -m msf





