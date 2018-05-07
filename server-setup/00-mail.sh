#!/usr/bin/env bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Postfix$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

yum -y remove sendmail
yum -y install postfix

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


host=`hostname`
separator="."
hostWithSeparator=${host}${separator}
fqdn=`hostname -f`
blank=""
domain="${fqdn/$hostWithSeparator/$blank}"

configFile="/etc/postfix/main.cf"

postfixReplace "#myhostname = host.domain.tld" "myhostname = $fqdn" $configFile
postfixReplace "#mydomain = domain.tld" "mydomain = $domain" $configFile
postfixReplace "#myorigin = \$myhostname" "myorigin = \$mydomain" $configFile
postfixReplace "#inet_interfaces = all" "inet_interfaces = all" $configFile
postfixReplace "mydestination = \$myhostname, localhost.\$mydomain, localhost" "mydestination = \$myhostname, localhost.\$mydomain, localhost, \$mydomain" $configFile
postfixReplace "#mynetworks = 168.100.189.0\/28, 127.0.0.0\/8" "mynetworks = $ip4\/32, 127.0.0.0\/8" $configFile
postfixReplace "#home_mailbox = Maildir\/" "home_mailbox = Maildir\/" $configFile

enableService postfix