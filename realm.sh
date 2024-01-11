#!/bin/bash
systemctl stop realm
systemctl disable realm
rm /etc/systemd/system/realm.service -f
systemctl daemon-reload
systemctl reset-failed
rm /opt/realm/realm
mkdir -p /opt/realm
cd /opt/realm
uname -m | grep -qi x86_64 && oarch=x86_64-unknown-linux-gnu || oarch=aarch64-unknown-linux-gnu;
wget "$(curl -s https://api.github.com/repos/zhboner/realm/releases/latest|grep -i "browser_download_url.*${oarch}"|grep -i "gnu.tar.gz"|awk -F '"' '{print $(NF-1)}')";
tar -xzvf ./realm*.tar.gz
chmod +x ./realm
wget --no-check-certificate -O /etc/systemd/system https://raw.githubusercontent.com/FrankLiangCN/Realm/main/realm.service
wget --no-check-certificate -O /opt/realm https://raw.githubusercontent.com/FrankLiangCN/GOST/main/config.toml
cd ..
systemctl start realm
systemctl enable realm
