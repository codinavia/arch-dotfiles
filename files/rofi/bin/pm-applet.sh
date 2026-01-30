#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/rofi/themes"
rofi_command="rofi -theme $dir/pm-applet.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=' '
reboot=' '
lock=' '
suspend=''
logout=' '

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $HOME/.config/rofi/themes/confirm.rasi
}

# Message
msg() {
	rofi -theme "$HOME/.config/rofi/themes/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown) systemctl poweroff 
		;;
    $reboot) systemctl reboot
        ;;
    $lock) hyprlock
        ;;
    $suspend) systemctl suspend
        ;;
    $logout) hyprctl dispatch exit
        ;;
esac