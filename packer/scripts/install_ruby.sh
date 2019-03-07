#!/bin/bash 
###################################################################
#Script Name	: install_ruby.sh                                                                                             
#Description	: установка Ruby                                                                                
#Args           : none                                                                                          
#Author       	: Максим Серенков                                                
#Email         	: mserenkov.m@gmail.com                                          
###################################################################

# if not root, run as root
if (( $EUID != 0 )); then
    sudo apt update
    sudo apt -y upgrade
    sudo apt install -y ruby-full ruby-bundler build-essential
    exit
fi
apt update
apt -y upgrade
apt install -y ruby-full ruby-bundler build-essential
