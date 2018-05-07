#!/usr/bin/env bash

#First update the system
yum upgrade -y
yum -y install wget git
yum install epel* -y
yum upgrade -y