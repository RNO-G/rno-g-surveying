#! /bin/sh 

# load the setup 
fullpath=$(readlink -f $0) 
fulldir=$(dirname $fullpath) 
. ${fulldir}/setup.sh 

dur=${1-60} 
acc=${2-200000} 


${ubx} -d NMEA

echo "Starting SURVEY IN" 
${ubx} -e SURVEYIN3,$dur,$acc

#wait until valid 
while 1 ; 
do 
  sleep 3 
  ${ubx} -p NAV-SVIN  | grep "valid 1 active 0" && break 
done

