#!/bin/bash

# 杀掉正在运行的 waybar
pkill -9 waybar

# 稍等一秒，避免残留进程
sleep 1

# 后台重新启动 waybar
waybar -c ~/.config/mango/waybar-config/laptop/config -s ~/.config/mango/waybar-config/laptop/style.css &


echo "✅ Waybar 已重启"

