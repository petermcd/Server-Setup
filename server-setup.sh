#!/usr/bin/env bash

#First update the system
yum upgrade -y
yum -y install wget git
yum install epel* -y
yum upgrade -y

source ./helpers/functions.sh

#Enable the firewall
yum install firewalld -y
enableService firewalld
firewall-cmd --reload

echo "Server: " hostname -f >> ./emailFile.txt

fileString=`ls *.sh`
#echo $fileString
fileArray=$(echo $fileString | tr " " "\n")
for file in $fileArray
do
    source ./server-setup/$file
done

#todo email the results from emailFile.txt