#!/bin/bash
systemctl stop realm
systemctl disable realm
rm /etc/systemd/system/realm.service -f
systemctl daemon-reload
systemctl reset-failed
rm /opt/realm/realm
mkdir -p /opt/realm
cd /opt/realm
uname -m | grep -qi oarch=x86_64-unknown-linux-gnu || aarch64 && oarch=arm-unknown-linux-gnu;
wget "$(curl -s https://api.github.com/repos/zhboner/realm/releases/latest|grep -i "browser_download_url.*${oarch}"|awk -F '"' '{print $(NF-1)}')";
tar -xzvf ./realm*.tar.gz
chmod +x ./realm
