#!/bin/bash
echo   
#Command Line 4 will store the hostname in the myvm variable.
myvm=$(hostname)
#Command Line 6 will display the message and use the stored content of the myvm variable.
echo "System Report for" $myvm
echo "============================================="
#Command Line 9 will input the Host information from the Name, IDs and Operating systems of the current device into the hostinfo.txt file
	hostnamectl>>~/COMP2101/bash/hostinfo.txt
#Command Line 11 will store the line containing the word "Operating" 
	osversion=$(awk '/Operating/ {print}' ~/COMP2101/bash/hostinfo.txt)
#Command Line 13 will show the system's FQDN (Fully Qualified Domain Name)
	echo FQDN: `hostname --fqdn`
#Command Line 15 will display the content stored in the osversion variable.
	echo $osversion
#Command Line 17 and 18 will store the ip address that connects the host to the internet in the ipaddress variable, then it will display the message along with the stored content of the ipaddress variable.
	ipaddress=$(hostname -I)
	echo "IP addresses: " $ipaddress
#Command Line 20 will store how much storage is used and available in the Root Filesystem into the hostinfo.txt file.
	df -h />>~/COMP2101/bash/hostinfo.txt
#Command Line 22 will store the data of the 4th column of the row containing "/dev/" into the storgae variable.
	storage=$(awk '/dev/ {print $4}' ~/COMP2101/bash/hostinfo.txt)
#Command Line 24 will display the message along with the content of the storage variable.
	echo "Root Filesystem Free Space: " $storage
echo "============================================="
echo   
#Command line 28 will delete everything in the hostinfo.txt file before ending the script.
sed -i 'd' ~/COMP2101/bash/hostinfo.txt
exit
