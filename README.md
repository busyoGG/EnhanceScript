|          文件           | 功能 |
|:-----------------------:|:----:|
|     active_shot.sh      | 活动窗口截图 |
|      area_shot.sh       | 指定区域截图 |
|     screen_shot.sh      | 全屏截图 |
|   full_screen_shot.sh   | 所有屏幕截图 |
|     genshin_host.sh     | 原神 host 脚本，需要设置 hosts 权限为可读写 |
|      QQWatcher.sh       | LinuxQQ 监听通知发送音效脚本 |
|   restart-network.sh    | Clash 重启脚本，防止连不上网，配合 sleep-restart.service 使用 |
|   mouse_listening.sh    | 监听鼠标右键，按下就执行 ESC 然后退出脚本 |
| area_shot_listening.sh  | spectacle 右键退出区域截图用的脚本（曲线救国），监听 shot.txt，如果是 area_shot 则启动 mouse_listening.sh |
| area_shot_mouse.service | area_shot_listening.sh 守护服务 |
|       orc_shot.sh       | ORC 截图识别脚本 |
|         orc.py          | ORC 识别脚本，需要 [paddleocr](https://paddlepaddle.github.io/PaddleOCR/latest/quick_start.html) |
|      vts_track.sh       | VTuber studio 摄像头通信脚本，在 steam 中添加到启动选项，启动应用就自动执行，关闭应用就自动杀死，需要 [Running VTS on Linux](https://github.com/DenchiSoft/VTubeStudio/wiki/Running-VTS-on-Linux) |