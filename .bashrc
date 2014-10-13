#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# When I make the editor emacs -nw, I cannot edit my rc.lua by clicking on
# "edit config" in the menu.
export EDITOR="emacs -nw"

alias ls='ls --color=auto'
alias lls='ls --color=auto -la'

#pacman stuff
alias pac='sudo pacmatic -Syu; yaourt -Syua'
alias pacman='pacmatic'
alias pacs="sudo pacmatic -S"
alias pacr="sudo pacmatic -Rs"
alias pacq="pacman -Q"
alias mirrorlist='sudo reflector --verbose --country "United States" -l 10 -p http --sort rate --save /etc/pacman.d/mirrorlist'

alias ..='cd ..'
alias ...='cd ../../'
alias c='clear'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mkdir='mkdir -pv'
alias mount='mount |column -t'
alias push='git push -u origin master'
alias emac='emacs -nw'
alias push='git push -u origin master'
alias semacs='sudo emacs -nw'
alias smounta="sudo mount -a"
alias smount="sudo mount"
alias srm="sudo rm"
alias srmr="sudo rm -r"
alias smkdir="sudo mkdir -pv"
alias scp="sudo cp"
alias spacmatic="sudo pacmatic"
#Auto open files
alias programmin="cd ~/programming"
alias manuals="cd ~/manuals"
alias cheat="cd ~/cheatsheats"
alias videos="cd ~/videos"
alias downloads="cd ~/downloads"
alias efstab="sudo emacs -nw /etc/fstab"
alias ebashrc="sudo emacs -nw ~/.bashrc"
alias ebashprofile="sudo emacs -nw ~/.bash_profile"
alias grubmkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias egrub="semacs -nw /etc/default/grub"
alias emirrorlist="sudo emacs -nw /etc/pacman.d/mirrorlist"
alias evconsole="sudo emacs -nw /etc/vconsole.conf"
alias eawesome="sudo emacs -nw /home/joshua/.config/awesome"
alias emkinitcpio="sudo emacs -nw /etc/mkinitcpio.conf"
alias mkinitcpio="sudo mkinitcpio -p linux"

alias sshutdown='shutdown now'
alias schown='sudo chown'
alias schgrp='sudo chgrp'
alias schmod='sudo chmod'


if [ $UID -ne 0 ]
then
    alias shutdown='shutdown now'
    alias chown='sudo chown'
    alias chgrp='sudo chgrp'
    alias chmod='sudo chmod'
fi
PS1='[\u@\h \W]\$ '
