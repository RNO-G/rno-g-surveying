#! /bin/sh 

# load the setup 
fullpath=$(readlink -f $0) 
fulldir=$(dirname $fullpath) 
. ${fulldir}/setup.sh 

dur=${1-60} 
acc=${2-200000} 


${ubx} -d NMEA > /dev/null

echo "Starting SURVEY IN" 
${ubx} -e SURVEYIN3,$dur,$acc -w 0 > /dev/null

echo "Waiting until valid" 
#wait until valid 
while true ; 
do 
  sleep 1 
  echo -n "." 
  ${ubx} -p NAV-SVIN  | grep "valid 1 active 0" && break 
done

echo "Done!" 

