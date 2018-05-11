#!/bin/bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Nginx$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

#Install nginx from the official repo
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum -y install nginx

enableService nginx

#Allow http to send email
setsebool -P httpd_can_sendmail 1

#Enable http through the firewall
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --reload