#!/bin/bash
echo -n "Enter the name of an animal: "
read ANIMAL
echo -n "The $ANIMAL has "
case $ANIMAL in
    horse | dog | cat) echo -n "four";;
    man | kangaroo ) echo -n "two";;
    # the *) is a pattern that ANIMAL will match
    # this is just a smooth way of doing something be default, if the above patters
    # do not match
    *) echo -n "an unknown number of";;
esac
echo " legs."
