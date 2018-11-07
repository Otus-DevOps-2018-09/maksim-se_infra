#!/bin/bash 
###################################################################
#Script Name    : deploy.sh                                                                                          
#Description    : деплой приложения reddit                                                                                
#Args           : none                                                                                          
#Author         : Максим Серенков                                                
#Email          : mserenkov.m@gmail.com                                          
###################################################################

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
ps -ef | grep puma
