# these 2 start up the Gnome-keyring daemon, which stores passwords, key, and certificates and makes 'em 
# available to applications. this enables me to push my files to github, without having to authenticate
# with every push
# https://wiki.archlinux.org/index.php/GNOME_Keyring#xinitrc_method
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

#run awesome
exec awesome

#run qtile
#exec qtile
