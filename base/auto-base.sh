#! /bin/sh 

# This takes data in 1 hour chunks, comrpesses, copies to server, and deletes

user=rno-g
host=rno-g
destbase=/data/gps-base/auto-base

while true ; 
do 
out=`date -u "+%Y/%m/%d/%Y-%m-%d.%H%M%S"`.ubx 
dir= $(dirname ${out})
f=$(basename ${out}) 
mkdir -p $dir
./ppk_base_station.sh $out 3600 
gzip $out
ssh $user@$host "mkdir -p $destbase/$dir"
rsync -a $out.gz $user@$host:$destbase/$dir && rm $out && rmdir -p $dir

done 

  


