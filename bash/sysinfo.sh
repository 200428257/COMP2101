
#!/bin/bash
#Line 3 Stores the output of the hostnamectl command which gives information on the host's machine such as the Static hostname, Machine ID, OS, etc.... Into a variable
hostinfo=$(hostnamectl)
#Line 5 is a command that will store the FQDN of the machine into a variable.
fqdn=$(hostname)
echo " "
echo "Report for myvm"
echo "===================="
#Line 10 will display the information stored in the variable.
echo FQDN: $fqdn
#Line 12 is similar to line 5 but for the df output.
df=$(df -h)
#Line 14 and 15 are both extracting specific lines of data within the df variable using the Grep command and storing it in their own variables for further use.
sda3=$(echo "$df" | grep '/dev/sda3')
freespace=$(echo "$sda3" | awk 'BEGIN {sum=0} {sum=sum+$4} END {print sum}')
#Line 18 and 19 does the same as Line 10 with different variable.
echo "Root Filesystem Free Space: $freespace"'G'
#Line 21 stores all the machine IP Adresses in a variable, it will store both ipv4 and ipv6. However mine only has a ipv4.
ipaddress=$(hostname -I)
# Line 23 does the same as Line 10 but with different variable
echo "Ip Addresse: $ipaddress"
osinfo=$(hostnamectl)
osversion=$(echo "$osinfo" | grep 'Operating')
os=$(echo "$osversion" | awk '{getline} {print $3, $4}')
distroname=$(echo "$osinfo" | grep 'Kernel')
distrofullname=$(echo "$distroname" | awk '{getline} {print $2, $3}')
distro=$(echo "$distrofullname" | cut -b 1-11)
echo "Operating System name and Version: $os"'/'"$distro"
echo "===================="
echo " "
