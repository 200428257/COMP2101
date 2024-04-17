#!/bin/bash
#Line 3 creates a function named cpureport.
cpureport() {
 lscpu=$(lscpu)
#Line 6 will check if the variable $lscpu is empty or not. If it is, it will execute line 9-10, if it's not then it will proceed to execute line 13-30.
 if [[ -z "$lscpu" ]];
 then
#Line 9 will execute the timestamp function (Found near the end of this script) and store the output and the string into the log file that is created further down this script.
  timestamp "There is no available CPU Information to display">>systeminfo.log
  exit 1
 else
#Line 13-21 store specific data from command outputs into variables.
  cpumanu=$(echo "$lscpu" | grep 'Vendor' | awk '{getline} {print $3}')
  cpumodel=$(echo "$lscpu" | grep 'Model name' | cut -b 37-)
  cpuarch=$(echo "$lscpu" | grep 'Architecture' | awk '{getline} {print $2}')
  cpucore=$(echo "$lscpu" | grep 'Core(s)' | awk '{getline} {print $4}')
  cpuspeed=$(cat /proc/cpuinfo | grep MHz)
  cpul1d=$(lscpu | grep "L1d cache")
  cpul1i=$(lscpu | grep "L1i cache")
  cpul2=$(lscpu | grep "L2 cache")
  cpul3=$(lscpu | grep "L3 cache")
  echo "***CPU Information***"
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
}
computerreport() {
#Line 35 stores the lshw command output specifically related to the system.
 lshw=$(lshw -class system)
 echo " "
 echo "Report for myvm"
 echo "===================="
 if [[ -z "$lshw" ]];
 then
  timestamp "There is no available Computer Information to display">>systeminfo.log
  exit 1
 else
  lshwvendor=$(echo "$lshw" | grep 'vendor')
  compvendor=$(echo "$lshwvendor" | awk '!/Intel/' | cut -b 13-)
  compmodel=$(echo "$lshw" | grep 'description' | cut -b 18-)
  compserial=$(echo "$lshw" | grep 'serial' | cut -b 13-)
  echo "***Computer Information***"
  echo "Computer Manufacturer: $compvendor"
  echo "Computer Description: $compmodel"
  echo "Computer Serial Number: $compserial"
 fi
}
osreport() {
 osinfo=$(hostnamectl)
 if [[ -z "$osinfo" ]];
 then
  timestamp "There is no available OS Information to display">>systeminfo.log
  exit 1
 else
  osversion=$(echo "$osinfo" | grep 'Operating')
  os=$(echo "$osversion" | awk '{getline} {print $3, $4}')
  distroname=$(echo "$osinfo" | grep 'Kernel')
  distrofullname=$(echo "$distroname" | awk '{getline} {print $2, $3}')
  distro=$(echo "$distrofullname" | cut -b 1-11)
  echo "***OS Information***"
  echo "Linux Distro and Version: $os"'/'"$distro"
 fi
}
ramreport() {
 memtotal=$(grep MemTotal /proc/meminfo | cut -b 18-)
 meminfo=$(cat /proc/meminfo)
 raminfo=$(dmidecode -t memory)
 if [[ -z "$raminfo" ]];
 then
  timestamp "There is no available RAM Information to display">>systeminfo.log
  exit 1
 else
  rammanu=$(echo "$raminfo" | grep Manufacturer: | cut -b 16-)
  rammodel=$(echo "$raminfo" | grep 'Part Number:'| cut -b 15-)
  ramsize=$(echo "$raminfo" | grep Size: | awk '!/Enabled/' | awk '!/Installed/' | awk '!/Maximum/' | cut -b 8-)
  ramspeed=$(echo "$raminfo" | grep Speed: | awk '!/Current/' | awk '!/Configured/' | cut -b 9-)
  ramloc=$(echo "$raminfo" | grep Locator: | awk '!/Bank/' | cut -b 11-)
  echo "***RAM Information***"
  echo "RAM Manufacturer: $rammanu"
  echo "RAM Model: $rammodel"
  echo "RAM Size: $ramsize"
  echo "RAM Speed: $ramspeed"
  echo "RAM Physical Location: $ramloc"
  echo "RAM Total Size: $memtotal"
 fi
}
videoreport() {
 gpuinfo=$(lshw -numeric -C display)
 if [[ -z "$gpuinfo" ]];
 then
  timestamp "There is no available GPU Information to display">>systeminfo.log
  exit 1
 else
  gpumanu=$(echo "$gpuinfo" | grep 'vendor:' | cut -b 16-)
  gpumodel=$(echo "$gpuinfo" | grep 'product:' | cut -b 17-)
  echo "***GPU Information***"
  echo "GPU Manufacturer: $gpumanu"
  echo "GPU Model: $gpumodel"
 fi
}
diskreport() {
 diskinfo=$(lshw -c disk)
 if [[ -z "$diskinfo" ]];
 then
  timestamp "There is no available Driver Information to display">>systeminfo.log
  exit 1
 else
  diskpar=$(echo "$diskinfo" | grep 'physical id:')
  diskmanu=$(echo "$diskinfo" | grep 'vendor' | cut -b 15-)
  diskmodel=$(echo "$diskinfo" | grep 'product' | cut -b 17-)
  disksize=$(echo "$diskinfo" | grep 'size:' | cut -b 14-)
  diskmount=$(echo "$diskinfo" | grep 'logical name:')
  filesystem=$(df -H | awk '{print $1, $2, $4}')
  echo "***Storage Drive Information***"
  echo "Drive Manufacturer: $diskmanu"
  echo "Drive Model: $diskmodel"
  echo "Drive Size: $disksize"
  echo "Partition Number: $diskpar"
  echo "Disk Mount Point: $diskmount"
  echo "Filesystem Size and Free Space:"
  echo "$filesystem"
 fi
}
networkreport() {
 networkinfo=$(lshw -C network)
 if [[ -z "$networkinfo" ]];
 then
  timestamp "There is no available Network Information to display">>systeminfo.log
  exit 1
 else
  netvendor=$(echo "$networkinfo" | grep 'vendor:' | cut -b 16-)
  netmodel=$(echo "$networkinfo" | grep 'product:' | cut -b 17-)
  netlink=$(lspci | grep -E -i --color 'network|ethernet')
  netspeed=$(echo "$networkinfo" | grep 'clock:' | cut -b 15-)
  netip=$(hostname -i)
  netcidr=$(echo "$networkinfo" | grep 'irq:' | cut -b 23-25)
  ipbridge=$(ip link show type bridge)
  netdns=$(cat /etc/resolv.conf|grep -im 1 '^nameserver' |cut -d '' -f2)
  echo "***Network Information***"
  echo "Interface Manufacturer: $netvendor"
  echo "Interface Model: $netmodel"
  echo "Interface link state: $$netlink"
  echo "Interface Speed: $netspeed"
  echo "Interface IP Addresses: $netip""/$netcidr"
  echo "Interface Bridge: $ipbridge"
  echo "DNS: $netdns"
 fi
}
timestamp() {
#line 157 executes a Date and Time command.
 date +"%T"
}
errormessage() {
#Line 161 Reads the content in the system.log file.
 read /var/log/systeminfo.log
}
errorlog() {
#Line 165 creates the systeminfo.log file.
 touch /var/log/systeminfo.log
}
