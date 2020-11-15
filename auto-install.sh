#!/bin/bash
DOWNLOAD_LINK="https://github.com/pymumu/smartdns/releases/download/Release33/smartdns.1.2020.09.08-2235.x86-linux-all.tar.gz"
CONFIG_LINK="https://raw.githubusercontent.com/ly19811105/smartdns/master/etc/smartdns/smartdns.conf"

mkdir -p /tmp/smartdns
curl -L -o "/tmp/smartdns/smartdns.tar.gz" ${DOWNLOAD_LINK}
cd /tmp/smartdns/
tar zxf /tmp/smartdns/smartdns.tar.gz
chmod +x /tmp/smartdns/smartdns/install
sh /tmp/smartdns/smartdns/install -i
systemctl stop smartdns
curl -L -o "/etc/smartdns/smartdns.conf" ${CONFIG_LINK}
# update china domains
mkdir -p /tmp/smartdns/
wget -O /tmp/smartdns/china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
wget -O /tmp/smartdns/apple.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf
wget -O /tmp/smartdns/google.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf
#合并
cat /tmp/smartdns/apple.conf >> /tmp/smartdns/china.conf 2>/dev/null
cat /tmp/smartdns/google.conf >> /tmp/smartdns/china.conf 2>/dev/null
#删除不符合规则的域名
sed -i "s/^server=\/\(.*\)\/[^\/]*$/nameserver \/\1\/china/g;/^nameserver/!d" /tmp/smartdns/china.conf 2>/dev/null
mv -f /tmp/smartdns/china.conf  /etc/smartdns/smartdns-domains.china.conf
rm -rf /tmp/smartdns/
#/etc/init.d/smartdns restart
systemctl enable smartdns
systemctl start smartdns
