#!/usr/bin/env bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Setting Up Lets Encrypt$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

function letsEncrypt(){
    domain=$1
    dir=/usr/share/nginx/$domain
    letsencrypt certonly -a webroot --webroot-path=$dir -d $domain
}