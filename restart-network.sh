#!/bin/bash

log_file="/var/log/clash-wakeup.log"
echo "[$(date)][Hook] Restarting verge-mihomo..." >> "$log_file"

for i in {1..30}; do
    pid=$(pgrep -f verge-mihomo)
    echo "[$(date)][Hook] 查找进程 $pid" >> "$log_file"
    if [[ -n "$pid" ]]; then
        echo "[$(date)][Hook] Killing verge-mihomo pid=$pid" >> "$log_file"
        pkill -f verge-mihomo >> "$log_file" 2>&1
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

# 启动 verge-mihomo
core_path="/usr/bin/verge-mihomo"
config_dir="/home/busyo/.local/share/io.github.clash-verge-rev.clash-verge-rev"
config_file="$config_dir/clash-verge.yaml"

if [[ -x "$core_path" ]]; then
    exec "$core_path" -d "$config_dir" -f "$config_file"
fi
