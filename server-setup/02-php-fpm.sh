#!/bin/bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing PHP-FPM$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

#Add the remi repository
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum-config-manager --enable remi-php73
yum update -y

#Install PHP-FPM and additional modules
yum -y --enablerepo=remi,remi-php73 install php-fpm php-common
yum -y --enablerepo=remi,remi-php73 install php-opcache php-pecl-apcu php-cli php-pdo php-pdo_mysql php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

enableService php-fpm

#Get Composer
wget https://getcomposer.org/installer
mv installer composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -rf composer-setup.php