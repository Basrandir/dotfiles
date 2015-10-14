#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:~/data/scripts
export PANEL_FIFO="/tmp/panel-fifo"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
