#!/usr/bin/env bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Maria DB$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

cp server-setup/mariadb/MariaDB.repo /etc/yum.repos.d/MariaDB.repo
yum -y install MariaDB-server MariaDB-client

mysql_install_db --user=mysql

enableService mariadb

databasePassword=$(generatePassword)
mysqladmin -u root password "$databasePassword"
mysql -u root -p"$databasePassword" -e "UPDATE mysql.user SET Password=PASSWORD('$databasePassword') WHERE User='root'"
mysql -u root -p"$databasePassword" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
mysql -u root -p"$databasePassword" -e "DELETE FROM mysql.user WHERE User=''"
mysql -u root -p"$databasePassword" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
mysql -u root -p"$databasePassword" -e "FLUSH PRIVILEGES"

echo "Root database password: " $databasePassword >> ./emailFile.txt