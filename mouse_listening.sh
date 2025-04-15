#!/bin/bash

# 替换为你的鼠标设备路径
DEVICE="/dev/input/event7"

# 启动监听右键
stdbuf -oL evtest "$DEVICE" | while read -r line; do
    if [[ "$line" =~ "(BTN_RIGHT), value 1" ]]; then
        ydotool key 1:1 1:0
        break
    fi
done

exit 0
