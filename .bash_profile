#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#extend my path
PATH="/home/joshua/programming/bash:$PATH"

#This automagically starts awesome after I log in
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#If you're using arch linux check out https://wiki.archlinux.org/index.php/Automatic_login_to_virtual_console
#It shows you how to automatically log in at the end of the boot process.
