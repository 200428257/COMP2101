#!/bin/bash
echo Host Information:
#Command Line 4 will show the Host information from the Name, IDs and Operating systems of the current device
	hostnamectl
#Command Line 6 will show the system's FQDN (Fully Qualified Domain Name)
	echo FQDN: `hostname --fqdn`
#Command Line 8 and 9 will show all available IPv4 and IPv6 addresses excluding those that starts with 127
	echo IP addresses:
	ip a s | grep 'inet' | grep -v ' 127.'
#Command Line 11 will show how much storage is used and available in the Root Filesystem
df -h /
exit
