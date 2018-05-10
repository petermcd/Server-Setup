#!/usr/bin/env bash

email=""

yum -y install git
cd /root/
git clone https://github.com/AlexaBible/Server-Setup.git
cd Server-Setup/
{
find . -name "*.sh" -exec chmod +100 {} +
./server-setup.sh
} > log.txt 2>error.txt

 mailx -s "Server Details" -a server.zip email < emailFile.txt