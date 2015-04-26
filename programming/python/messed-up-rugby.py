#!/usr/bin/python
# Memory Limit:1024 MB
# Time Limit: 5 s
# Messed up Rugby (100 points)
# Introduction
# A team of developers from New York visits London and decides to try their hands at Rugby. None of
# them quite remember the exact rules so they just use the rules of American Football where you can
# score 2, 3 or 7 points at a time.
# When they talk to you afterwards, they tell you that the final score of the game was 38 - 0. After
# facepalming, you are curious to find all possible ways to score 38 points.
# Write a program that, given a score X, prints all possible combinations of the messed up conversions
# (7 points), tries (3 points), and kicks (2 points) that would make up this score.
# Input Specifications
# Your program will take a target score between 0 and 222.
# Output Specifications
# Based on the input, print out one row for each combination of messed up conversions, tries, and kicks
# that would get to that score, each column delimited by a space. The output should be in ascending
# order of touchdowns, field goals, and then safeties. If the score is not achievable, just output 0 0 0
# Sample Input/Output
# Input
# 10
# Output
# 0 0 5
# 0 2 2
# 1 1 0
# Explanation
# There are three possible ways to reach a score of 10 given the rules above.
# Input
# 17
# Output
# 0 1 7
# 0 3 4
# 0 5 1
# 1 0 5
# 1 2 2
# 2 1 0
# Explanation
# There are six possible ways to reach a score of 10 given the rules above.

from __future__ import print_function
import sys

data = sys.stdin.readlines()

print(data)
