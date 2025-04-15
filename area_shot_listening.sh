#!/bin/bash
FILE="/home/busyo/文档/EnhanceScript/shot.txt"

tail -F "$FILE" | while read -r line; do
#     echo "New line: $line"
    if [[ "$line" =~ "area_shot" ]]; then
        /home/busyo/文档/EnhanceScript/mouse_listening.sh &
    else
        pkill -f mouse_listening.sh
    fi
done
