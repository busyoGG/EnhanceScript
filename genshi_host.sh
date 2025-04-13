#!/bin/bash

echo "0.0.0.0 dispatchcnglobal.yuanshen.com" >> /etc/hosts

sleep 10
sed '/0.0.0.0 dispatchcnglobal.yuanshen.com/d' /etc/hosts > /tmp/hosts_modified
# 用修改后的文件替换原文件
cp /tmp/hosts_modified /etc/hosts

PROTON_RUN="/usr/share/steam/compatibilitytools.d/proton-ge-custom/files/bin/wine"
"$PROTON_RUN" /home/busyo/Games/WineSpace/YSWine/fps-unlocker/fpsunlock.exe 120 5000
