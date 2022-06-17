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




${ubx} -d NMEA
${ubx} -e BINARY

for disabled in "${disabled_constellations}" ; 
do 
  ${ubx} -d $disabled
done 
 
for enabled in "${enabled_constellations}" ; 
do 
  ${ubx} -e $enabled
done 

${ubx} -e RAWX 
 
#done setting up GPS, maybe? 

str2str -in serial://${device}#ubx -out $1 
