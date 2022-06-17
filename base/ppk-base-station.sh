#! /bin/sh 

if [ $# -lt 1 ] 
then 
  echo "Usage: ./ppk_base_station.sh outfile.rtcm3"
  exit 1 
fi

# load the setup 
fullpath=$(readlink -f $0) 
fulldir=$(dirname $fullpath) 
. ${fulldir}/setup.sh 




${ubx} -d NMEA > /dev/null
${ubx} -e BINARY > /dev/null

for disabled in "${disabled_constellations}" ; 
do 
  ${ubx} -d $disabled > /dev/null
done 
 
for enabled in "${enabled_constellations}" ; 
do 
  ${ubx} -e $enabled > /dev/null
done 

${ubx} -e RAWX  > /dev/null
 
#done setting up GPS, maybe? 

str2str -in serial://${device}#ubx -out $1 
