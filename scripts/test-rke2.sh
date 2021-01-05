#!/bin/bash
BRIDGE_IP=$(ip address show dev eth1 scope global | awk '/inet / {split($2,var,"/"); print var[1]}')
wget -O /usr/local/bin/rke2 https://github.com/rancher/rke2/releases/download/v1.18.10+rke2r1/rke2.linux-amd64
chmod +x /usr/local/bin/rke2
/usr/local/bin/rke2 server
