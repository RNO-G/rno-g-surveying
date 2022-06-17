#! /bin/sh 

#usage: ./ppk_base_station.sh [outfile.ubx = `date -Is`.ubx"] [nsecs] 

# load the setup 
fullpath=$(readlink -f $0) 
fulldir=$(dirname $fullpath) 
. ${fulldir}/setup.sh 


out=`date -Is`.ubx 
if [ $# -gt 0 ] ; 
then 
  out=$1 
fi 

opts=""
if [ $# -gt 1 ]; 
then
  echo "Will run for $2 seconds" 
  opts="-x $2"
fi 





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
  ${ubx} -e $enabled  -w 0 > /dev/null
done 

echo "Enabling raw messages" 
${ubx} -e RAWX  > /dev/null

echo "Enabling epheremides output" 
${ubx} -p CFG-MSG,2,19,20 # every 20 seconds

 

echo "Starting data taking, writing to $out" 
gpspipe -R $opts > $out

