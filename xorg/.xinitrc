#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

theme=nHYOOnY
theme_path=$HOME/.gvcci/themes/$theme/xresources-colors.txt

if [ -f "$theme_path"  ]; then
    xrdb -merge "$theme_path"
fi

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xsetroot -cursor_name left_ptr &

setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'

compton --config "$HOME/.config/compton/compton.conf" &

session=${1:-bspwm}

case $session in
    bspwm           ) exec bspwm;;
    herbstluftwm    ) exec herbstluftwm;;
    windowchef      )
        sxhkd -c $HOME/.config/sxhkd/sxhkdrc_windowchef &
        exec windowchef
        ;;
    *           ) exec $1;;
esac
