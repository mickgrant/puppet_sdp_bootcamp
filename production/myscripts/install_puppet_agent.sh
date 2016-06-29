#!/bin/bash

PEMASTER=$1
HOSTFILE=$2

if [ -z "$1" ]
then
  echo "Please specify a Puppet Enterprise Master hostname or IP"
  exit 1
fi

if [ -z "$2" ]
then
  echo "Please specify a file with a list of target hostnames"
  exit 1
fi

if [ ! -f "$2" ]
then
  echo "Host file does not exist, exiting.."
  exit 1
fi

# Copy Curl script
echo " ### Copying Puppet Agent install script to your hosts.."
pscp -vA -h $HOSTFILE -p 5 curl_puppet_agent.sh /tmp

# run PSSH, run curl script
echo " ### Installing Puppet Agent on your hosts.."
pssh -A -h $HOSTFILE -l root -O StrictHostKeyChecking=no -i "chmod +x /tmp/curl_puppet_agent.sh && bash /tmp/curl_puppet_agent.sh ${PEMASTER}"

