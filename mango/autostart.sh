#! /bin/bash
# 自启动脚本 仅作参考

set +e

# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
/usr/lib/xdg-desktop-portal-wlr &

# scale
# wlr-randr --output eDP-1 --custom-mode 1920x1200@240Hz --scale 1
# wlr-randr --output eDP-1 --pos 0,0
# wlr-randr --output HDMI-A-1 --pos 2570,0 --custom-mode 2560x1440@120Hz



# notify
swaync -c $HOME/.config/mango/swaync/config.json -s $HOME/.config/mango/swaync/style.css &

# night light
wlsunset -T 3501 -t 3500 &

# wallpaper
swaybg -m fill -i "/home/mhh/Pictures/wallpapers/Anime-Girl-Night-Sky.jpg" &

# top bar
# waybar -c ~/.config/mango/waybar-config/simple/config -s ~/.config/mango/waybar-config/simple/style.css &
waybar -c ~/.config/mango/waybar-config/laptop/config -s ~/.config/mango/waybar-config/laptop/style.css &


# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
# xrdb merge ~/.Xresources

# ime input
fcitx5 --replace -d &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store & 

# bluetooth 
blueman-applet &

# network
nm-applet &

# Permission authentication
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# for private use not for you
# [ -e /dev/sda4 ] && udisksctl mount -t ext4 -b /dev/sda4
# cp ~/.config/eww/System-Menu/eww.yuck.hyprland  ~/.config/eww/System-Menu/eww.yuck
eww daemon -c $HOME/.config/mango/eww &

# idle to lightdown and shutdown screen
~/.config/mango/scripts/idle.sh &

# inhibit by audio
sway-audio-idle-inhibit &

# change light value and volume value by swayosd-client in keybind
swayosd-server &

# gsettings set org.gnome.desktop.interface scaling-factor 1.5
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5

