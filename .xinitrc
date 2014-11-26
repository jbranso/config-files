# these 2 start up the Gnome-keyring daemon, which stores passwords, key, and certificates and makes 'em
# available to applications. this enables me to push my files to github, without having to authenticate
# with every push
# https://wiki.archlinux.org/index.php/GNOME_Keyring#xinitrc_method

# don't use this. I'm already a member of the wheel group. This next
# line is not needed.
#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
#export GPG_AGENT_INFO SSH_AUTH_SOCK

# this sets up polkit permissions, but it shouldn't be necessary for networkManager
# because I have added myself to the wheel group
#DO NOT UNCOMMENT the next link it will break stuff!
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

xmodmap ~/.xmodmaprc

#run awesome
exec awesome

#run gnome
#exec gnome-session
#exec env GNOME_SHELL_SESSION_MODE=classic gnome-session --session
#gnome-classic
