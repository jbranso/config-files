#!/bin/bash
#update my mirrors.
sudo reflector --verbose --country 'United States' -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist
