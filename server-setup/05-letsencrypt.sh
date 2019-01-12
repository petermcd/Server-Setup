#!/bin/bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Lets Encrypt$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

yum -y install letsencrypt

mkdir /etc/letsencrypt/
mkdir /etc/letsencrypt/cron/

#Copy the cron script
cp server-setup/letsencrypt/letsencrypt-ss-renewal-cron.sh /etc/letsencrypt/cron/letsencrypt-ss-renewal.sh
chmod 700 /etc/letsencrypt/cron/letsencrypt-ss-renewal.sh

#Create cron job
addCronJob "/etc/letsencrypt/cron/renew.sh" "root" "0" "0" "*" "*" "*"