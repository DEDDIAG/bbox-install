#!/bin/bash
set -e

SYSTEM_USER=pirate

if [[ -z "$SYSTEM_PASSWORD" ]]; then
    echo "Please provide system password"
    exit;
fi

if [[ -z "$HOUSE" ]]; then
    echo "Please provide house name"
    exit;
fi

if [[ -z "${REMOTE_HOST}" ]]; then
    echo "Please enter the remote host (e.g. example.com): "
    read REMOTE_HOST
else
    echo "Using current remote host: ${$REMOTE_HOST}"
fi

echo "$SYSTEM_USER:$SYSTEM_PASSWORD" | sudo chpasswd

# Upgrade system, python-setuptools, pip & docker-compose
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y python3-pip
sudo ln -sfn /usr/bin/pip3 /usr/bin/pip
sudo pip install -U docker-compose

# Setup bbox
git clone -b master https://github.com/deddiag/bbox.git /tmp/bbox
sudo mv /tmp/bbox /opt/bbox
sudo chown -R $SYSTEM_USER:$SYSTEM_USER /opt/bbox/
cd /opt/bbox
env HOUSE="$HOUSE" ./install.sh

# Pull all containers
docker-compose pull

sudo reboot
