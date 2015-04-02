#!/bin/bash
output=$(ps aux | grep e\[m\]acs)
set -- $output
pid=$2
# renice emacs
renice -n -10 -p $pid

# output=$(ps aux | grep e\[m\]acs)
# set -- $output
# pid=$2
# # renice emacs
# renice -n -10 -p $pid
