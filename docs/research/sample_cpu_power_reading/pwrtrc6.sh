#!/bin/bash
#Time and power units in watts and seconds 
#Extracted from MSR_RAPL_POWER_UNIT Register (606)
exponent=`sudo rdmsr -p 0 --bitfield 3:0 -d 0x00000606`
fraction=`wcalc .5/2^$exponent | cut -b 4-`
echo " power fraction of watt "$fraction
tu=`sudo rdmsr -p 0 --bitfield 19:16 -u 0x00000606`
zeit=`wcalc 1/2^$tu | cut -b 4-`

esu=`sudo rdmsr -p 0 --bitfield 12:8 -u 0x00000606 `
energy=`wcalc .5/2^$esu | cut -b 4-`
echo zeit$zeit tu$tu
echo energy$energy esu$esu
echo fraction$fraction

deltat=$1
timesteps=`wcalc $deltat/$zeit | cut -b 4-`
timescale=`wcalc 1024/$timesteps | cut -b 4-`
#scale=`wcalc $energy"*"$fraction"*"$timescale | cut -b 4-`
scalecpu=`wcalc $timescale"*"$energy | cut -b 4-`
scalemem=`wcalc $timescale"*"$energy/4 | cut -b 4-`
echo scalecpu$scalecpu scalemem$scalemem timesteps$timesteps
#
#loop wait and measure
while [ 0 -eq 0 ]  ; do

#power measure counter per package and per memory 
pwrp0t0=`sudo rdmsr -p 0 --bitfield 31:0 -u 0x00000611`
pwrm0t0=`sudo rdmsr -p 0 --bitfield 31:0 -u 0x00000619`
pwrp1t0=`sudo rdmsr -p 18 --bitfield 31:0 -u 0x00000611`
pwrm1t0=`sudo rdmsr -p 18 --bitfield 31:0 -u 0x00000619`
sleep $deltat
pwrp0t1=`sudo rdmsr -p 0 --bitfield 31:0 -u 0x00000611`
pwrp1t1=`sudo rdmsr -p 18 --bitfield 31:0 -u 0x00000611`
pwrm0t1=`sudo rdmsr -p 0 --bitfield 31:0 -u 0x00000619`
pwrm1t1=`sudo rdmsr -p 18 --bitfield 31:0 -u 0x00000619`
# calculate the rate on a per hour basis to get watt hour
wattratep1=`wcalc $pwrp1t1"*"$scalecpu-$pwrp1t0"*"$scalecpu | cut -b 4-` 
wattratep0=`wcalc $pwrp0t1"*"$scalecpu-$pwrp0t0"*"$scalecpu | cut -b 4-`
wattratem0=`wcalc $pwrm0t1"*"$scalemem-$pwrm0t0"*"$scalemem | cut -b 4-`
wattratem1=`wcalc $pwrm1t1"*"$scalemem-$pwrm1t0"*"$scalemem | cut -b 4-`

echo $wattratep0 $wattratep1 $wattratem0 $wattratem1

done

exit
