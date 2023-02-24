#!/bin/bash
snap install lxd
lxd launch | lxc init COMP2101-S22
hostname='COMP2101-S22'
lxc network show lxdbr0>>~/COMP2101/bash/containerinfo.txt
ipaddress=$(awk '/ipv4.address/ {print $2}' ~/COMP2101/bash/containerinfo.txt)
sudo -- sh -c "echo '$ipaddress  $hostname'>>/etc/hosts"
secondip=$(echo $ipaddress | cut --complement -c 12-14)
sudo -- sh -c "echo 'nameserver   $secondip'>>/etc/resolv.conf"
sudo apt install curl
curl https://COMP2101-S22
sed -i 'd' ~/COMP2101/bash/containerinfo.txt
