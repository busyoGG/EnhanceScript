#!/bin/bash

FILE="/home/busyo/文档/EnhanceScript/shot_index.txt"

if [ ! -f "$FILE" ]; then
    echo "文件 $FILE 不存在，正在创建空文件..."
    echo 0 > "$FILE"
fi

content=$(cat "$FILE")

# 设置截图文件路径
SCREENSHOT_PATH="/tmp/screenshot${content}.png"

# 删除旧的截图文件，确保 spectacle 生成新文件
rm -f "$SCREENSHOT_PATH"

# 运行 spectacle 截图并输出到文件，后台执行
spectacle -b -m -o "$SCREENSHOT_PATH" &

# 获取 spectacle 进程的PID
SPECTACLE_PID=$!

# 等待 spectacle 完成截图并退出
wait $SPECTACLE_PID

# 强制同步文件系统，确保文件完全写入磁盘
sync

echo "截图完成"

if [ -f "$SCREENSHOT_PATH" ]; then
    echo "截图存在"

    # 复制截图到剪贴板
    echo -n "file://$SCREENSHOT_PATH" | wl-copy -t text/uri-list

    echo "截图已复制到剪贴板 ✅"

    ((content++))

    if [ $content -gt 10 ]; then content=0; fi

    echo $content > "$FILE"
fi
