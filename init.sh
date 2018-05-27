#!/bin/bash

email=""
EXPORT email

yum -y install git
cd /root/
git clone https://github.com/AlexaBible/Server-Setup.git
cd Server-Setup/

find . -name "*.sh" -exec chmod +100 {} +
./server-setup.sh

cd /root/
#rm -rf *