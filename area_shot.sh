#!/bin/bash

# 设置截图文件路径
SCREENSHOT_PATH="/tmp/screenshot.png"

# 删除旧的截图文件，确保 spectacle 生成新文件
rm -f "$SCREENSHOT_PATH"

# 运行 spectacle 截图并输出到文件，后台执行
# /usr/bin/Snipaste snip -o "$SCREENSHOT_PATH" &
spectacle -b  -r  -o "$SCREENSHOT_PATH" &

# 获取 spectacle 进程的PID
SNIPASTE_PID=$!

echo "area_shot" > /home/busyo/文档/EnhanceScript/shot.txt

# 等待 spectacle 完成截图并退出
wait $SNIPASTE_PID

# 强制同步文件系统，确保文件完全写入磁盘
sync

echo "截图完成"

# 复制截图到剪贴板
echo -n "file://$SCREENSHOT_PATH" | wl-copy -t text/uri-list

echo "截图已复制到剪贴板 ✅"

echo "done" >  /home/busyo/文档/EnhanceScript/shot.txt
