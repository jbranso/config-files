#!/bin/bash
# the variable _ is the command that bash is executing now
# $1 is the first argument to the command running now
# $2 is the second argument to the command running now

# echo ${_:5} will print the string from _ at position 5 to the end of the variable

#if the directory the user entered is a valid directory,
#then change to that directory
if [ -d $1 ]
then
    echo "$1 is a valid directory"
    echo "executing cd $1"
    cd $1
    echo "$(pwd)"
#otherwise, save the current working directory
#then cd to ~/, and test if the directory that the user entered,
#is located at ~/   If so, change to that directory. If not,
# then change to the current directory
else
    echo 'you did not enter a valid directory...checking ~/'
    current_directory=$(pwd)
    cd /home/joshua/
    if [ -d $1 ]
    then
	cd $1
    else
	echo "$1 not a valid directory in ~/ either"
	cd $current_directory
    fi

fi
