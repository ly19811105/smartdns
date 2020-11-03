#!/bin/bash
DOWNLOAD_LINK="https://github.com/pymumu/smartdns/releases/download/Release33/smartdns.1.2020.09.08-2235.x86-linux-all.tar.gz"
CONFIG_LINK="https://raw.githubusercontent.com/ly19811105/smartdns/master/etc/smartdns/smartdns.conf"

mkdir -p /tmp/smartdns
curl -L -o "/tmp/smartdns/smartdns.tar.gz" ${DOWNLOAD_LINK}

tar zxf /tmp/smartdns/smartdns.tar.gz
cd /tmp/smartdns/smartdns
chmod +x ./install
./install -i
systemctl stop smartdns
curl -L -o "/etc/smartdns/smartdns.conf" ${CONFIG_LINK}
systemctl enable smartdns
systemctl start smartdns
