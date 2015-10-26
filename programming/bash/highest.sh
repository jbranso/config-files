#!/usr/bin/bash

# sorts lines in a text file in ascending order
# usage is  highest filename [howmany]

filename=$1
filename=${filename:?" You did not enter a file name."}
howmany=${2:-10}

sort -nr $filename | head -$howmany
