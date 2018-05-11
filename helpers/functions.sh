#!/bin/bash

function sendEmail(){
    to=$1
    from=$2
    subject=$3
    message=$4
    attach=$5
    if [ -z "$attach" ]
    then
        echo $message | mail -r $from -s $subject $to
    else
        #FIXME does not send attachment
        echo $message | mail -r $from -s $subject $to -a $file
    fi
}

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