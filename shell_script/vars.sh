#!/bin/sh

echo $0 # script name
echo $1 # first argument
echo $2 # second argument
echo $* # all arguments
echo $@ # all arguments

echo
printf "args: %s\n" $*

echo
printf "args: %s\n" $@

# echo $- # flags
# echo $! # background process number
# echo $$ # shell process number
