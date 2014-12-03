#!/bin/bash
# deletes all versions of old files except the most recent 3.
paccache -r
# this removes all cached files for uninstalled packages.
paccache -ruk0
pacman-optimize
