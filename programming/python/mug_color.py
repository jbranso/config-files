#!/usr/bin/python

# Memory Limit:1024 MB
# Time Limit: 5 s
# Mug Color (100 points)
# Introduction
# Jay S. has got himself in trouble! He had borrowed a friend's coffee mug and somehow lost it. As his
# friend will be extremely angry when he finds out about it, Jay has decided to buy his friend a replacement
# mug to try to control the damage.
# Unfortunately, Jay does not remember the color of the mug he had borrowed. He only knows that the
# color was one of White, Black, Blue, Red or Yellow.
# Jay goes around his office asking his colleagues if they are able to recall the color but his friends don't
# seem to remember the color of the mug either. What they do know is what color the mug definitely was
# not.
# Based on this information, help Jay figure out what the color of the mug was.
# Input Specifications
# Your program will take
# An input N (1 ≤ N ≤ 1,000,000) which denotes the number of people Jay questions regarding the
# mug.
# This will be followed by N strings S[1],S[2]...S[N] where S[I] denotes the response of person I to
# Jay's question which is what color the mug definitely was not. S[I] will also be only one of the 5
# colors namely White, Black, Blue, Red or Yellow.
# Output Specifications
# Based on the input, print out the color of the mug. The color of the mug can only be one of the 5 colors
# namely White, Black, Blue, Red or Yellow.
# You can safely assume that there always exists only one unique color that the mug can have.
# Sample Input/Output
# Input
# 4
# White
# Yellow
# Blue
# Black
# Output
# Red
# Explanation
# Jay's colleagues have mentioned every color except Red so the mug is Red in color
# Input
# 9
# White
# Yellow
# Blue
# Black
# Black
# White
# Yellow
# Blue
# Black
# Output
# Red
# Explanation
# Similar to the above case, the only color not mentioned is Red

from __future__ import print_function
import sys

white = True
black = True
blue = True
red = True
yellow = True

data = sys.stdin.readlines()

for line in data :
    if (line == "White\n"):
        white = False
    elif (line == "Black\n"):
        black = False
    elif (line == "Blue\n"):
        blue = False
    elif (line == "Red\n"):
        red = False
    elif (line == "Yellow\n"):
        yellow = False


if (white == True):
    print ("White")
elif (black == True):
    print ("Black")
elif (blue == True):
    print ("Blue")
elif (red == True):
    print ("Red")
elif (yellow == True):
    print ("Yellow")
