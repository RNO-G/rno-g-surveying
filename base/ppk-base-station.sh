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




echo "Making sure binary" 
${ubx} -d NMEA -w 0 > /dev/null
${ubx} -e BINARY -w 0 > /dev/null

for disabled in ${disabled_constellations} ; 
do 
  echo "Disabling $disabled" 
  ${ubx} -d $disabled -w 0 > /dev/null
done 
 
for enabled in "${enabled_constellations}" ; 
do 
  echo "Enabling $enabled" 
  ${ubx} -e $enabled  -w 0> /dev/null
done 

${ubx} -e RAWX  > /dev/null
 
#done setting up GPS, maybe? 

echo "Starting data" 
str2str -in serial://${device}#ubx -out $1 
