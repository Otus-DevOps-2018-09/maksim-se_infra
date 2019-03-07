#!/bin/bash 

fl_app_reddit='fl_app_reddit.run'

if [ -f ${fl_app_reddit} ]; then
  su - appuser -c 'cd ~;cd reddit; puma -d;'
  exit 0
fi

apt update
apt -y upgrade
apt install -y ruby-full ruby-bundler build-essential
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
apt update
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod
systemctl status mongod
su - appuser -c 'cd ~; git clone -b monolith https://github.com/express42/reddit.git; cd reddit && bundle install; puma -d;'
touch ${fl_app_reddit}
