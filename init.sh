#!/usr/bin/env bash

yum -y install git
cd /root/
git clone --bare https://github.com/AlexaBible/Server-Setup.git
cd Server-Setup/
find . -name "*.sh" -exec chmod +100 {} +
./server-setup.sh