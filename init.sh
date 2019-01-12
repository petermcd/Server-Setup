#!/bin/bash

email=""
export email

yum -y install git
cd /root/
git clone https://github.com/PeterMcD/Server-Setup.git
cd Server-Setup/

find . -name "*.sh" -exec chmod +100 {} +
./server-setup.sh

cd ~

if [ $email ]
	then
		rm -rf *
fi