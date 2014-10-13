#!/bin/bash

cd /home/joshua

echo "working directory is /home/joshua"

string_of_modified_files=$(git status | gawk '/modified:/{ print $2}')

echo "string_of_modified_files == $string_of_modified_files"

# $(git status | grep -o 'modified:' | wc -l) == number of modified files

# This splits the string of modified files with a space between them,
# into an array...
# ie  string=( "hello" "how" "are" )
#IFS=' ' read -a array <<< $string
#now array[0] == "hello"
#array[1] == "how"
#array[2] == "are"

#IFS=' ' read -a array <<< $string_of_modified_files
# for element in 0 1 2 3
# do
#     echo "array[$element] ${array[$element]}"
# done

#This only stages files that are already tracked. It can't stage directoryies for some reason.
# it also is not adding new files that I create.

echo "$PATH"
echo "git add -f $string_of_modified_files"
git add -f $string_of_modified_files

echo "git commit -m Regular update. Commited files include... boring"
git commit -m "Regular update. Committed files include $string_of_modified_files"

echo "git push -u origin master"
git push -u origin master
