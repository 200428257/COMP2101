#!/bin/bash
#Line 3 is a command that will give information on the host's machine such as the Static hostname, Machine ID, OS, etc....
hostnamectl
#Line 5 is a command that will store the FQDN of the machine into a variable.
fqdn=$(hostname)
#Line 7 will display the information stored in the variable.
echo FQDN: $fqdn
#Line 9 is similar to line 5 but for the df output.
df=$(df -h)
#Line 11 and 12 are both extracting specific lines of data within the df variable using the Grep command and storing it in their own variables for further use.
filesystem=$(echo "$df" | grep 'Filesystem')
sda3=$(echo "$df" | grep '/dev/sda3')
echo "Root Filesystem Status:"
#Line 15 and 16 does the same as Line 7.
echo "$filesystem"
echo "$sda3"
echo "IP Addresses:"
#Line 19 displays all the machine IP Adresses, it will show both ipv4 and ipv6. However mine only has a ipv4.
hostname -I
