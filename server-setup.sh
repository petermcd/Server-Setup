#!/bin/bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Server$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

source ./helpers/functions.sh
{
#First update the system
yum upgrade -y
yum -y install wget git
yum install epel* -y
yum upgrade -y

#Enable the firewall
yum install firewalld -y
enableService firewalld
firewall-cmd --reload

ipString=`hostname -I`
ipArray=$(echo $ipString | tr " " "\n")
ip4=""
ip6=""
for ip in $ipArray
do
        if [[ $ip =~ ":" ]]
        then
                ip6=$ip
        else
                ip4=$ip
        fi
done
echo "Server: " `hostname -f` >> ./emailFile.txt
echo "IPv4: " $ip4 >> ./emailFile.txt
echo "IPv6: " $ip6 >> ./emailFile.txt

fileString=`ls server-setup/*.sh`
fileArray=$(echo $fileString | tr " " "\n")
for file in $fileArray
do
    source $file
done
} > log.txt 2>error.txt

zip server.zip *.txt
mailx -s "Server Details" -a server.zip $email < emailFile.txt