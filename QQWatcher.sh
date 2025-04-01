#!/bin/bash
echo "开始监听"
dbus-monitor "interface='org.freedesktop.Notifications'" | while read -r line; do
    # 检测到 Notify 方法
    if echo "$line" | grep -q 'member=Notify'; then
        # 初始化变量
        is_group=false
        content=""
        message_buffer=""
        finish=false

        # 读取完整的消息
        while read -r msg_line; do
            echo "$msg_line"

            if [ -z "$message_buffer" ] && ! echo "$msg_line" | grep -q 'QQ'; then
                echo "程序不匹配 => $msg_line"
                finish=true
                break
            fi

            # 如果遇到 "array ["，停止读取
            if echo "$msg_line" | grep -q 'array \['; then
                echo "消息结束 => $message_buffer"
                break
            fi

            # 将当前行添加到消息缓冲区
            if echo "$msg_line" | grep -q 'string'; then
                message_buffer+="$msg_line"$'\n'
            fi
        done

        if $finish; then
            continue
        fi

        # 提取消息内容
        cleaned_string=$(echo "$message_buffer" | sed 's/\n$//')
        content=$(echo "$cleaned_string" | tail -n 1)

        if echo "$content" | grep -q "："; then
            is_group=true
        fi

        # 判断消息类型和内容
        if [[ -n "$content" ]]; then
            if echo "$content" | grep -q '\[特别关心\]'; then
                echo "检测到特别关心消息: $content"
                paplay /usr/share/sounds/oxygen/stereo/dialog-warning.ogg # 特别关心音效
            else
                echo "检测到消息: $content"
                if $is_group; then
                    echo "这是一条群消息"
                    paplay /usr/share/sounds/freedesktop/stereo/bell.oga  # 普通群消息音效
                else
                    echo "这是一条普通消息"
#                     paplay /usr/share/sounds/ocean/stereo/button-pressed-modifier.oga  # 普通消息音效
                    paplay /usr/share/sounds/oxygen/stereo/device-added.ogg
                fi
            fi
        fi
    fi
done
