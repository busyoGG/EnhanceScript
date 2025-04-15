#!/bin/bash

# ========== 配置 ==========
GAME_NAME="VTube Studio.exe"
FACETRACKER_DIR="/home/busyo/文档/OpenSeeFace"
PYTHON_ENV="$FACETRACKER_DIR/env/bin/activate"
FACETRACKER_CMD="python facetracker.py -c 0 -W 1280 -H 720 --discard-after 0 --scan-every 0 --no-3d-adapt 1 --max-feature-updates 900"

# ========== 启动 facetracker ==========
cd "$FACETRACKER_DIR" || exit 1
source "$PYTHON_ENV"
$FACETRACKER_CMD &
FACETRACKER_PID=$!
echo "facetracker 启动完成，PID: $FACETRACKER_PID" >> /tmp/vts.txt

# ========== 监听所有游戏相关进程 ==========
echo "等待游戏进程：$GAME_NAME 启动..." >> /tmp/vts.txt

# 等待至少一个进程出现（最多 60 秒）
for i in {1..60}; do

    GAME_PIDS=""

    while read -r line; do
        pid=$(echo "$line" | awk '{print $2}')
        GAME_PIDS="$GAME_PIDS $pid"
    done < <(ps aux | grep -i "$GAME_NAME" | grep -v -e "$0" -e "$FACETRACKER_PID" -e "grep" -e "vts_track.sh")

    echo  "监听 $GAME_PIDS" >> /tmp/vts.txt
    if [ -n "$GAME_PIDS" ]; then
        echo "检测到游戏进程 PID(s): $GAME_PIDS" >> /tmp/vts.txt
        break
    fi
    sleep 1
done

if [ -z "$GAME_PIDS" ]; then
    echo "未检测到游戏进程，关闭 facetracker" >> /tmp/vts.txt
    kill "$FACETRACKER_PID"
    exit 1
fi

# ========== 持续监测所有进程 ==========
echo "监听游戏进程中，等待全部退出..." >> /tmp/vts.txt

while true; do
    ALL_EXITED=true
    for pid in $GAME_PIDS; do
        if kill -0 "$pid" 2>/dev/null; then
            ALL_EXITED=false
            break
        fi
    done

    if $ALL_EXITED; then
        echo "所有游戏进程已退出，关闭 facetracker" >> /tmp/vts.txt
        kill "$FACETRACKER_PID"
        break
    fi

    sleep 2
done
