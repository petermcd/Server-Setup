#!/usr/bin/env bash

password=$(generatePassword)

adduser -P $password dev