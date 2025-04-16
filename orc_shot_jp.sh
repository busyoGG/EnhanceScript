#!/bin/bash

# 设置截图文件路径
SCREENSHOT_PATH="/tmp/screenshot_orc.png"

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

# 进入 PaddleOCR 目录
cd "/home/busyo/文档/PaddleORC"

# 激活虚拟环境
source myenv310/bin/activate

# 运行 OCR 并复制纯文字内容
ocr_result=$(python /home/busyo/文档/EnhanceScript/orc_jp.py | grep -vE '^\[|UserWarning')
echo "$ocr_result" | wl-copy  # 复制到剪贴板
notify-send -a "OCR 结果" "" "$ocr_result"  # 显示通知

echo "done" >  /home/busyo/文档/EnhanceScript/shot.txt
