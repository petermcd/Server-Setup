#!/usr/bin/env bash

function generatePassword(){
    openssl rand -base64 32
}

password=$(generatePassword)

adduser -P $password dev