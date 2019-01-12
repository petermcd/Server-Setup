#!/bin/bash

function replaceInFile(){
    search=$1
    replace=$2
    file=$3
    sed -i "s/$search/$replace/g" $file
}

function generatePassword(){
    openssl rand -base64 32
}

function enableService(){
    service=$1
    systemctl enable $service
    systemctl restart $service
}

function letsEncrypt(){
    domain=$1
    dir=/usr/share/nginx/$domain
    letsencrypt certonly -a webroot --webroot-path=$dir -d $domain
}

function addCronJob(){
	command=$1
	user=$2
	minute=$3
	hour=$4
	day=$5
	month=$6
	weekday=$7
	crontab -l > tempcron
	echo '$minute  $hour  $day  $month  $weekday $user       $command' >> tempcron
	crontab tempcron
	rm -f tempcron
}