#!/bin/bash

function hello () {
    pattern1='[hell]*o'
    pattern2='g[o]*dbye'
    if [[ $1 == $pattern1 ]] ; then
	echo "$1 to you to!" ;
    elif [[ $1 == $pattern2 ]] ; then
	echo "well $1 to you too." ;
    else echo "what?" ;
    fi
}

# this one is not working like the one above it is...
function otherHello () {
    pattern1='[hell]*o'
    pattern2='g[o]*dbye'
    case "$1" in
	$pattern1 | $pattern2 | $1 | "hello") echo "well $1 to you too." ;;
	    *) echo "you did not say hello or goodbye" ;;
    esac
    echo "$1"
}

echo "enter your first name."
read NAME
# this is supposed to tell you that you have a good name if you only use letters and no spaces or numbers...
# but if you enter "snttnh nhnthuo nhtht" It says that is a good name. weird.
if [[ $NAME == [a-zA-Z]* ]] ; then
echo "That looks like a good name";
else echo "That does not look like a good name";
fi

echo "insert your age"
read AGE
PATTERN='[0-9]*'
if [[ $AGE == $PATTERN ]] ; then
    if (($AGE < 5)) ; then
	echo "Are you old enough to play on a computer?";
    elif (($AGE >= 5 && $AGE < 25)) ; then
	echo "right on man!";
    elif (($AGE >= 25 && $AGE < 60)) ; then
	echo "looks like you are approaching adulthood";
    elif (($AGE >= 60 && $AGE < 100)) ; then
	echo "You might be very wise.";
    elif [ $AGE -gt 100 ] ; then
	echo "how are you still alive?";
    else echo "something weird happened";
    fi
else echo "you were supposed to enter a number you silly goose.";
fi

if ! [ 5 -gt 6 ] ; then
echo "5 is not > 6 ";
fi

# this creates a coprocess that is named thisProcess.
coproc thisProcess for (( number=5 ; number<10 ; number++ )) ;
do echo "You will never see this message." ;
done

echo "say hello or goodbye"
read helloOrGoodbye
hello $helloOrGoodbye
otherHello $otherHello

echo "Your first argument is $1"
echo "Your arguments were $@"

case "$#" in
    0) echo "You had 0 arguments" ;;
    1) echo "You have 1 argument" ;;
    *) echo "you had more than 1 argument" ;;
esac
echo "The had $# arguments"
echo "This shell's process id is $$"
echo "The most recent background job was $!"
echo "The last argument of the previous command was: $_"

array=(0 1 2 3 4 5 6 a b c d)
echo "The 7th element and on of the array is ${array[@]:7}"
echo "The 7th element of the array is ${array[@]:7:1}"

array2=(10 9 8 7 6 5 4 3 2 1)
echo ${!array*}
echo ${!array@}
echo "array2's indices are ${!array2[@]}"
echo "array2's indices are ${!array2[*]}"

string="Hello"
echo "The length of string is ${#string}"
