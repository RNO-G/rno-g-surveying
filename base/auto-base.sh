#! /bin/sh 

# This takes data in 1 hour chunks, comrpesses, copies to server, and deletes

user=rno-g
host=rno-g
destbase=/data/gps-base/auto-base

fullpath=$(readlink -f $0) 
fulldir=$(dirname $fullpath)

while true ; 
do 
out=`date -u "+%Y/%m/%d/%Y-%m-%d.%H%M%S"`.ubx 
echo $out
dir=$(dirname ${out})
echo $dir
f=$(basename ${out}) 
mkdir -p $dir
${fulldir}/ppk-base-station.sh $out 3600 
gzip $out
ssh $user@$host "mkdir -p $destbase/$dir"
rsync -a $out.gz $user@$host:$destbase/$dir && rm $out.gz && rmdir -p $dir
done 

  


