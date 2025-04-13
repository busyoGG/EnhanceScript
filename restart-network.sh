#!/bin/bash

log_file="/var/log/clash-wakeup.log"
echo "[$(date)][Hook] Restarting verge-mihomo-alpha..." >> "$log_file"

for i in {1..2}; do
    pid=$(pgrep -f verge-mihomo-alpha)
    echo "[$(date)][Hook] 查找进程 $pid" >> "$log_file"
    if [[ -n "$pid" ]]; then
        echo "[$(date)][Hook] Killing verge-mihomo-alpha pid=$pid" >> "$log_file"
        pkill -f verge-mihomo-alpha >> "$log_file" 2>&1
        if [ $? -eq 0 ]; then
            echo "[$(date)][Hook] pkill 成功" >> "$log_file"
        else
            echo "[$(date)][Hook] pkill 失败，退出码: $?" >> "$log_file"
        fi
        break
    else
        echo "[$(date)][Hook] 未找到进程" >> "$log_file"
    fi
    sleep 1
done

# 重启 mihomo
/usr/bin/verge-mihomo -d /home/busyo/.local/share/io.github.clash-verge-rev.clash-verge-rev -f /home/busyo/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml
