#!/usr/bin/bash

#control-mod-shift will make the nested x-session grab input
#control-shift will make it let go of the mouse

 Xephyr -ac -br -noreset -screen 1024x768 :1.0 &
 sleep 1


 DISPLAY=:1.0 qtile
