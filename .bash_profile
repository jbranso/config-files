#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# I've just turned emacs ediff into something I can use!
function ediff() {
    if [ "X${2}" = "X" ]; then
	echo "USAGE: ediff <FILE 1> <FILE 2>"
    else
	# The --eval flag takes lisp code and evaluates it with EMACS
	emacs -q -nw --eval "(ediff-files \"$1\" \"$2\")"
    fi
}

#extend my path
PATH="/home/joshua/programming/bash:$PATH"
PACMAN="pacmatic"
DIFFEDITCMD="ediff"
pacdiff_program="ediff"
pacman_program="yaourt"

# This starts ssh-agent, which will remember my ssh password.
# though it does not seem to work.
# eval $(ssh-agent)
# ssh-add

export EMAIL="jbranso@purdue.edu"
export NAME="Joshua Branson"
export SMTPSERVER="smtp.purdue.edu"

export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=pygments

# export GTAGSLABEL=ctags

# if [ -r $PWD/.globalrc ]; then
#     GTAGSCONF=$PWD/.globalrc
# elif [ -r $HOME/.globalrc ]; then
#     GTAGSCONF=$HOME/.globalrc
# elif [ -r /usr/local/share/gtags/gtags.conf ]; then
#     GTAGSCONF=/usr/local/share/gtags/gtags.conf
# fi

# export GTAGSCONF

#if which mkid > /dev/null; then
#    gtags -I
#else
#    gtags
#fi

#If you're using arch linux check out https://wiki.archlinux.org/index.php/Automatic_login_to_virtual_console
#It shows you how to automatically log in at the end of the boot process.
#This automagically starts x after I log in
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
