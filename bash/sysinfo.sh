#!/bin/bash
if (($EUID > 0)); then
 echo "Admin privileges required to execute this script. Please log in as root/sudo."
 exit 1
else
 hostinfo=$(hostnamectl)
 fqdn=$(hostname)
 lshw=$(lshw -class system)
 lshwvendor=$(echo "$lshw" | grep 'vendor')
 compvendor=$(echo "$lshwvendor" | awk '!/Intel/' | cut -b 13-)
 compmodel=$(echo "$lshw" | grep 'description' | cut -b 18-)
 compserial=$(echo "$lshw" | grep 'serial' | cut -b 13-)
 lscpu=$(lscpu)
 cpumanu=$(echo "$lscpu" | grep 'Vendor' | awk '{getline} {print $3}')
 cpumodel=$(echo "$lscpu" | grep 'Model name' | cut -b 37-)
 cpuarch=$(echo "$lscpu" | grep 'Architecture' | awk '{getline} {print $2}')
 cpucore=$(echo "$lscpu" | grep 'Core(s)' | awk '{getline} {print $4}')
 cpuspeed=$(cat /proc/cpuinfo | grep MHz)
 cpul1d=$(lscpu | grep "L1d cache")
 cpul1i=$(lscpu | grep "L1i cache")
 cpul2=$(lscpu | grep "L2 cache")
 cpul3=$(lscpu | grep "L3 cache")
 #echo FQDN: $fqdn
 #df=$(df -h)
 #sda3=$(echo "$df" | grep '/dev/sda3')
 #freespace=$(echo "$sda3" | awk 'BEGIN {sum=0} {sum=sum+$4} END {print sum}')
 #echo "Root Filesystem Free Space: $freespace"'G'
 #ipaddress=$(hostname -I)
 #echo "Ip Addresse: $ipaddress"
 osinfo=$(hostnamectl)
 osversion=$(echo "$osinfo" | grep 'Operating')
 os=$(echo "$osversion" | awk '{getline} {print $3, $4}')
 distroname=$(echo "$osinfo" | grep 'Kernel')
 distrofullname=$(echo "$distroname" | awk '{getline} {print $2, $3}')
 distro=$(echo "$distrofullname" | cut -b 1-11)
 echo " "
 echo "Report for myvm"
 echo "===================="
 echo "***Computer Information***"
 if [[ -z "$lshw" ]];
 then
  echo "There is no available Computer Information to display"
 else
  echo "Computer Manufacturer: $compvendor"
  echo "Computer Description: $compmodel"
  echo "Computer Serial Number: $compserial"
 fi
 echo "***CPU Information***"
 if [[ -z "$lscpu" ]];
 then
  echo "There is no available CPU Information to display"
 else
  echo "CPU Manufacturer and Model: $cpumanu"", $cpumodel"
  echo "CPU Architecture: $cpuarch"
  echo "CPU Core Count: $cpucore"
  echo "CPU Max Speed:"
  echo "$cpuspeed"
  echo "CPU L1d Cache Size:$cpul1d"
  echo "CPU L1i Cache Size:$cpul1i"
  echo "CPU L2 Cache Size:$cpul2"
  echo "CPU L3 Cache Size:$cpul3"
 fi
 echo "***OS Information***"
 if [[ -z "$osinfo" ]];
 then
  echo "There is no available OS Information to display"
 else
  echo "Linux Distro and Version: $os"'/'"$distro"
 fi
 echo "===================="
 echo " "
fi
