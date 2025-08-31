#!/usr/bin/bash

startd=$(pgrep waybar)

if [ -n "$startd" ]; then
	sudo pkill waybar
else
	waybar -c ~/.config/mango/waybar-config/simple/config -s ~/.config/mango/waybar-config/simple/style.css
fi
