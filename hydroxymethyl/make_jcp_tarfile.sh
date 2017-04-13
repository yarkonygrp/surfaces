#!/bin/bash

# Make archive for JCP submission.

string=$(pwd);
echo "Curent directory: $string"
if [[ $string != *"surfaces" ]]; then
    echo "Must be in /path/to/surfaces/directory!"
    exit
fi

if [ $1 == "" ]; then
    echo "Must give name of system!"
    exit
fi

system=$1
if [ !-d "$string/$system" ]; then
    echo "Must give valid name of system!"
    exit
fi
