#!/bin/sh

apt update
apt upgrade
apt install -y nginx
cd /var/www/html && curl -L https://github.com/Saverio001/jo-condor/releases/download/0.2/public.tgz | tar zxvf -
systemctl start nginx
systemctl enable nginx
