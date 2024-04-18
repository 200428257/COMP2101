#!/bin/bash
options=":s:l"
longopt=("disk" "system" "network")
#Line  5-72 is a while loop giving multiple options to the system information script for easier usage of the script.
while getopts "options" opt; do
 case $opt in
  h)
    echo "$help"
    ;;
  v)
    echo "Entire script showing errors"
    errorlog
    computerreport
    cpureport
    osreport
    ramreport
    videoreport
    diskreport
    networkreport
    errormessage
    rm systeminfo.log
    ;;
  ?)
    echo "Invalid option: -${optarg}."
    exit 1
    ;;
  disk)
    echo " "
    echo "Report for myvm"
    echo "===================="
    errorlog
    diskreport
    errormessage
    ;;
  system)
    echo " "
    echo "Report for myvm"
    echo "===================="
    errorlog
    computerreport
    errormessage
    ;;
  network)
    echo " "
    echo "Report for myvm"
    echo "===================="
    errorlog
    networkreport
    errormessage
    ;;
 esac
else
 if (($EUID > 0)); then
  echo "Admin privileges required to execute this script. Please log in as root/sudo."
  exit 1
 else
  echo " "
  echo "Report for myvm"
  echo "===================="
  errorlog
  computerreport
  cpureport
  osreport
  ramreport
  videoreport
  diskreport
  networkreport
  errormessage
  echo "===================="
  echo " "
 fi
done
