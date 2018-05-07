#!/usr/bin/env bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Lets Encrypt$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

yum install letsencrypt

mkdir /etc/letsencrypt/cron/

#Copy the cron script
cp letsencrypt/letsencrypt-ss-renewal-cron.sh /etc/letsencrypt/cron/letsencrypt-ss-renewal.sh
sed -i '$ a\  0  0  *  *  * root       /etc/letsencrypt/cron/renew.sh' /etc/crontab