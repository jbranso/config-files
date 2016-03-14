#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# When I make the editor emacs -nw, I cannot edit my rc.lua by clicking on
# "edit config" in the menu.
export EDITOR="emacs -nw"
export SSHPASS="aMIhUmbleOGOd?"

# make pacmatic use ediff as its program to fix pacsaves.
export pacdiff_program="ediff"
# make emacs look nice when you run emacs -nw (or emacs --no-windows)
export TERM=xterm-256color

alias ls='ls --color=auto'
alias lls='ls --color=auto -la'

#pacman stuff
alias pac='sudo pacmatic -Syu; sudo paccache -r; sudo paccache -ruk0;'
# alias pac='sudo pacmatic -Syu; yaourt -Syua; yaourt -S firefox-nightly; pacman.bash'
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
alias server='ssh -p 31456 joshua@192.168.3.43'
alias sftpserver='sftp -P 31456 joshua@192.168.3.43'
alias purdue='sftp jbranso@mace.itap.purdue.edu'

if [ $UID -ne 0 ]
then
    alias shutdown='shutdown now'
    alias chown='sudo chown'
    alias chgrp='sudo chgrp'
    alias chmod='sudo chmod'
fi
alias wifi='nmtui'
alias cdrom='sudo mount /dev/sr0 /mnt/cdrom'
alias dvd='sudo mount /dev/sr0 /mnt/dvd; vlc'
alias mdvd='sudo mkdir /dev/dvd; sudo mount /dev/sr0 /dev/dvd; sudo  mplayer /dev/dvd;'

# I've just turned emacs ediff into something I can use!
# function ediff() {
#     if [ "X${2}" = "X" ]; then
#          echo "USAGE: ediff <FILE 1> <FILE 2>"
#     else
# 	# The --eval flag takes lisp code and evaluates it with EMACS
# 	emacs -nw -Q --eval "(ediff-files \"$1\" \"$2\") (load-theme 'wombat)"
#     fi
# }

#doesn't work
#alias ediff='emacs -nw -Q --eval "(ediff-files \"$1\" \"2\")"'

# retry aura as sudo arua
function a(){
    AURA="$(aura "$@")"

    if echo "$AURA" | grep -q '^aura >>= .*You have to use `.*sudo.*` for that.*$'
    then
        sudo aura "$@"
    else
        echo "$AURA"
    fi
}

# to shutdown the hurd as a normal user, issue reboot
#alias hurd='cd ~/programming/hurd/debian-gnu-hurd; qemu-system-i386 -drive file=debian-hurd-20150424.img,cache=writeback,format=raw --curses -cpu core2duo -smp 2 -m 1G -enable-kvm --no-reboot -no-kvm-irqchip'
alias hurd='cd ~/programming/hurd/; qemu-system-i386 -drive file=debian-hurd-20150320.img,cache=writeback,format=raw --curses -cpu core2duo -smp 2 -m 1G -enable-kvm --no-reboot -no-kvm-irqchip'


# I wast told to put these two lines here by the gpg documentation
# [[info:gnupg#Invoking%20GPG-AGENT][info:gnupg#Invoking GPG-AGENT]]
GPG_TTY=$(tty)
export GPG_TTY

#export my go path
export GOPATH=~/go

#emacs keeps complaning that it can't connect to dbus
#https://bugs.archlinux.org/task/5695
# https://stackoverflow.com/questions/26887888/connecting-to-dbus-from-emacs-daemon
export DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/dbus/system_bus_socket"

#something to do with autostarting.
PS1='[\u@\h \W]\$ '
