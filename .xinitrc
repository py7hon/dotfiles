#!/bin/sh

# XDG Variables
export XDG_CONFIG_DIR="${HOME}/.config"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

feh --bg-scale ~/Pictures/background.jpg

pulseaudio&

picom&

xrdb ~/.Xresources

slstatus&

exec dwm
