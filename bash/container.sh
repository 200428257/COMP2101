#!/bin/bash
snap install lxd
lxc launch ubuntu:22.04 COMP2101-S22
hostname='COMP2101-S22'
lxc network show lxdbr0>>~/COMP2101/bash/containerinfo.txt
ipaddress=$(awk '/ipv4.address/ {print $2}' ~/COMP2101/bash/containerinfo.txt)
echo $ipaddress
sudo -- sh -c "echo '$ipaddress  $hostname'>>/etc/hosts"
sudo apt install curl
curl https://COMP2101-S22
sed -i 'd' ~/COMP2101/bash/containerinfo.txt
