#!/bin/bash
#Command Line 3 will launch a ubuntu 22.04 container called COMP2101-S22.
lxc launch ubuntu:22.04 COMP2101-S22
hostname='COMP2101-S22'
#Command Line 6 will Paste the output of the "lxc network show lxdbr0" into the containerinfo.txt text file.
lxc network show lxdbr0>>~/COMP2101/bash/containerinfo.txt
#Command Line 8 will store the specific data in the text file into the "ipaddress" variable for later usage.
ipaddress=$(awk '/ipv4.address/ {print $2}' ~/COMP2101/bash/containerinfo.txt)
#Command Line 10 will paste both content in variable "hostname" and "ipaddress" into the /etc/hosts file.
sudo -- sh -c "echo '$ipaddress  $hostname'>>/etc/hosts"
#Command Line 12 will cut the last few characters in the ipaddress variable content and store it in the "secondip" variable.
secondip=$(echo $ipaddress | cut --complement -c 12-14)
#Command Line 14 will paste the word 'nameserver' and the content of "secondip" variable in the /etc/resolv.conf file.
sudo -- sh -c "echo 'nameserver   $secondip'>>/etc/resolv.conf"
#Command Line 16 will install curl... not much more nees to be said.
sudo apt install curl
#Command Line 18 will test the conection with https://COMP2101-S22 and will inform us if it succeeded or failed.
curl https://COMP2101-S22
#Command Line 20 will erase all data in the containerinfo.txt file to avoid mixing old and new info.
sed -i 'd' ~/COMP2101/bash/containerinfo.txt
